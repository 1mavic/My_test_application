import "dart:convert";

import "package:flutter_test_application/domain/data_providers/api_client.dart";
import "package:flutter_test_application/domain/data_providers/local_data_provider.dart";
import "package:flutter_test_application/domain/entity/album/album_model.dart";

class AlbumService {
  final ApiClient _apiClient = ApiClient();
  final LocalDataProvider _localDataProvider = LocalDataProvider();

  List<Album> makeAlbums(String newAlbums) {
    try {
      final dynamic _albums = jsonDecode(newAlbums);
      final List<Album> albums = (_albums as List)
          .map((dynamic album) => Album.fromJson(album as Map<String, dynamic>))
          .toList();
      return albums;
    } catch (e) {
      return <Album>[];
    }
  }

  Future<List<Album>> getUserAlbum(int userId) async {
    final String? localAlbums = _localDataProvider.checkAlbums(userId);

    if (localAlbums != null) {
      return makeAlbums(localAlbums);
    }

    final List<Album>? albums = await _apiClient.fetchUserAlbums(userId);
    if (albums == null) {
      return <Album>[];
    }
    final String albumString =
        jsonEncode(albums.map((Album albums) => albums.toJson()).toList());
    _localDataProvider.saveAlbums(albumString, userId);
    return albums;
  }
}
