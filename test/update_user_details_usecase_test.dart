import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_ecommerce/Application/usecases/sign_up_usecase.dart';
import 'package:mobile_ecommerce/Application/usecases/update_user_details_usecase.dart';
import 'package:mobile_ecommerce/Domain/Entity/user.dart';
import 'package:mobile_ecommerce/Domain/Repositories_abstractions/user_repository.dart';
import 'package:sqflite_common/sqlite_api.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import 'Repositories_test/user_repository_sqflite_ffi_impl.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  closeSqfliteFfiDatabase() async {
    var db = await databaseFactoryFfi.openDatabase(inMemoryDatabasePath);
    await db.close();
  }

  group('Update User Details Usecase : ', () {
    test('user can update his details', () async {
      User user = User();
      user.setUserFirstname('testFirstname');
      user.setUserLastname('testLastname');
      user.setUserEmail('test23@gmail.com');
      user.setUserPassword('Test1234@');
      user.set_user_phone_number('0123456789');

      UserRepository user_repository = UserRepositorySqfliteFfiImpl();

      SignUpUsecase signUpUsecase = SignUpUsecase(user_repository);
      await signUpUsecase.signUp(user);

      user.setUserEmail('changing@gmail.com');

      Update_User_Details_Usecase update_user_details_usecase =
          Update_User_Details_Usecase(user_repository);

      await update_user_details_usecase.update(user);

      var user_in_db =
          await user_repository.retrieve_user_by_id(user.get_user_id());

      expect(await user_in_db.getUserEmail(), 'changing@gmail.com');

      await closeSqfliteFfiDatabase();
    });

    test('user can update email only if new email not already assigned',
        () async {
      User user = User();
      user.setUserFirstname('testFirstname');
      user.setUserLastname('testLastname');
      user.setUserEmail('user1@gmail.com');
      user.setUserPassword('Test1234@');
      user.set_user_phone_number('0123445789');

      User user2 = User();
      user2.setUserFirstname('testFirstname');
      user2.setUserLastname('testLastname');
      user2.setUserEmail('user2@gmail.com');
      user.setUserPassword('Test1234@');
      user2.set_user_phone_number('0123456789');

      UserRepository user_repository = UserRepositorySqfliteFfiImpl();

      SignUpUsecase signUpUsecase = SignUpUsecase(user_repository);
      await signUpUsecase.signUp(user);
      await signUpUsecase.signUp(user2);

      Update_User_Details_Usecase update_user_details_usecase =
          Update_User_Details_Usecase(user_repository);

      bool is_user2_email_available = await update_user_details_usecase
          .check_if_new_email_available(user2.getUserEmail());
      if (await is_user2_email_available) {
        user.setUserEmail(user2.getUserEmail());
      }

      expect(await user.getUserEmail(), 'user1@gmail.com');

      await closeSqfliteFfiDatabase();
    });
  });
}
