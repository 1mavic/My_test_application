import "package:flutter_test_application/domain/data_providers/api_client.dart";
import "package:flutter_test_application/domain/entity/post/post_model.dart";

class PostService {
  final ApiClient _apiClient = ApiClient();

  Future<List<Post>> getPostbyId(int id) async {
    final List<Post>? posts = await _apiClient.fetchPosts(id);
    return posts ?? <Post>[];
  }
}
