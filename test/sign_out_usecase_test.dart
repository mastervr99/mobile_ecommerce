import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_ecommerce/Application/usecases/sign_in_usecase.dart';
import 'package:mobile_ecommerce/Application/usecases/sign_out_usecase.dart';
import 'package:mobile_ecommerce/Application/usecases/sign_up_usecase.dart';
import 'package:mobile_ecommerce/Domain/Entity/user.dart';
import 'package:mobile_ecommerce/Domain/Repositories_abstractions/connected_user_repository.dart';
import 'package:mobile_ecommerce/Domain/Repositories_abstractions/user_repository.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import 'Repositories_impl_test/connected_user_repository_sqflite_ffi_impl.dart';
import 'Repositories_impl_test/user_repository_sqflite_ffi_impl.dart';

void main() {
  closeSqfliteFfiDatabase() async {
    var db = await databaseFactoryFfi.openDatabase(inMemoryDatabasePath);
    await db.close();
  }

  group('Sign Out Usecase', () {
    test('user can sign out', () async {
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
      var isUserConnected = await signInUsecase.checkIfUserConnected();

      expect(isUserConnected, true);

      SignOutUsecase signOutUsecase = SignOutUsecase(connectedUserRepository);

      await signOutUsecase.disconnectUser();

      var isUserStillConnected = await signInUsecase.checkIfUserConnected();
      expect(isUserStillConnected, false);
    });
  });
}
