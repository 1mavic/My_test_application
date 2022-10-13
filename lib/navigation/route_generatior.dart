import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:my_app/domain/bloc/album_bloc/album_bloc.dart";
import "package:my_app/domain/bloc/comment_bloc/comment_bloc.dart";
import "package:my_app/domain/bloc/error_bloc/error_bloc.dart";
import "package:my_app/domain/bloc/photo_bloc/photo_bloc.dart";
import "package:my_app/domain/bloc/post_bloc/post_bloc.dart";
import "package:my_app/domain/bloc/user_bloc/user_bloc.dart";
import "package:my_app/domain/data_providers/api_cleint/api_repository.dart";
import "package:my_app/domain/entity/album/album_model.dart";
import "package:my_app/domain/entity/post/post_model.dart";
import "package:my_app/domain/entity/user/user_model.dart";
import "package:my_app/domain/services/album_service.dart";
import "package:my_app/domain/services/comment_service.dart";
import "package:my_app/domain/services/photo_service.dart";
import "package:my_app/domain/services/post_sevices.dart";
import "package:my_app/domain/services/user_service.dart";
import "package:my_app/localization/localization.dart";
import "package:my_app/navigation/routes.dart";
import "package:my_app/ui/screens/album_info_screen.dart";
import "package:my_app/ui/screens/albums_user_screen.dart";
import "package:my_app/ui/screens/post_all_screen.dart";
import "package:my_app/ui/screens/post_info_screen.dart";
import 'package:my_app/ui/screens/settings_screen.dart';
import "package:my_app/ui/screens/user_info_screen.dart";
import "package:my_app/ui/screens/users_screen.dart";
import "package:my_app/utils/string_extensions.dart";

class RouteGenerator {
  RouteGenerator({
    required this.userService,
    required this.postService,
    required this.albumService,
    required this.commentService,
    required this.photoService,
    required this.apiRepository,
  });
  final UserService userService;
  final PostService postService;
  final AlbumService albumService;
  final CommentService commentService;
  final PhotoService photoService;
  final ApiRepository apiRepository;
  final String initialRoute = AppRoutes.home;

  Route<dynamic> onGenerateRoute(RouteSettings setting) {
    final Object? args = setting.arguments;
    switch (setting.name) {
      case AppRoutes.home:
        return MaterialPageRoute<dynamic>(
          builder: (BuildContext context) => MultiBlocProvider(
            providers: <BlocProvider<dynamic>>[
              BlocProvider<UserBloc>(
                create: (BuildContext context) =>
                    UserBloc(userService)..add(GetUsersEvent()),
              ),
              BlocProvider<ErrorBloc>(
                create: (BuildContext context) => ErrorBloc(apiRepository),
              )
            ],
            child: const UsersScreen(),
          ),
        );
      case AppRoutes.userInfo:
        if (args is User) {
          return MaterialPageRoute<dynamic>(
            builder: (BuildContext context) => MultiBlocProvider(
              providers: <BlocProvider<dynamic>>[
                BlocProvider<PostBloc>(
                  create: (BuildContext context) =>
                      PostBloc(postService)..add(GetPostsEvent(args.id)),
                ),
                BlocProvider<AlbumBloc>(
                  create: (BuildContext context) =>
                      AlbumBloc(albumService)..add(GetAlbumsEvent(args.id)),
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
              providers: <BlocProvider<dynamic>>[
                BlocProvider<CommentBloc>(
                  create: (BuildContext context) => CommentBloc(commentService)
                    ..add(GetCommentsEvent(args.id)),
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
              providers: <BlocProvider<dynamic>>[
                BlocProvider<PhotoBloc>(
                  create: (BuildContext context) =>
                      PhotoBloc(photoService)..add(GetPhotosEvent(args.id)),
                ),
              ],
              child: AlbumInfoScreen(album: args),
            ),
          );
        }
        return _errorRoute();
      case AppRoutes.settings:
        return MaterialPageRoute<dynamic>(
          builder: (BuildContext context) => SettingsScreen(),
        );
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute<dynamic>(
      builder: (BuildContext context) => const _NavigationErrorScreen(),
    );
  }
}

class _NavigationErrorScreen extends StatelessWidget {
  const _NavigationErrorScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Text(
          context.localize(AppLocKeys.navigationError).firstToUpper(),
        ),
      ),
    );
  }
}
