import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_ecommerce/Application/translatorImpl.dart';

void main() {
  group('translator actions:', () {
    test('translator translate strings based on location', () {
      TranslatorImpl translator = TranslatorImpl();
      expect(translator.translate("it works"), "ça marche");

      expect(translator.translate("ça marche"), "it works");
    });
  });
}
