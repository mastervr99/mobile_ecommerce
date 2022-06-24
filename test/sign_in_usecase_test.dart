import 'package:flutter_test/flutter_test.dart';
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

      await signUpUsecase.signUp(user);

      expect(await signInUsecase.checkIfEmailRegistered(user), true);
    });

    test('registered user can sign in', () async {
      User user = User();

      user.setUserFirstname('testFirstname');
      user.setUserLastname('testLastname');
      user.setUserEmail('test2@gmail.com');
      user.setUserPassword('password');

      UserRepository userRepository = UserRepositorySqfliteFfiImpl();
      SignUpUsecase signUpUsecase = SignUpUsecase(userRepository);

      await signUpUsecase.signUp(user);

      SignInUsecase signInUsecase = SignInUsecase(userRepository);

      var isRegisteredEmail = await signInUsecase.checkIfEmailRegistered(user);

      expect(await isRegisteredEmail, true);

      var isValidAccountPassword =
          await signInUsecase.checkIfValidAccountPassword(user);

      expect(await isValidAccountPassword, true);

      await signInUsecase.signIn(user);

      var isUserConnected = await signInUsecase.checkUserStatus();

      expect(await isUserConnected, true);
    });
  });
}
