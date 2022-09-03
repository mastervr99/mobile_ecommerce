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
  });
}
