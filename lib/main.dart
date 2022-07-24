// ignore_for_file: depend_on_referenced_packages

import "package:flutter/material.dart";
import "package:flutter_localizations/flutter_localizations.dart"
    show
        GlobalCupertinoLocalizations,
        GlobalMaterialLocalizations,
        GlobalWidgetsLocalizations;
import "package:flutter_test_application/config/environment.dart";
import "package:flutter_test_application/diContainer/di_container.dart";
import "package:flutter_test_application/localization/localization_delegate.dart";
import "package:flutter_test_application/navigation/route_generatior.dart";
import "package:flutter_test_application/styles/app_theme.dart";
import "package:hive_flutter/hive_flutter.dart";

Future<void> main() async {
  await Hive.initFlutter();
  await Hive.openBox<String>("users");
  await Hive.openBox<String>("posts");
  await Hive.openBox<String>("albums");
  await Hive.openBox<String>("comments");
  env = await loadEnvironment();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({
    Key? key,
  }) : super(key: key);
  final RouteGenerator _route = RouteGenerator(
    userService: _diContainer.makeUserService(),
    postService: _diContainer.makePostService(),
    albumService: _diContainer.makeAlbumService(),
    commentService: _diContainer.makeCommentService(),
    photoService: _diContainer.makePhotoService(),
    apiRepository: _diContainer.makeApiRepository(),
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scaffoldMessengerKey: scaffoldMessengerState,
      theme: appTheme,
      initialRoute: _route.initialRoute,
      onGenerateRoute: _route.onGenerateRoute,
      localizationsDelegates: <LocalizationsDelegate<dynamic>>[
        AppLocalizationDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: const <Locale>[
        Locale.fromSubtags(languageCode: "en"),
        Locale.fromSubtags(languageCode: "ru"),
        Locale.fromSubtags(languageCode: "fi"),
      ],
    );
  }
}

GlobalKey<ScaffoldMessengerState> scaffoldMessengerState =
    GlobalKey<ScaffoldMessengerState>();
final DiContainer _diContainer = DiContainer();
