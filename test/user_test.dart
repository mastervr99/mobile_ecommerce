import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_ecommerce/users_manager.dart';
import 'package:mobile_ecommerce/user.dart';

void main() {
  group('User behaviors', () {
    test('user can register', () {
      User user = User();
      user.register('thusy', 'password');
      UsersManager usersManager = UsersManager();
      expect(usersManager.checkRegistrationOf('thusy', 'password'), true);
    });
  });
}
