import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import 'package:flutter_test_application/domain/bloc/comment_bloc/comment_bloc.dart';
import 'package:flutter_test_application/domain/bloc/comment_bloc/comment_stat.dart';
import "package:flutter_test_application/domain/entity/comment/comment_model.dart";
import "package:flutter_test_application/domain/entity/post/post_model.dart";
import "package:flutter_test_application/styles/app_colors.dart";
import "package:flutter_test_application/ui/widgets/add_comment_bottom_sheet.dart";
import "package:flutter_test_application/ui/widgets/card_widget.dart";
import "package:flutter_test_application/ui/widgets/modal_bottom_sheet_template.dart";
import "package:flutter_test_application/ui/widgets/scaffold_template_widget.dart";

class PostInfoScrenn extends StatelessWidget {
  const PostInfoScrenn({Key? key, required this.post}) : super(key: key);
  final Post post;
  @override
  Widget build(BuildContext context) {
    final CommentBloc _model = context.watch<CommentBloc>();
    return ScaffoldBodyTemplateWidget(
      appBarTitle: "Пост",
      body: Column(
        children: <Widget>[
          Flexible(
            flex: 2,
            child: _DetailedPostWidget(
              title: post.title,
              body: post.body,
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          const Flexible(flex: 5, child: _CommentsWidget()),
          Flexible(
            child: ElevatedButton(
              onPressed: () {
                showMyCustomModalBottomSheet(
                  fullHeight: false,
                  context: context,
                  builder: (BuildContext context) =>
                      AddCommentWidget(commentBloc: _model),
                );
              },
              child: const Text("Добавить комментарий"),
            ),
          )
        ],
      ),
    );
  }
}

class _DetailedPostWidget extends StatelessWidget {
  const _DetailedPostWidget({Key? key, required this.title, required this.body})
      : super(key: key);
  final String title;
  final String body;
  @override
  Widget build(BuildContext context) {
    return CardWidget(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              "Заголовок",
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            Text(
              title,
            ),
            const SizedBox(
              height: 25,
            ),
            Text(
              "Пост",
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            Text(
              body,
            ),
          ],
        ),
      ),
    );
  }
}

class _CommentsWidget extends StatelessWidget {
  const _CommentsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CardWidget(
      child: BlocBuilder<CommentBloc, CommentScreenState>(
        builder: (BuildContext context, CommentScreenState state) {
          switch (state.runtimeType) {
            case CommentLoadingState:
              final CommentLoadingState _state = state as CommentLoadingState;
              return Center(
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
              );
            case CommentErrorState:
              final CommentErrorState _state = state as CommentErrorState;
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      _state.error,
                      style: const TextStyle(color: Colors.black),
                    ),
                  ],
                ),
              );
            case CommentListObtainedState:
              final List<Comment> _comments =
                  context.watch<CommentBloc>().comments;
              return _CommentsListWidget(
                comments: _comments,
              );
            default:
              return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}

class _CommentsListWidget extends StatelessWidget {
  const _CommentsListWidget({Key? key, required this.comments})
      : super(key: key);
  final List<Comment> comments;
  @override
  Widget build(BuildContext context) {
    if (comments.isEmpty) {
      return const Center(
        child: Text("Будьте первым! :)"),
      );
    }
    return ListView.separated(
      padding: EdgeInsets.zero,
      itemBuilder: (BuildContext context, int index) => _CommentWidget(
        name: comments[index].name,
        email: comments[index].email,
        comment: comments[index].body,
      ),
      separatorBuilder: (_, __) => const Divider(
        color: AppColors.blue,
        height: 20,
      ),
      itemCount: comments.length,
    );
  }
}

class _CommentWidget extends StatelessWidget {
  const _CommentWidget({
    Key? key,
    required this.name,
    required this.email,
    required this.comment,
  }) : super(key: key);
  final String name;
  final String email;
  final String comment;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text("Имя: $name"),
        const SizedBox(
          height: 5,
        ),
        Text(email),
        const SizedBox(
          height: 15,
        ),
        Text(comment)
      ],
    );
  }
}
