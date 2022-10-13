// ignore_for_file: depend_on_referenced_packages

import "dart:async";
import "dart:developer";

import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:flutter_localizations/flutter_localizations.dart"
    show
        GlobalCupertinoLocalizations,
        GlobalMaterialLocalizations,
        GlobalWidgetsLocalizations;
import "package:my_app/config/environment.dart";
import "package:my_app/diContainer/di_container.dart";
import "package:my_app/domain/bloc/settings_bloc/settings_bloc.dart";
import "package:my_app/domain/data_providers/local_storage/local_data_provider.dart";
import "package:my_app/localization/localization_delegate.dart";
import "package:my_app/navigation/route_generatior.dart";

Future<void> main() async {
  runZonedGuarded(
    () async {
      FlutterError.onError = (FlutterErrorDetails details) {
        FlutterError.presentError(details);
        log(details.toString());
      };

      env = await loadEnvironment();
      final LocalDataProvider dataProvider = _diContainer.dataProvider;
      await dataProvider.initDataProvider();

      runApp(
        MyApp(
          isDark: dataProvider.isThemeDark(),
        ),
      );
    },
    (Object error, StackTrace stack) {
      log("${error.toString()} : ${stack.toString()}");
    },
  );
}

class MyApp extends StatelessWidget {
  MyApp({
    super.key,
    required this.isDark,
  });
  final RouteGenerator _route = RouteGenerator(
    userService: _diContainer.makeUserService(),
    postService: _diContainer.makePostService(),
    albumService: _diContainer.makeAlbumService(),
    commentService: _diContainer.makeCommentService(),
    photoService: _diContainer.makePhotoService(),
    apiRepository: _diContainer.makeApiRepository(),
  );
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SettingsBloc>(
      create: (BuildContext context) => SettingsBloc(
        isDark ? DarkSettingsState() : LightSettingsState(),
        _diContainer.dataProvider,
      ),
      child: BlocBuilder<SettingsBloc, SettingsState>(
        builder: (BuildContext context, SettingsState state) {
          return runMaterial(
            state.theme,
          );
        },
      ),
    );
  }

  MaterialApp runMaterial(ThemeData theme) {
    return MaterialApp(
      scaffoldMessengerKey: scaffoldMessengerState,
      theme: theme,
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
