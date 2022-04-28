import "dart:convert";

import "package:flutter_test_application/domain/data_providers/api_client.dart";
import "package:flutter_test_application/domain/data_providers/local_data_provider.dart";
import "package:flutter_test_application/domain/entity/comment/comment_model.dart";

class CommentService {
  final ApiClient _apiClient = ApiClient();
  final LocalDataProvider _localDataProvider = LocalDataProvider();

  List<Comment> makeAlbums(String newComments) {
    try {
      final dynamic _comments = jsonDecode(newComments);
      final List<Comment> coments = (_comments as List)
          .map(
            (dynamic coments) =>
                Comment.fromJson(coments as Map<String, dynamic>),
          )
          .toList();
      return coments;
    } catch (e) {
      return <Comment>[];
    }
  }

  Future<List<Comment>> getPostbyId(int id) async {
    final String? localComments = _localDataProvider.checkComments(id);

    if (localComments != null) {
      return makeAlbums(localComments);
    }

    final List<Comment>? comments = await _apiClient.fetchCommentsToPost(id);
    if (comments == null) {
      return <Comment>[];
    }
    final String commentsString =
        jsonEncode(comments.map((Comment albums) => albums.toJson()).toList());
    _localDataProvider.saveComments(commentsString, id);
    return comments;
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
