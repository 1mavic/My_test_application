import "dart:convert";

import "package:my_app/domain/data_providers/api_cleint/api_repository.dart";
import "package:my_app/domain/data_providers/local_storage/local_data_provider.dart";
import "package:my_app/domain/entity/post/post_model.dart";

class PostService {
  final ApiRepository _apiClient;
  final LocalDataProvider _localDataProvider;

  PostService(
    this._apiClient,
    this._localDataProvider,
  );

  List<Post> makePosts(String newPosts) {
    try {
      final dynamic postsJson = jsonDecode(newPosts);
      final List<Post> posts = (postsJson as List<dynamic>)
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
