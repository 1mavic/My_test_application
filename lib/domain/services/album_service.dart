import "package:flutter_test_application/domain/data_providers/api_client.dart";
import 'package:flutter_test_application/domain/entity/album/album_model.dart';
import "package:flutter_test_application/domain/entity/post/post_model.dart";

class AlbumService {
  final ApiClient _apiClient = ApiClient();

  Future<List<Album>> getUserAlbum(int userId) async {
    final List<Album>? albums = await _apiClient.fetchUserAlbums(userId);
    return albums ?? <Album>[];
  }
}
