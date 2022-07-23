import "package:flutter/material.dart";
import "package:flutter_test_application/localization/app_locale_keys.dart";

class AppLocalization {
  final Locale locale;

  const AppLocalization(this.locale);

  static AppLocalization? of(BuildContext ctx) =>
      Localizations.of<AppLocalization>(ctx, AppLocalization);

  static final Map<String, Map<AppLocKeys, String>> _db =
      <String, Map<AppLocKeys, String>>{
    "en": <AppLocKeys, String>{
      AppLocKeys.userList: "user list",
    },
    "ru": <AppLocKeys, String>{
      AppLocKeys.userList: "список пользователей",
    },
    "fi": <AppLocKeys, String>{
      AppLocKeys.userList: "luettelo käyttäjistä",
    },
  };
}

extension LocalizationExtension on BuildContext {
  String localize(AppLocKeys value) {
    final String code = AppLocalization.of(this)?.locale.languageCode ?? "en";
    final Map<String, Map<AppLocKeys, String>> database = AppLocalization._db;
    if (database.containsKey(code)) {
      return database[code]?[value] ?? "-";
    } else {
      return database["en"]?[value] ?? "-";
    }
  }
}
