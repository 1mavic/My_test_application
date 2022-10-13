import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:my_app/domain/bloc/comment_bloc/comment_bloc.dart";
import "package:my_app/domain/bloc/comment_bloc/comment_stat.dart";
import "package:my_app/domain/entity/comment/comment_model.dart";
import "package:my_app/domain/entity/post/post_model.dart";
import "package:my_app/localization/localization.dart";
import "package:my_app/styles/app_colors.dart";
import "package:my_app/ui/widgets/add_comment_bottom_sheet.dart";
import "package:my_app/ui/widgets/button.dart";
import "package:my_app/ui/widgets/card_widget.dart";
import "package:my_app/ui/widgets/modal_bottom_sheet_template.dart";
import "package:my_app/ui/widgets/scaffold_template_widget.dart";
import "package:my_app/utils/string_extensions.dart";

class PostInfoScrenn extends StatelessWidget {
  const PostInfoScrenn({super.key, required this.post});
  final Post post;
  @override
  Widget build(BuildContext context) {
    final CommentBloc model = context.watch<CommentBloc>();
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
            child: MyButton(
              onPressed: () {
                showMyCustomModalBottomSheet(
                  fullHeight: false,
                  context: context,
                  builder: (BuildContext context) =>
                      AddCommentWidget(commentBloc: model),
                );
              },
              text: context.localize(AppLocKeys.addComment),
            ),
          )
        ],
      ),
    );
  }
}

class _DetailedPostWidget extends StatelessWidget {
  const _DetailedPostWidget({required this.title, required this.body});
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
  const _CommentsWidget();

  @override
  Widget build(BuildContext context) {
    return CardWidget(
      child: BlocBuilder<CommentBloc, CommentScreenState>(
        builder: (BuildContext context, CommentScreenState state) {
          switch (state.runtimeType) {
            case CommentLoadingState:
              final CommentLoadingState currentState =
                  state as CommentLoadingState;
              return Center(
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
              );
            case CommentErrorState:
              final CommentErrorState currentState = state as CommentErrorState;
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      currentState.error,
                      style: const TextStyle(color: Colors.black),
                    ),
                  ],
                ),
              );
            case CommentListObtainedState:
              final List<Comment> comments =
                  context.watch<CommentBloc>().comments;
              return _CommentsListWidget(
                comments: comments,
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
  const _CommentsListWidget({required this.comments});
  final List<Comment> comments;
  @override
  Widget build(BuildContext context) {
    if (comments.isEmpty) {
      return Center(
        child: Text(
          context.localize(AppLocKeys.beFirst).firstToUpper(),
        ),
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
    required this.name,
    required this.email,
    required this.comment,
  });
  final String name;
  final String email;
  final String comment;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text("${context.localize(AppLocKeys.name).firstToUpper()} $name"),
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
