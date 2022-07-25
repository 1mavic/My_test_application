import "package:flutter/material.dart";
import "package:my_app/domain/entity/post/post_model.dart";
import "package:my_app/navigation/routes.dart";
import "package:my_app/ui/widgets/preview_list_widget.dart";
import "package:my_app/ui/widgets/scaffold_template_widget.dart";

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
