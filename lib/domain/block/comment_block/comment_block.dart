import "package:flutter_bloc/flutter_bloc.dart";
import "package:flutter_test_application/domain/block/comment_block/comment_stat.dart";
import "package:flutter_test_application/domain/entity/comment/comment_model.dart";
import "package:flutter_test_application/domain/services/comment_service.dart";

abstract class CommentEvent {}

class GetCommentsEvent extends CommentEvent {
  final int id;

  GetCommentsEvent(this.id);
}

class CommentBlock extends Bloc<CommentEvent, CommentScreenState> {
  List<Comment> _comments = <Comment>[];

  List<Comment> get comments => _comments;

  final CommentService _commentService = CommentService();
  CommentBlock() : super(CommentLoadingState()) {
    on<GetCommentsEvent>(
        (GetCommentsEvent event, Emitter<CommentScreenState> emit) async {
      emit(CommentLoadingState());
      final List<Comment> _commentList =
          await _commentService.getPostbyId(event.id);
      _comments = _commentList;
      emit(CommentListObtainedState());
      return;
    });
  }
}
