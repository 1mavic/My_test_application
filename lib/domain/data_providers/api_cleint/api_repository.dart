import "dart:developer";
import "package:flutter_test_application/domain/data_providers/api_cleint/dio_api_client.dart";
import "package:flutter_test_application/domain/entity/album/album_model.dart";
import "package:flutter_test_application/domain/entity/comment/comment_model.dart";
import "package:flutter_test_application/domain/entity/photo/photo_model.dart";
import "package:flutter_test_application/domain/entity/post/post_model.dart";
import "package:flutter_test_application/domain/entity/user/user_model.dart";

class ApiRepository {
  final ApiClient _apiClient;
  // final String _baseUrl = env.apiUrl;

  ApiRepository(this._apiClient);

  Future<List<User>?> fetchUsers() async {
    try {
      final dynamic response = await _apiClient.get("/users");
      final List<User> users = (response as List<dynamic>? ?? <dynamic>[])
          .map(
            (dynamic user) => User.fromJson(
              user as Map<String, dynamic>,
            ),
          )
          .toList();
      return users;
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  Future<List<Post>?> fetchPosts(int userId) async {
    try {
      final dynamic response = await _apiClient.get("/posts?userId=$userId");
      final List<Post> posts = (response as List<dynamic>? ?? <dynamic>[])
          .map(
            (dynamic posts) => Post.fromJson(
              posts as Map<String, dynamic>,
            ),
          )
          .toList();
      return posts;
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  Future<List<Comment>?> fetchCommentsToPost(int postId) async {
    try {
      final dynamic response = await _apiClient.get("/comments?postId=$postId");
      final List<Comment> comments = (response as List<dynamic>? ?? <dynamic>[])
          .map(
            (dynamic comment) => Comment.fromJson(
              comment as Map<String, dynamic>,
            ),
          )
          .toList();
      return comments;
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  Future<List<Album>?> fetchUserAlbums(int userId) async {
    try {
      final dynamic response = await _apiClient.get("/albums?userId=$userId");
      final List<Album> albums = (response as List<dynamic>? ?? <dynamic>[])
          .map(
            (dynamic album) => Album.fromJson(
              album as Map<String, dynamic>,
            ),
          )
          .toList();
      return albums;
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  Future<List<Photo>?> fetchAlbumPhotos(int albumId) async {
    try {
      final dynamic response = await _apiClient.get("/photos?albumId=$albumId");
      final List<Photo> photos = (response as List<dynamic>? ?? <dynamic>[])
          .map(
            (dynamic photos) => Photo.fromJson(photos as Map<String, dynamic>),
          )
          .toList();
      return photos;
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  Future<int?> sendComment(Comment newComment) async {
    try {
      final dynamic response = await _apiClient.post(
        "/comments",
        queryParameters: <String, dynamic>{
          "postId": newComment.postId,
          "name": newComment.name,
          "email": newComment.email,
          "body": newComment.body
        },
      );
      if (response != null) {
        final Map<String, dynamic> _data = response as Map<String, dynamic>;
        final int _id = _data["id"] as int;
        return _id;
      }
      return null;
    } catch (e) {
      log(e.toString());
      return null;
    }
  }
}
