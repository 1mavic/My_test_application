import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:flutter_test_application/domain/bloc/album_bloc/album_bloc.dart";
import "package:flutter_test_application/domain/bloc/album_bloc/album_state.dart";
import "package:flutter_test_application/domain/bloc/post_bloc/post_bloc.dart";
import "package:flutter_test_application/domain/bloc/post_bloc/posts_state.dart";
import "package:flutter_test_application/domain/entity/album/album_model.dart";
import "package:flutter_test_application/domain/entity/post/post_model.dart";
import "package:flutter_test_application/domain/entity/user/user_model.dart";
import "package:flutter_test_application/navigation/routes.dart";
import "package:flutter_test_application/ui/widgets/card_widget.dart";
import "package:flutter_test_application/ui/widgets/preview_list_widget.dart";
import "package:flutter_test_application/ui/widgets/scaffold_template_widget.dart";
import "package:flutter_test_application/ui/widgets/user_card_widget.dart";

class UserInfoScreen extends StatelessWidget {
  const UserInfoScreen({Key? key, required this.user}) : super(key: key);
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
  const _PostList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PostBloc, PostScreenState>(
      builder: (BuildContext context, PostScreenState state) {
        switch (state.runtimeType) {
          case PostLoadingState:
            final PostLoadingState _state = state as PostLoadingState;
            return CardWidget(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      _state.message,
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
            final PostErrorState _state = state as PostErrorState;
            return CardWidget(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      _state.error,
                      style: const TextStyle(color: Colors.black),
                    ),
                  ],
                ),
              ),
            );
          case PostListObtainedState:
            final List<Post> _posts = context.watch<PostBloc>().posts;
            return PreviewWidget<Post>(
              items: _posts,
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
  const _AlbumList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AlbumBloc, AlbumScreenState>(
      builder: (BuildContext context, AlbumScreenState state) {
        switch (state.runtimeType) {
          case AlbumLoadingState:
            final AlbumLoadingState _state = state as AlbumLoadingState;
            return CardWidget(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      _state.message,
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
            final AlbumErrorState _state = state as AlbumErrorState;
            return CardWidget(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      _state.error,
                      style: const TextStyle(color: Colors.black),
                    ),
                  ],
                ),
              ),
            );
          case AlbumListObtainedState:
            final List<Album> _albums = context.watch<AlbumBloc>().albums;
            return PreviewWidget<Album>(
              items: _albums,
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
