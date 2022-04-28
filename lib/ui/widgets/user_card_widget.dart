import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:flutter_test_application/domain/block/post_block/post_block.dart";
import "package:flutter_test_application/domain/block/post_block/posts_state.dart";
import "package:flutter_test_application/domain/entity/post/post_model.dart";
import "package:flutter_test_application/domain/entity/user/user_model.dart";
import "package:flutter_test_application/navigation/routes.dart";
import "package:flutter_test_application/ui/widgets/card_widget.dart";
import "package:flutter_test_application/ui/widgets/posts_widget.dart";

class UserCardWidget extends StatelessWidget {
  const UserCardWidget({Key? key, required this.user, required this.small})
      : super(key: key);
  final User user;
  final bool small;
  @override
  Widget build(BuildContext context) {
    final Widget _body = Column(
      children: <Widget>[
        CardWidget(
          child: small
              ? GestureDetector(
                  onTap: () {
                    if (!small) {
                      return;
                    }
                    Navigator.of(context)
                        .pushNamed(AppRoutes.userInfo, arguments: user);
                  },
                  child: _SmallWidget(user: user),
                )
              : _BigWidget(
                  user: user,
                ),
        ),
        if (!small) const _PostList()
      ],
    );

    return small
        ? _body
        : SingleChildScrollView(
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: _body,
          );
  }
}

class _SmallWidget extends StatelessWidget {
  const _SmallWidget({
    Key? key,
    required this.user,
  }) : super(key: key);

  final User user;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text("User name: ${user.userName}"),
        Text("Name: ${user.name}"),
      ],
    );
  }
}

class _BigWidget extends StatelessWidget {
  const _BigWidget({Key? key, required this.user}) : super(key: key);
  final User user;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text("Name: ${user.name}"),
        Text("email: ${user.email}"),
        Text("phone: ${user.phone}"),
        Text("website: ${user.website}"),
        const SizedBox(
          height: 15,
        ),
        Text(
          "Working company:",
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        Text("name: ${user.company.name}"),
        Text("bs: ${user.company.bs}"),
        RichText(
          text: TextSpan(
            children: <InlineSpan>[
              TextSpan(
                text: "catch phrase: ",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              TextSpan(
                text: user.company.catchPhrase,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(fontStyle: FontStyle.italic),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        Text("Address: ${user.address.toString()}"),
      ],
    );
  }
}

class _PostList extends StatelessWidget {
  const _PostList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: BlocBuilder<PostBlock, PostScreenState>(
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
              final List<Post> _posts = context.watch<PostBlock>().posts;
              return PostsWidget(
                posts: [..._posts, ..._posts],
                small: true,
              );
            default:
              return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}
