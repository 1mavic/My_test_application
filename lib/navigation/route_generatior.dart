import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import 'package:flutter_test_application/domain/bloc/album_bloc/album_bloc.dart';
import 'package:flutter_test_application/domain/bloc/comment_bloc/comment_bloc.dart';
import 'package:flutter_test_application/domain/bloc/photo_bloc/photo_bloc.dart';
import 'package:flutter_test_application/domain/bloc/post_bloc/post_bloc.dart';
import 'package:flutter_test_application/domain/bloc/user_bloc/user_bloc.dart';
import "package:flutter_test_application/domain/entity/album/album_model.dart";
import "package:flutter_test_application/domain/entity/post/post_model.dart";
import "package:flutter_test_application/domain/entity/user/user_model.dart";
import "package:flutter_test_application/navigation/routes.dart";
import "package:flutter_test_application/ui/screens/album_info_screen.dart";
import "package:flutter_test_application/ui/screens/albums_user_screen.dart";
import "package:flutter_test_application/ui/screens/post_all_screen.dart";
import "package:flutter_test_application/ui/screens/post_info_screen.dart";
import "package:flutter_test_application/ui/screens/user_info_screen.dart";
import "package:flutter_test_application/ui/screens/users_screen.dart";

class RouteGenerator {
  final String initialRoute = AppRoutes.home;

  final Map<String, Widget Function(BuildContext p1)> routes =
      <String, Widget Function(BuildContext)>{
    AppRoutes.home: (BuildContext context) => BlocProvider<UserBloc>(
          create: (BuildContext context) => UserBloc()..add(GetUsersEvent()),
          child: const UsersScreen(),
        )
  };

  static Route<dynamic> onGenerateRoute(RouteSettings setting) {
    final Object? args = setting.arguments;
    switch (setting.name) {
      case AppRoutes.userInfo:
        if (args is User) {
          return MaterialPageRoute<dynamic>(
            builder: (BuildContext context) => MultiBlocProvider(
              providers: [
                BlocProvider<PostBloc>(
                  create: (BuildContext context) =>
                      PostBloc()..add(GetPostsEvent(args.id)),
                ),
                BlocProvider<AlbumBloc>(
                  create: (BuildContext context) =>
                      AlbumBloc()..add(GetAlbumsEvent(args.id)),
                )
              ],
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
      case AppRoutes.userAlbums:
        if (args is List<Album>) {
          return MaterialPageRoute<dynamic>(
            builder: (BuildContext context) => UserAlbumsScreen(albums: args),
          );
        }
        return _errorRoute();
      case AppRoutes.userPostInfo:
        if (args is Post) {
          return MaterialPageRoute<dynamic>(
            builder: (BuildContext context) => MultiBlocProvider(
              providers: [
                BlocProvider<CommentBloc>(
                  create: (BuildContext context) =>
                      CommentBloc()..add(GetCommentsEvent(args.id)),
                ),
              ],
              child: PostInfoScrenn(post: args),
            ),
          );
        }
        return _errorRoute();
      case AppRoutes.userAlbumInfo:
        if (args is Album) {
          return MaterialPageRoute<dynamic>(
            builder: (BuildContext context) => MultiBlocProvider(
              providers: [
                BlocProvider<PhotoBloc>(
                  create: (BuildContext context) =>
                      PhotoBloc()..add(GetPhotosEvent(args.id)),
                ),
              ],
              child: AlbumInfoScreen(album: args),
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
