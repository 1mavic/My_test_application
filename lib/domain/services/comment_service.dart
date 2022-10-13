import "dart:convert";

import "package:my_app/domain/data_providers/api_cleint/api_repository.dart";
import "package:my_app/domain/data_providers/local_storage/local_data_provider.dart";
import "package:my_app/domain/entity/comment/comment_model.dart";

class CommentService {
  final ApiRepository _apiClient;
  final LocalDataProvider _localDataProvider;

  CommentService(
    this._apiClient,
    this._localDataProvider,
  );

  List<Comment> makeAlbums(String newComments) {
    try {
      final dynamic commentsJson = jsonDecode(newComments);
      final List<Comment> coments = (commentsJson as List<dynamic>)
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

  void saveComment(
    List<Comment> comments,
  ) {
    final String commentsString =
        jsonEncode(comments.map((Comment albums) => albums.toJson()).toList());
    _localDataProvider.saveComments(commentsString, comments.first.postId);
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
