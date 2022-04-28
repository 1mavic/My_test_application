import "package:flutter_test_application/domain/data_providers/api_client.dart";
import "package:flutter_test_application/domain/entity/comment/comment_model.dart";

class CommentService {
  final ApiClient _apiClient = ApiClient();

  Future<List<Comment>> getPostbyId(int id) async {
    final List<Comment>? comments = await _apiClient.fetchCommentsToPost(id);
    return comments ?? <Comment>[];
  }
}
