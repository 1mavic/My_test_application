import "package:flutter/material.dart";
import "package:flutter_test_application/domain/entity/post/post_model.dart";
import "package:flutter_test_application/navigation/routes.dart";
import "package:flutter_test_application/ui/widgets/preview_list_widget.dart";
import "package:flutter_test_application/ui/widgets/scaffold_template_widget.dart";

class AllPostsScreen extends StatelessWidget {
  const AllPostsScreen({Key? key, required this.posts}) : super(key: key);
  final List<Post> posts;
  @override
  Widget build(BuildContext context) {
    return ScaffoldBodyTemplateWidget(
      appBarTitle: "Все посты",
      body: PreviewWidget<Post>(
        items: posts,
        routeToList: AppRoutes.userPostsAll,
        routeToDetail: AppRoutes.userPostInfo,
        small: false,
      ),
    );
  }
}
