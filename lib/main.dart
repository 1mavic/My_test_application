// ignore_for_file: depend_on_referenced_packages

import "dart:async";
import "dart:developer";

import "package:flutter/material.dart";
import "package:flutter_localizations/flutter_localizations.dart"
    show
        GlobalCupertinoLocalizations,
        GlobalMaterialLocalizations,
        GlobalWidgetsLocalizations;
import "package:hive_flutter/hive_flutter.dart";
import "package:my_app/config/environment.dart";
import "package:my_app/diContainer/di_container.dart";
import "package:my_app/localization/localization_delegate.dart";
import "package:my_app/navigation/route_generatior.dart";
import "package:my_app/styles/app_theme.dart";

Future<void> main() async {
  runZonedGuarded(
    () async {
      FlutterError.onError = (FlutterErrorDetails details) {
        FlutterError.presentError(details);
        log(details.toString());
      };
      await Hive.initFlutter();
      await Hive.openBox<String>("users");
      await Hive.openBox<String>("posts");
      await Hive.openBox<String>("albums");
      await Hive.openBox<String>("comments");
      env = await loadEnvironment();

      runApp(MyApp());
    },
    (Object error, StackTrace stack) {
      log("${error.toString()} : ${stack.toString()}");
    },
  );
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
