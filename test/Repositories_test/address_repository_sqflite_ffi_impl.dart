import 'package:mobile_ecommerce/Domain/Entity/address.dart';
import 'package:mobile_ecommerce/Domain/Entity/user.dart';
import 'package:mobile_ecommerce/Domain/Repositories_abstractions/address_repository.dart';
import 'package:sqflite_common/sqlite_api.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class Address_Repository_Sqflite_Ffi_Impl extends Address_Repository {
  static Database? database;

  @override
  _init_database() async {
    Database _database =
        await databaseFactoryFfi.openDatabase(inMemoryDatabasePath);
    await _database.execute('''
      CREATE TABLE IF NOT EXISTS address (
        id INTEGER PRIMARY KEY,
        address_id TEXT,
        user_id TEXT,
        recipient_name TEXT,
        house_number TEXT,
        street_name TEXT,
        postal_code TEXT,
        city TEXT,
        country TEXT
      )
      ''');

    return await _database;
  }

  @override
  Future<Database> get_database() async {
    if (database == null) {
      database = await _init_database();
    }
    return await database!;
  }

  @override
  register_user_address(Address address) async {
    Database _database = await get_database();
    await _database.insert('address', address.toMap());
    await _close_database();
  }

  @override
  update_user_address(Address address) async {
    Database _database = await get_database();
    await _database.update('address', address.toMap(),
        where: 'address_id = ?', whereArgs: [address.get_address_id()]);
    await _close_database();
  }

  @override
  remove_user_address(Address address) async {
    Database _database = await get_database();
    await _database.delete('address',
        where: "address_id = ?", whereArgs: [address.get_address_id()]);
    await _close_database();
  }

  @override
  retrieve_user_addresses(User user) async {
    Database _database = await get_database();

    var user_addresses_data = [];

    user_addresses_data = await _database.rawQuery(
        "SELECT * FROM address WHERE user_id = ?", [user.get_user_id()]);

    List<Address> user_addresses = [];
    if (await user_addresses_data.isNotEmpty) {
      for (var address_data in await user_addresses_data) {
        Address address = Address();
        address.set_user_id(address_data['user_id']);
        address.sset_address_id(address_data['address_id']);
        address.set_recipient_name(address_data['recipient_name']);
        address.set_house_number(address_data['house_number']);
        address.set_street_name(address_data['street_name']);
        address.set_postal_code(address_data['postal_code']);
        address.set_city(address_data['city']);
        address.set_country(address_data['country']);

        user_addresses.add(address);
      }
    }

    await _close_database();

    return user_addresses;
  }

  @override
  _close_database() async {
    // final _database = await get_database();
    // database = null;
    // await _database.close();
  }
}
