import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_ecommerce/Application/usecases/sign_up_usecase.dart';
import 'package:mobile_ecommerce/Domain/Entity/user.dart';
import 'package:mobile_ecommerce/Domain/Repositories_abstractions/connected_user_repository.dart';
import 'package:mobile_ecommerce/Domain/Repositories_abstractions/user_repository.dart';
import 'package:mobile_ecommerce/Infrastructure/Repositories_implementations/connected_user_repository_sqflite_impl.dart';
import 'package:sqflite_common/sqlite_api.dart';
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

      expect(await signInUsecase.checkIfValidAccountPassword(user), true);

      user.setUserPassword('new_password_without_updating_database');

      expect(await signInUsecase.checkIfValidAccountPassword(user), false);

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

      await signInUsecase.signIn(user);

      var isUserConnectedNow = await signInUsecase.checkIfUserConnected();

      expect(await isUserConnectedNow, true);

      await closeSqfliteFfiDatabase();
    });

    test('user can not sign in if already connected', () async {
      User user = User();
      user.setUserFirstname('testFirstname');
      user.setUserLastname('testLastname');
      user.setUserEmail('test23@gmail.com');
      user.setUserPassword('password');

      UserRepository userRepository = UserRepositorySqfliteFfiImpl();

      SignUpUsecase signUpUsecase = SignUpUsecase(userRepository);
      await signUpUsecase.signUp(user);

      ConnectedUserRepository connectedUserRepository =
          ConnectedUserRepositorySqfliteFfiImpl();

      SignInUsecase signInUsecase =
          SignInUsecase(userRepository, connectedUserRepository);

      await signInUsecase.signIn(user);

      User connectedUser =
          await connectedUserRepository.retrieveConnectedUser();

      bool is_first_user_connected =
          await connectedUser.getUserEmail() == user.getUserEmail();

      expect(is_first_user_connected, true);

      User second_user = User();
      second_user.setUserFirstname('testFirstname');
      second_user.setUserLastname('testLastname');
      second_user.setUserEmail('test222223@gmail.com');
      second_user.setUserPassword('password');

      await signUpUsecase.signUp(second_user);

      await signInUsecase.signIn(second_user);

      User new_connected_user =
          await connectedUserRepository.retrieveConnectedUser();

      bool is_second_user_connected =
          await new_connected_user.getUserEmail() == second_user.getUserEmail();

      expect(is_second_user_connected, false);

      await closeSqfliteFfiDatabase();
    });
  });
}
