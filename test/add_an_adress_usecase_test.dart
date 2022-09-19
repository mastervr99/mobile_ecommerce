import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_ecommerce/Application/usecases/add_an_address_usecase.dart';
import 'package:mobile_ecommerce/Domain/Entity/address.dart';
import 'package:mobile_ecommerce/Domain/Entity/user.dart';
import 'package:mobile_ecommerce/Domain/Repositories_abstractions/address_repository.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:sqflite_common/sqlite_api.dart';

import 'Repositories_test/address_repository_sqflite_ffi_impl.dart';

void main() {
  closeSqfliteFfiDatabase() async {
    var db = await databaseFactoryFfi.openDatabase(inMemoryDatabasePath);
    await db.close();
  }

  group('Add An Adress Usecase', () {
    test('user can add an adresse', (() async {
      User user = User();

      user.setUserFirstname('testFirstname');
      user.setUserLastname('testLastname');
      user.setUserEmail('test2@gmail.com');
      user.setUserPassword('password');

      Address address = Address();
      address.set_user_id(user.get_user_id());
      address.set_recipient_name(
          user.get_user_firstname() + user.get_user_lastname());
      address.set_house_number('40');
      address.set_street_name('rue Rosa Parks ');
      address.set_postal_code('75001');
      address.set_city('Paris');
      address.set_country('France');

      Address_Repository address_repository =
          Address_Repository_Sqflite_Ffi_Impl();

      Add_An_Address_Usecase add_an_address_usecase =
          Add_An_Address_Usecase(address_repository);

      await add_an_address_usecase.register_user_address(address);

      var user_addresses =
          await address_repository.retrieve_user_addresses(user);

      expect(await user_addresses[0].get_street_name(), 'rue Rosa Parks ');

      await closeSqfliteFfiDatabase();
    }));
  });
}
