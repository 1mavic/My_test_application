import "package:flutter_test_application/domain/data_providers/api_client.dart";
import "package:flutter_test_application/domain/entity/comment/comment_model.dart";

class CommentService {
  final ApiClient _apiClient = ApiClient();

  Future<List<Comment>> getPostbyId(int id) async {
    final List<Comment>? comments = await _apiClient.fetchCommentsToPost(id);
    return comments ?? <Comment>[];
  }

  Future<int?> sendComment(
    int postId,
    String name,
    String email,
    String comment,
  ) async {
    final int? id = await _apiClient.sendComment(
      Comment(
        id: 0,
        postId: postId,
        email: email,
        name: name,
        body: comment,
      ),
    );
    return id;
  }
}
