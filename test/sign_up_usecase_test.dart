import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_ecommerce/Application/usecases/sign_up_usecase.dart';
import 'package:mobile_ecommerce/Domain/Entity/user.dart';
import 'package:mobile_ecommerce/Domain/Repositories_abstractions/user_repository.dart';
import 'Repositories_test/user_repository_sqflite_ffi_impl.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('SignUpUsecase : ', () {
    test('user can sign up', () async {
      Map userMap = {
        'email': 'test23@gmail.com',
        'password': 'password',
        'firstname': 'testFirstname',
        'lastname': 'testLastname'
      };

      User user = User();
      user.setUserFirstname(userMap['firstname']);
      user.setUserLastname(userMap['lastname']);
      user.setUserEmail(userMap['email']);
      user.setUserPassword(userMap['password']);

      UserRepository userRepository = UserRepositorySqfliteFfiImpl();

      SignUpUsecase signUpUsecase = SignUpUsecase(userRepository);

      await signUpUsecase.signUpNewUSer(user);

      User dataSearchUser1 = await userRepository.retrieveUser(user);

      expect(await dataSearchUser1.getUserEmail(), user.getUserEmail());
    });

    test("user can't sign up twice with same email", () async {
      UserRepository userRepository = UserRepositorySqfliteFfiImpl();

      SignUpUsecase signUpUsecase = SignUpUsecase(userRepository);

      Map user = {
        'email': 'testt@aol.com',
        'password': 'password',
        'firstname': 'testFirstname',
        'lastname': 'testLastname'
      };

      User newUser = User();

      newUser.setUserFirstname(user['firstname']);
      newUser.setUserLastname(user['lastname']);
      newUser.setUserEmail(user['email']);
      newUser.setUserPassword(user['password']);

      var isNewUser = await signUpUsecase.checkIfNewUser(newUser);

      expect(await isNewUser, true);

      await signUpUsecase.signUpNewUSer(newUser);

      var isStillNewUser = await signUpUsecase.checkIfNewUser(newUser);

      expect(await isStillNewUser, false);
    });
  });
}
