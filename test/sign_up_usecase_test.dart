import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_ecommerce/Application/usecases/sign_up_usecase.dart';
import 'package:mobile_ecommerce/Domain/Entity/user.dart';
import 'package:mobile_ecommerce/Domain/Repositories_abstractions/user_repository.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'Repositories_impl_test/user_repository_sqflite_ffi_impl.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  closeSqfliteFfiDatabase() async {
    var db = await databaseFactoryFfi.openDatabase(inMemoryDatabasePath);
    await db.close();
  }

  group('Sign Up Usecase : ', () {
    test('user can sign up', () async {
      User user = User();
      user.setUserFirstname('testFirstname');
      user.setUserLastname('testLastname');
      user.setUserEmail('test23@gmail.com');
      user.setUserPassword('password');

      UserRepository userRepository = UserRepositorySqfliteFfiImpl();

      SignUpUsecase signUpUsecase = SignUpUsecase(userRepository);

      await signUpUsecase.signUp(user);

      User dataSearchUser1 = await userRepository.retrieveUser(user);

      expect(await dataSearchUser1.getUserEmail(), user.getUserEmail());

      await closeSqfliteFfiDatabase();
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

      await signUpUsecase.signUp(user);

      var isStillNewUser = await signUpUsecase.checkIfNewUser(user);

      expect(await isStillNewUser, false);

      await closeSqfliteFfiDatabase();
    });
  });
}
