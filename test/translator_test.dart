import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_ecommerce/Application/LangagueTranslatorImpl.dart';
import 'package:flutter/widgets.dart';

void main() {
  group('translator actions:', () {
    test('translator translate strings based on location', () {
      LanguageTranslatorImpl langugageTranslator = LanguageTranslatorImpl();

      expect(langugageTranslator.translate("it works"), "ça marche");

      expect(langugageTranslator.translate("ça marche"), "it works");
    });
  });
}
