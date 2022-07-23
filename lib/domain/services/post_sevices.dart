import "dart:convert";

import "package:flutter_test_application/domain/data_providers/api_cleint/api_repository.dart";
import "package:flutter_test_application/domain/data_providers/local_storage/local_data_provider.dart";
import "package:flutter_test_application/domain/entity/post/post_model.dart";

class PostService {
  final ApiRepository _apiClient;
  final LocalDataProvider _localDataProvider;

  PostService(
    this._apiClient,
    this._localDataProvider,
  );

  List<Post> makePosts(String newPosts) {
    try {
      final dynamic _posts = jsonDecode(newPosts);
      final List<Post> posts = (_posts as List<dynamic>)
          .map((dynamic post) => Post.fromJson(post as Map<String, dynamic>))
          .toList();
      return posts;
    } catch (e) {
      return <Post>[];
    }
  }

  Future<List<Post>> getPostbyId(int id) async {
    final String? localPosts = _localDataProvider.checkPosts(id);

    if (localPosts != null) {
      return makePosts(localPosts);
    }

    final List<Post>? posts = await _apiClient.fetchPosts(id);
    if (posts == null) {
      return <Post>[];
    }
    final String postString =
        jsonEncode(posts.map((Post post) => post.toJson()).toList());
    _localDataProvider.savePosts(postString, id);
    return posts;
  }
}
