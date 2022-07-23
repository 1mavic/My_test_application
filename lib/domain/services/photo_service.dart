import "package:flutter_test_application/domain/data_providers/api_cleint/api_repository.dart";
import "package:flutter_test_application/domain/entity/photo/photo_model.dart";

class PhotoService {
  final ApiRepository _apiClient;

  PhotoService(this._apiClient);

  Future<List<Photo>> getAlbumPhotos(int albumId) async {
    final List<Photo>? photos = await _apiClient.fetchAlbumPhotos(albumId);
    return photos ?? <Photo>[];
  }
}
