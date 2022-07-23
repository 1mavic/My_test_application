import "package:flutter_bloc/flutter_bloc.dart";
import 'package:flutter_test_application/domain/bloc/post_bloc/posts_state.dart';
import "package:flutter_test_application/domain/entity/post/post_model.dart";
import "package:flutter_test_application/domain/services/post_sevices.dart";

abstract class PostsEvent {}

class GetPostsEvent extends PostsEvent {
  final int id;

  GetPostsEvent(this.id);
}

class PostBloc extends Bloc<PostsEvent, PostScreenState> {
  List<Post> _posts = <Post>[];

  List<Post> get posts => _posts;

  final PostService _postservice = PostService();
  PostBloc() : super(PostLoadingState()) {
    on<GetPostsEvent>(
        (GetPostsEvent event, Emitter<PostScreenState> emit) async {
      emit(PostLoadingState());
      final List<Post> _postsList = await _postservice.getPostbyId(event.id);
      if (_postsList.isEmpty) {
        emit(PostErrorState(error: "Получен пустой список пользователей"));
        return;
      }
      _posts = _postsList;
      emit(PostListObtainedState());
      return;
    });
  }
}
