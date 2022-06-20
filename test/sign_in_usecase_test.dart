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
      User user = User();

      user.setUserFirstname('testFirstname');
      user.setUserLastname('testLastname');
      user.setUserEmail('test@gmail.com');
      user.setUserPassword('password');

      UserRepository userRepository = UserRepositorySqfliteFfiImpl();
      SignInUsecase signInUsecase = SignInUsecase(userRepository);

      expect(await signInUsecase.checkIfEmailRegistered(user), false);

      SignUpUsecase signUpUsecase = SignUpUsecase(userRepository);

      await signUpUsecase.signUpNewUSer(user);

      expect(await signInUsecase.checkIfEmailRegistered(user), true);
    });

    test('registered user can sign in', () async {
      await Hive.initFlutter();
      await Hive.openBox('myBox');
      var box = Hive.box('myBox');

      User user = User();

      user.setUserFirstname('testFirstname');
      user.setUserLastname('testLastname');
      user.setUserEmail('test2@gmail.com');
      user.setUserPassword('password');

      UserRepository userRepository = UserRepositorySqfliteFfiImpl();
      SignUpUsecase signUpUsecase = SignUpUsecase(userRepository);

      await signUpUsecase.signUpNewUSer(user);

      SignInUsecase signInUsecase = SignInUsecase(userRepository);

      var isRegisteredEmail = await signInUsecase.checkIfEmailRegistered(user);

      expect(await isRegisteredEmail, true);

      var isValidAccountPassword =
          await signInUsecase.checkIfValidAccountPassword(user);

      expect(await isValidAccountPassword, true);

      await signInUsecase.signInRegisteredUser();

      var isUserConnected = box.get('isUserConnected');

      expect(isUserConnected, true);
    });
  });
}
