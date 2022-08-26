import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_ecommerce/Application/usecases/sign_up_usecase.dart';
import 'package:mobile_ecommerce/Domain/Entity/user.dart';
import 'package:mobile_ecommerce/Domain/Repositories_abstractions/connected_user_repository.dart';
import 'package:mobile_ecommerce/Domain/Repositories_abstractions/user_repository.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:mobile_ecommerce/Application/usecases/sign_in_usecase.dart';

import 'Repositories_test/connected_user_repository_sqflite_ffi_impl.dart';
import 'Repositories_test/user_repository_sqflite_ffi_impl.dart';

void main() {
  closeSqfliteFfiDatabase() async {
    var db = await databaseFactoryFfi.openDatabase(inMemoryDatabasePath);
    await db.close();
  }

  group('Sign In Usecase : ', () {
    test('check if user email is registered', () async {
      User user = User();

      user.setUserFirstname('testFirstname');
      user.setUserLastname('testLastname');
      user.setUserEmail('test@gmail.com');
      user.setUserPassword('password');

      UserRepository userRepository = UserRepositorySqfliteFfiImpl();
      ConnectedUserRepository connectedUserRepository =
          ConnectedUserRepositorySqfliteFfiImpl();
      SignInUsecase signInUsecase =
          SignInUsecase(userRepository, connectedUserRepository);

      expect(await signInUsecase.checkIfEmailRegistered(user), false);

      SignUpUsecase signUpUsecase = SignUpUsecase(userRepository);

      await signUpUsecase.signUp(user);

      expect(await signInUsecase.checkIfEmailRegistered(user), true);

      await closeSqfliteFfiDatabase();
    });

    test('check if user password is registered', () async {
      User user = User();

      user.setUserFirstname('testFirstname');
      user.setUserLastname('testLastname');
      user.setUserEmail('test@gmail.com');
      user.setUserPassword('password2');

      UserRepository userRepository = UserRepositorySqfliteFfiImpl();
      ConnectedUserRepository connectedUserRepository =
          ConnectedUserRepositorySqfliteFfiImpl();
      SignInUsecase signInUsecase =
          SignInUsecase(userRepository, connectedUserRepository);

      SignUpUsecase signUpUsecase = SignUpUsecase(userRepository);

      await signUpUsecase.signUp(user);

      expect(await signInUsecase.checkIfEmailRegistered(user), true);

      await closeSqfliteFfiDatabase();
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

      ConnectedUserRepository connectedUserRepository =
          ConnectedUserRepositorySqfliteFfiImpl();
      SignInUsecase signInUsecase =
          SignInUsecase(userRepository, connectedUserRepository);

      var isRegisteredEmail = await signInUsecase.checkIfEmailRegistered(user);

      expect(await isRegisteredEmail, true);

      var isValidAccountPassword =
          await signInUsecase.checkIfValidAccountPassword(user);

      expect(await isValidAccountPassword, true);

      var isUserConnected = await signInUsecase.checkIfUserConnected();

      expect(await isUserConnected, false);

      await signInUsecase.signIn(user);

      var isUserConnectedNow = await signInUsecase.checkIfUserConnected();

      expect(await isUserConnectedNow, true);

      await closeSqfliteFfiDatabase();
    });
  });
}
