import "package:flutter/material.dart";
import "package:flutter_test_application/domain/entity/post/post_model.dart";
import "package:flutter_test_application/navigation/routes.dart";
import "package:flutter_test_application/styles/app_colors.dart";
import "package:flutter_test_application/ui/widgets/card_widget.dart";

class PostsWidget extends StatelessWidget {
  const PostsWidget({Key? key, required this.posts, required this.small})
      : super(key: key);
  final List<Post> posts;
  final bool small;
  @override
  Widget build(BuildContext context) {
    final int _length = small
        ? posts.length > 3
            ? 3
            : posts.length
        : posts.length;
    if (posts.isEmpty) {
      return const SizedBox.shrink();
    }
    final Widget _bodyList = CardWidget(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListView.separated(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _length,
            separatorBuilder: (_, __) => Divider(
              height: small ? 15 : 20,
              color: AppColors.blue,
            ),
            itemBuilder: (BuildContext context, int index) => InkWell(
              onTap: () {
                if (small) {
                  return;
                }
                Navigator.of(context)
                    .pushNamed(AppRoutes.userPostInfo, arguments: posts[index]);
              },
              child: _PostPreviewWidget(
                post: posts[index],
              ),
            ),
          ),
          if (small) const SizedBox(height: 10),
          if (small && posts.length > 3)
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(
                    AppRoutes.userPostsAll,
                    arguments: posts,
                  );
                },
                child: const Text("Просмотреть все посты"),
              ),
            )
        ],
      ),
    );

    return small
        ? _bodyList
        : SingleChildScrollView(
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: _bodyList,
          );
  }
}

class _PostPreviewWidget extends StatelessWidget {
  const _PostPreviewWidget({Key? key, required this.post}) : super(key: key);
  final Post post;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(post.title),
        const SizedBox(height: 5),
        Text(
          post.body.split("\n").first,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}
