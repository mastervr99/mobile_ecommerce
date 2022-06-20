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
      User user = User();
      user.setUserFirstname('testFirstname');
      user.setUserLastname('testLastname');
      user.setUserEmail('test23@gmail.com');
      user.setUserPassword('password');

      UserRepository userRepository = UserRepositorySqfliteFfiImpl();

      SignUpUsecase signUpUsecase = SignUpUsecase(userRepository);

      await signUpUsecase.signUpNewUSer(user);

      User dataSearchUser1 = await userRepository.retrieveUser(user);

      expect(await dataSearchUser1.getUserEmail(), user.getUserEmail());
    });

    test("user can't sign up twice with same email", () async {
      UserRepository userRepository = UserRepositorySqfliteFfiImpl();

      SignUpUsecase signUpUsecase = SignUpUsecase(userRepository);

      User user = User();
      user.setUserFirstname('testFirstname');
      user.setUserLastname('testLastname');
      user.setUserEmail('testt@aol.com');
      user.setUserPassword('password');

      var isNewUser = await signUpUsecase.checkIfNewUser(user);

      expect(await isNewUser, true);

      await signUpUsecase.signUpNewUSer(user);

      var isStillNewUser = await signUpUsecase.checkIfNewUser(user);

      expect(await isStillNewUser, false);
    });
  });
}
