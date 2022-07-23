import 'package:flutter/material.dart';
import "package:flutter_test_application/config/environment.dart";
import 'package:flutter_test_application/localization/localization_delegate.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
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
      localizationsDelegates: <LocalizationsDelegate<dynamic>>[
        AppLocalizationDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale.fromSubtags(languageCode: "en"),
        Locale.fromSubtags(languageCode: "ru"),
        Locale.fromSubtags(languageCode: "fi"),
      ],
    );
  }
}
