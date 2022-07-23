import "package:flutter_bloc/flutter_bloc.dart";
import 'package:flutter_test_application/domain/bloc/comment_bloc/comment_stat.dart';
import "package:flutter_test_application/domain/entity/comment/comment_model.dart";
import "package:flutter_test_application/domain/services/comment_service.dart";

abstract class CommentEvent {}

class GetCommentsEvent extends CommentEvent {
  final int id;

  GetCommentsEvent(this.id);
}

class SendCommentEvent extends CommentEvent {
  final String name;
  final String email;
  final String comment;

  SendCommentEvent(this.name, this.email, this.comment);
}

class CommentBloc extends Bloc<CommentEvent, CommentScreenState> {
  List<Comment> _comments = <Comment>[];

  List<Comment> get comments => _comments;

  final CommentService _commentService = CommentService();
  CommentBloc() : super(CommentLoadingState()) {
    on<GetCommentsEvent>(
        (GetCommentsEvent event, Emitter<CommentScreenState> emit) async {
      emit(CommentLoadingState());
      final List<Comment> _commentList =
          await _commentService.getPostbyId(event.id);
      _comments = _commentList;
      emit(CommentListObtainedState());
      return;
    });
    on<SendCommentEvent>(
        (SendCommentEvent event, Emitter<CommentScreenState> emit) async {
      // emit(CommentLoadingState());
      final int? id = await _commentService.sendComment(
        _comments.first.postId,
        event.name,
        event.email,
        event.comment,
      );
      if (id != null) {
        emit(CommentLoadingState());
        _comments.insert(
          0,
          Comment(
            id: id,
            postId: _comments.first.postId,
            email: event.email,
            name: event.name,
            body: event.comment,
          ),
        );
        _commentService.saveComment(_comments);

        emit(CommentListObtainedState());
      }
      return;
    });
  }
}
