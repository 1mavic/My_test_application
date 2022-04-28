import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:flutter_test_application/domain/block/comment_block/comment_block.dart";
import "package:flutter_test_application/domain/block/post_block/post_block.dart";
import "package:flutter_test_application/domain/block/user_block/user_block.dart";
import "package:flutter_test_application/domain/entity/post/post_model.dart";
import "package:flutter_test_application/domain/entity/user/user_model.dart";
import "package:flutter_test_application/navigation/routes.dart";
import "package:flutter_test_application/ui/screens/post_all_screen.dart";
import "package:flutter_test_application/ui/screens/post_info_screen.dart";
import "package:flutter_test_application/ui/screens/user_info_screen.dart";
import "package:flutter_test_application/ui/screens/users_screen.dart";

class RouteGenerator {
  final initialRoute = AppRoutes.home;

  final routes = <String, Widget Function(BuildContext)>{
    AppRoutes.home: (BuildContext context) => BlocProvider<UserBlock>(
          create: (BuildContext context) => UserBlock()..add(GetUsersEvent()),
          child: const UsersScreen(),
        )
  };

  static Route<dynamic> onGenerateRoute(RouteSettings setting) {
    final args = setting.arguments;
    switch (setting.name) {
      case AppRoutes.userInfo:
        if (args is User) {
          return MaterialPageRoute<dynamic>(
            builder: (BuildContext context) => BlocProvider<PostBlock>(
              create: (BuildContext context) =>
                  PostBlock()..add(GetPostsEvent(args.id)),
              child: UserInfoScreen(user: args),
            ),
          );
        }
        return _errorRoute();
      case AppRoutes.userPostsAll:
        if (args is List<Post>) {
          return MaterialPageRoute<dynamic>(
            builder: (BuildContext context) => AllPostsScreen(posts: args),
          );
        }
        return _errorRoute();
      case AppRoutes.userPostInfo:
        if (args is Post) {
          return MaterialPageRoute<dynamic>(
            builder: (BuildContext context) => BlocProvider<CommentBlock>(
              create: (BuildContext context) =>
                  CommentBlock()..add(GetCommentsEvent(args.id)),
              child: PostInfoScrenn(post: args),
            ),
          );
        }
        return _errorRoute();
      default:
        return MaterialPageRoute(
          builder: RouteGenerator().routes[setting.name]!,
        );
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute<dynamic>(
      builder: (BuildContext context) => Scaffold(
        appBar: AppBar(),
        body: const Center(
          child: Text("Ошибка навигации"),
        ),
      ),
    );
  }
}
