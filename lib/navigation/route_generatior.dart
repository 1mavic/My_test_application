import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test_application/domain/block/user_block/user_block.dart';
import 'package:flutter_test_application/domain/entity/user/user_model.dart';
import 'package:flutter_test_application/navigation/routes.dart';
import 'package:flutter_test_application/ui/screens/user_info_screen.dart';
import 'package:flutter_test_application/ui/screens/users_screen.dart';

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
            builder: (BuildContext context) => UserInfoScreen(user: args),
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
