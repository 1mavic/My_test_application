import "package:flutter_test_application/domain/data_providers/api_client.dart";
import 'package:flutter_test_application/domain/entity/album/album_model.dart';
import 'package:flutter_test_application/domain/entity/photo/photo_model.dart';
import "package:flutter_test_application/domain/entity/post/post_model.dart";

class PhotoService {
  final ApiClient _apiClient = ApiClient();

  Future<List<Photo>> getAlbumPhotos(int albumId) async {
    final List<Photo>? photos = await _apiClient.fetchAlbumPhotos(albumId);
    return photos ?? <Photo>[];
  }
}
