import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test_application/localization/app_localization.dart';

class AppLocalizationDelegate extends LocalizationsDelegate<AppLocalization> {
  @override
  bool isSupported(Locale locale) =>
      <String>["en", "ru", "fi"].contains(locale.languageCode);

  @override
  Future<AppLocalization> load(Locale locale) =>
      SynchronousFuture<AppLocalization>(
        AppLocalization(locale),
      );

  @override
  bool shouldReload(covariant LocalizationsDelegate<AppLocalization> old) =>
      false;
}
