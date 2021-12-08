import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show  rootBundle;

class Translations {
  Translations(this._locale);

  final  Locale _locale;
  static Map<String, dynamic> _localizedValues = Map<String, dynamic>();
  static String _languageCode = '';

  static Translations of(BuildContext context){
    return Localizations.of<Translations>(context, Translations)!;
  }

  String text(String key) {
    return _localizedValues[key] ?? '* $key *';
  }

  static String getLanguageCode()
  {
    return _languageCode;
  }

  static Future<Translations> load(Locale locale) async {
    Translations translations = new Translations(locale);
    String jsonContent = await rootBundle.loadString("locale/i18n_${locale.languageCode}.json");
    _languageCode = locale.languageCode;
    _localizedValues = json.decode(jsonContent);
    return translations;
  }

  get currentLanguage => _locale.languageCode;
}

class TranslationsDelegate extends LocalizationsDelegate<Translations> {
  const TranslationsDelegate();

  @override
  bool isSupported(Locale locale) => ['en','ru'].contains(locale.languageCode);

  @override
  Future<Translations> load(Locale locale) => Translations.load(locale);

  @override
  bool shouldReload(TranslationsDelegate old) => false;
}