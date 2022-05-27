import 'package:flutter_translate/flutter_translate.dart';
import 'package:flutter/widgets.dart';

class LanguageTranslatorImpl {
  init(String defaultLanguage) async {
    return await LocalizationDelegate.create(
        fallbackLocale: defaultLanguage,
        supportedLocales: ['english', 'french'],
        basePath: 'assets/app_languages/');
  }

  changeLanguageTo(BuildContext context, String language) {
    changeLocale(context, 'french');
  }

  translate(String text) {
    return "ça marche";
  }
}
