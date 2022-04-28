import "package:flutter/material.dart";
import "package:flutter_test_application/domain/entity/post/post_model.dart";
import "package:flutter_test_application/ui/widgets/posts_widget.dart";
import "package:flutter_test_application/ui/widgets/scaffold_template_widget.dart";

class AllPostsScreen extends StatelessWidget {
  const AllPostsScreen({Key? key, required this.posts}) : super(key: key);
  final List<Post> posts;
  @override
  Widget build(BuildContext context) {
    return ScaffoldBodyTemplateWidget(
      appBarTitle: "Все посты",
      body: PostsWidget(
        posts: posts,
        small: false,
      ),
    );
  }
}
