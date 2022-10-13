import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:my_app/domain/bloc/album_bloc/album_bloc.dart";
import "package:my_app/domain/bloc/album_bloc/album_state.dart";
import "package:my_app/domain/bloc/post_bloc/post_bloc.dart";
import "package:my_app/domain/bloc/post_bloc/posts_state.dart";
import "package:my_app/domain/entity/album/album_model.dart";
import "package:my_app/domain/entity/post/post_model.dart";
import "package:my_app/domain/entity/user/user_model.dart";
import "package:my_app/navigation/routes.dart";
import "package:my_app/ui/widgets/card_widget.dart";
import "package:my_app/ui/widgets/preview_list_widget.dart";
import "package:my_app/ui/widgets/scaffold_template_widget.dart";
import "package:my_app/ui/widgets/user_card_widget.dart";

class UserInfoScreen extends StatelessWidget {
  const UserInfoScreen({super.key, required this.user});
  final User user;
  @override
  Widget build(BuildContext context) {
    return ScaffoldBodyTemplateWidget(
      appBarTitle: user.userName,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            UserCardWidget(
              user: user,
              small: false,
            ),
            const _PostList(),
            const SizedBox(
              height: 10,
            ),
            const _AlbumList()
          ],
        ),
      ),
    );
  }
}

class _PostList extends StatelessWidget {
  const _PostList();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PostBloc, PostScreenState>(
      builder: (BuildContext context, PostScreenState state) {
        switch (state.runtimeType) {
          case PostLoadingState:
            final PostLoadingState currentState = state as PostLoadingState;
            return CardWidget(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      currentState.message,
                      style: const TextStyle(color: Colors.black),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    const CircularProgressIndicator.adaptive()
                  ],
                ),
              ),
            );
          case PostErrorState:
            final PostErrorState currentState = state as PostErrorState;
            return CardWidget(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      currentState.error,
                      style: const TextStyle(color: Colors.black),
                    ),
                  ],
                ),
              ),
            );
          case PostListObtainedState:
            final List<Post> posts = context.watch<PostBloc>().posts;
            return PreviewWidget<Post>(
              items: posts,
              routeToList: AppRoutes.userPostsAll,
              routeToDetail: AppRoutes.userPostInfo,
              small: true,
            );
          default:
            return const SizedBox.shrink();
        }
      },
    );
  }
}

class _AlbumList extends StatelessWidget {
  const _AlbumList();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AlbumBloc, AlbumScreenState>(
      builder: (BuildContext context, AlbumScreenState state) {
        switch (state.runtimeType) {
          case AlbumLoadingState:
            final AlbumLoadingState currentState = state as AlbumLoadingState;
            return CardWidget(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      currentState.message,
                      style: const TextStyle(color: Colors.black),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    const CircularProgressIndicator.adaptive()
                  ],
                ),
              ),
            );
          case AlbumErrorState:
            final AlbumErrorState currentState = state as AlbumErrorState;
            return CardWidget(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      currentState.error,
                      style: const TextStyle(color: Colors.black),
                    ),
                  ],
                ),
              ),
            );
          case AlbumListObtainedState:
            final List<Album> albums = context.watch<AlbumBloc>().albums;
            return PreviewWidget<Album>(
              items: albums,
              routeToList: AppRoutes.userAlbums,
              routeToDetail: AppRoutes.userAlbumInfo,
              small: true,
            );
          default:
            return const SizedBox.shrink();
        }
      },
    );
  }
}
