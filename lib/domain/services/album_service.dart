import "dart:convert";

import "package:my_app/domain/data_providers/api_cleint/api_repository.dart";
import "package:my_app/domain/data_providers/local_storage/local_data_provider.dart";
import "package:my_app/domain/entity/album/album_model.dart";

class AlbumService {
  final ApiRepository _apiClient;
  final LocalDataProvider _localDataProvider;

  AlbumService(
    this._apiClient,
    this._localDataProvider,
  );

  List<Album> makeAlbums(String newAlbums) {
    try {
      final dynamic albumsJson = jsonDecode(newAlbums);
      final List<Album> albums = (albumsJson as List<dynamic>)
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
