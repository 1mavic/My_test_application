import "package:dio/dio.dart";
import "package:my_app/config/environment.dart";
import "package:my_app/domain/data_providers/api_cleint/api_repository.dart";
import "package:my_app/domain/data_providers/api_cleint/dio_api_client.dart";
import "package:my_app/domain/data_providers/local_storage/local_data_provider.dart";
import "package:my_app/domain/services/album_service.dart";
import "package:my_app/domain/services/comment_service.dart";
import "package:my_app/domain/services/photo_service.dart";
import "package:my_app/domain/services/post_sevices.dart";
import "package:my_app/domain/services/user_service.dart";

class DiContainer {
  DiContainer();
  static final String _baseUrl = env.apiUrl;
  static final ApiClient _apiClient =
      DioApi(_baseUrl, <Interceptor>[CustomInterceptors()]);
  final ApiRepository _apiRepository = ApiRepository(_apiClient);
  final LocalDataProvider _localDataProvider = HiveDataProvider();

  LocalDataProvider get dataProvider => _localDataProvider;

  ApiRepository makeApiRepository() => _apiRepository;

  UserService makeUserService() => UserService(
        _apiRepository,
        _localDataProvider,
      );

  PostService makePostService() => PostService(
        _apiRepository,
        _localDataProvider,
      );
  AlbumService makeAlbumService() => AlbumService(
        _apiRepository,
        _localDataProvider,
      );
  CommentService makeCommentService() => CommentService(
        _apiRepository,
        _localDataProvider,
      );
  PhotoService makePhotoService() => PhotoService(_apiRepository);
}
