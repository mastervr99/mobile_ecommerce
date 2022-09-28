import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_ecommerce/Application/Custom_Form_Field_Validator.dart';

void main() {
  group('Form fields validation : ', () {
    var formFieldValidator = Custom_Form_Field_Validator();
    test('email validation', () {
      String email = 'test@gmail.com';
      expect(formFieldValidator.isValidEmail(email), true);

      String email2 = 'test.com';
      expect(formFieldValidator.isValidEmail(email2), false);
    });

    test('name validation', () {
      String name = 'eric';
      expect(formFieldValidator.isValidName(name), true);

      String name2 = '42';
      expect(formFieldValidator.isValidName(name2), false);
    });

    test('password validation', () {
      String password = 'Ballon123&';
      expect(formFieldValidator.isValidPassword(password), true);

      String password2 = "exemple";
      expect(formFieldValidator.isValidPassword(password2), false);
    });

    test('phone number validation', () {
      var phone_number = '0123456778';
      expect(
          formFieldValidator.check_if_valid_phone_number(phone_number), true);

      var phone_number2 = '01234567784fdf';
      expect(
          formFieldValidator.check_if_valid_phone_number(phone_number2), false);
    });
  });
}
