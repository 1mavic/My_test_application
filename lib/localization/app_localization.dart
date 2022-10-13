import "package:flutter/material.dart";
import "package:my_app/localization/app_locale_keys.dart";

class AppLocalization {
  final Locale locale;

  const AppLocalization(this.locale);

  static AppLocalization? of(BuildContext ctx) =>
      Localizations.of<AppLocalization>(ctx, AppLocalization);

  static final Map<String, Map<AppLocKeys, String>> _db =
      <String, Map<AppLocKeys, String>>{
    "en": <AppLocKeys, String>{
      AppLocKeys.userList: "user list",
      AppLocKeys.seeAll: "see all",
      AppLocKeys.album: "album",
      AppLocKeys.beFirst: "be first :)",
      AppLocKeys.name: "name",
      AppLocKeys.addComment: "add comment",
      AppLocKeys.send: "send",
      AppLocKeys.yes: "yes",
      AppLocKeys.no: "no",
      AppLocKeys.attention: "attention",
      AppLocKeys.clearData: "do you want to clear local cache?",
      AppLocKeys.navigationError: "navigation error",
      AppLocKeys.settings: "settings",
      AppLocKeys.darkTheme: "dark theme",
    },
    "ru": <AppLocKeys, String>{
      AppLocKeys.userList: "список пользователей",
      AppLocKeys.seeAll: "посмотреть все",
      AppLocKeys.album: "аьлбом",
      AppLocKeys.beFirst: "будьте первым :)",
      AppLocKeys.name: "имя",
      AppLocKeys.addComment: "добавить комментарий",
      AppLocKeys.send: "отправить",
      AppLocKeys.yes: "да",
      AppLocKeys.no: "нет",
      AppLocKeys.attention: "внимание",
      AppLocKeys.clearData: "Вы хотите очистить локальные данные?",
      AppLocKeys.navigationError: "Ошибка навигации",
      AppLocKeys.settings: "настройки",
      AppLocKeys.darkTheme: "темная тема",
    },
    "fi": <AppLocKeys, String>{
      AppLocKeys.userList: "luettelo käyttäjistä",
      AppLocKeys.seeAll: "näytä kaikki",
      AppLocKeys.album: "albumi",
      AppLocKeys.beFirst: "olla ensimmäinen :)",
      AppLocKeys.name: "nimi",
      AppLocKeys.addComment: "lisää kommentti",
      AppLocKeys.send: "lähettää",
      AppLocKeys.yes: "Joo",
      AppLocKeys.no: "ei",
      AppLocKeys.attention: "huomio",
      AppLocKeys.clearData: "haluatko tyhjentää paikallisen välimuistin?",
      AppLocKeys.navigationError: "navigointivirhe",
      AppLocKeys.settings: "asetukset",
      AppLocKeys.darkTheme: "tumma teema",
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
