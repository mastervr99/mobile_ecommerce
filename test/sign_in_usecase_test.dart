import 'package:flutter_test/flutter_test.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mobile_ecommerce/Application/usecases/sign_up_usecase.dart';
import 'package:mobile_ecommerce/Domain/Entity/user.dart';
import 'package:mobile_ecommerce/Domain/Repositories_abstractions/user_repository.dart';
import 'Repositories_test/user_repository_sqflite_ffi_impl.dart';
import 'package:mobile_ecommerce/Application/usecases/sign_in_usecase.dart';

void main() {
  group('SignInUsecase : ', () {
    test('check if user email is registered', () async {
      Map user = {
        'email': 'test@gmail.com',
        'password': 'password',
        'firstname': 'testFirstname',
        'lastname': 'testLastname'
      };

      User newUser = User();

      newUser.setUserFirstname(user['firstname']);
      newUser.setUserLastname(user['lastname']);
      newUser.setUserEmail(user['email']);
      newUser.setUserPassword(user['password']);

      UserRepository userRepository = UserRepositorySqfliteFfiImpl();
      SignInUsecase signInUsecase = SignInUsecase(userRepository);

      expect(await signInUsecase.checkIfEmailRegistered(newUser), false);

      SignUpUsecase signUpUsecase = SignUpUsecase(userRepository);

      await signUpUsecase.signUpNewUSer(newUser);

      expect(await signInUsecase.checkIfEmailRegistered(newUser), true);
    });

    test('registered user can sign in', () async {
      await Hive.initFlutter();
      await Hive.openBox('myBox');
      var box = Hive.box('myBox');

      Map user = {
        'email': 'test2@gmail.com',
        'password': 'password',
        'firstname': 'testFirstname',
        'lastname': 'testLastname'
      };

      User newUser = User();

      newUser.setUserFirstname(user['firstname']);
      newUser.setUserLastname(user['lastname']);
      newUser.setUserEmail(user['email']);
      newUser.setUserPassword(user['password']);

      UserRepository userRepository = UserRepositorySqfliteFfiImpl();
      SignUpUsecase signUpUsecase = SignUpUsecase(userRepository);

      await signUpUsecase.signUpNewUSer(newUser);

      SignInUsecase signInUsecase = SignInUsecase(userRepository);

      var isRegisteredEmail =
          await signInUsecase.checkIfEmailRegistered(newUser);

      expect(await isRegisteredEmail, true);

      var isValidAccountPassword =
          await signInUsecase.checkIfValidAccountPassword(newUser);

      expect(await isValidAccountPassword, true);

      await signInUsecase.signInRegisteredUser();

      var isUserConnected = box.get('isUserConnected');

      expect(isUserConnected, true);
    });
  });
}
