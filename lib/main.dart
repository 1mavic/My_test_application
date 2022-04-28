import "package:flutter/material.dart";
import "package:flutter_test_application/config/environment.dart";
import 'package:flutter_test_application/navigation/route_generatior.dart';
import "package:flutter_test_application/styles/app_theme.dart";
import "package:flutter_test_application/ui/screens/users_screen.dart";

Future<void> main() async {
  env = await loadEnvironment();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Test App",
      theme: appTheme,
      initialRoute: RouteGenerator().initialRoute,
      onGenerateRoute: RouteGenerator.onGenerateRoute,
    );
  }
}
