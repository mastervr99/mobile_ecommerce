import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_ecommerce/Application/usecases/sign_up_usecase.dart';
import 'package:mobile_ecommerce/Application/usecases/update_user_details_usecase.dart';
import 'package:mobile_ecommerce/Domain/Entity/user.dart';
import 'package:mobile_ecommerce/Domain/Repositories_abstractions/user_repository.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import 'Repositories_test/user_repository_sqflite_ffi_impl.dart';

void main() {
  closeSqfliteFfiDatabase() async {
    var db = await databaseFactoryFfi.openDatabase(inMemoryDatabasePath);
    await db.close();
  }

  group('Update User Details Usecase', () {
    test('update user details', () async {
      User user = User();
      user.setUserFirstname('testFirstname');
      user.setUserLastname('testLastname');
      user.setUserEmail('test23@gmail.com');
      user.setUserPassword('password');
      user.set_user_phone_number('0123456789');

      UserRepository user_repository = UserRepositorySqfliteFfiImpl();

      SignUpUsecase signUpUsecase = SignUpUsecase(user_repository);
      await signUpUsecase.signUp(user);

      user.setUserEmail('changing@gmail.com');

      Update_User_Details_Usecase update_user_details_usecase =
          Update_User_Details_Usecase(user_repository);

      await update_user_details_usecase.update(user);

      User user_in_db = await user_repository.retrieveUser(user);

      expect(await user_in_db.getUserEmail(), 'changing@gmail.com');
    });

    test('check if email is new', () async {
      User user = User();
      user.setUserFirstname('testFirstname');
      user.setUserLastname('testLastname');
      user.setUserEmail('user1@gmail.com');
      user.setUserPassword('password');
      user.set_user_phone_number('01234(-789');

      User user2 = User();
      user2.setUserFirstname('testFirstname');
      user2.setUserLastname('testLastname');
      user2.setUserEmail('user2@gmail.com');
      user2.setUserPassword('password');
      user2.set_user_phone_number('0123456789');

      UserRepository user_repository = UserRepositorySqfliteFfiImpl();

      SignUpUsecase signUpUsecase = SignUpUsecase(user_repository);
      await signUpUsecase.signUp(user);
      await signUpUsecase.signUp(user2);

      Update_User_Details_Usecase update_user_details_usecase =
          Update_User_Details_Usecase(user_repository);

      bool is_user2_email_registered =
          await update_user_details_usecase.checkIfEmailRegistered(user2);
      if (!await is_user2_email_registered) {
        user.setUserEmail(user2.getUserEmail());
      }

      expect(await user.getUserEmail(), 'user1@gmail.com');
    });
  });
}
