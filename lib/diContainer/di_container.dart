import "package:dio/dio.dart";
import "package:flutter_test_application/config/environment.dart";
import "package:flutter_test_application/domain/data_providers/api_cleint/api_repository.dart";
import "package:flutter_test_application/domain/data_providers/api_cleint/dio_api_client.dart";
import "package:flutter_test_application/domain/data_providers/local_storage/local_data_provider.dart";
import "package:flutter_test_application/domain/services/album_service.dart";
import "package:flutter_test_application/domain/services/comment_service.dart";
import "package:flutter_test_application/domain/services/photo_service.dart";
import "package:flutter_test_application/domain/services/post_sevices.dart";
import "package:flutter_test_application/domain/services/user_service.dart";

class DiContainer {
  DiContainer();
  static final String _baseUrl = env.apiUrl;
  static final ApiClient _apiClient =
      DioApi(_baseUrl, <Interceptor>[CustomInterceptors()]);
  final ApiRepository _apiRepository = ApiRepository(_apiClient);
  final LocalDataProvider _localDataProvider = HiveDataProvider();

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
