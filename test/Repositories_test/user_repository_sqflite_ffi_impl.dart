import 'package:mobile_ecommerce/Domain/Entity/user.dart';
import 'package:mobile_ecommerce/Domain/Repositories_abstractions/user_repository.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:sqflite_common/sqlite_api.dart';

class UserRepositorySqfliteFfiImpl extends UserRepository {
  late var database;

  @override
  _init_database() async {
    database = await databaseFactoryFfi.openDatabase(inMemoryDatabasePath);
    await database.execute('''
      CREATE TABLE IF NOT EXISTS Users (
        id INTEGER PRIMARY KEY,
        user_id TEXT,
        email TEXT,
        password TEXT,
        firstname TEXT,
        lastname TEXT,
        phone_number TEXT
      )
      ''');
  }

  @override
  registerUser(User newUser) async {
    await _init_database();

    await database.insert('Users', newUser.toMap());
    await _close_database();
  }

  @override
  update_user_data(User user) async {
    await _init_database();

    await database.update('Users', user.toMap(),
        where: 'user_id = ?', whereArgs: [user.get_user_id()]);
    await _close_database();
  }

  @override
  retrieve_user_by_email(String user_email) async {
    await _init_database();

    var userInfos = await database
        .rawQuery('SELECT * FROM Users WHERE email = ? LIMIT 1', [user_email]);

    if (await userInfos.isEmpty) {
      await _close_database();

      return [];
    } else {
      User registeredUser = User();

      registeredUser.set_user_id(await userInfos[0]['user_id']);
      registeredUser.setUserFirstname(await userInfos[0]['firstname']);
      registeredUser.setUserLastname(await userInfos[0]['lastname']);
      registeredUser.setUserEmail(await userInfos[0]['email']);
      registeredUser.setUserPassword(await userInfos[0]['password']);
      registeredUser.set_user_phone_number(await userInfos[0]['phone_number']);

      await _close_database();

      return await registeredUser;
    }
  }

  @override
  retrieve_user_by_id(String user_id) async {
    await _init_database();

    var userInfos = [];
    try {
      userInfos = await database
          .rawQuery('SELECT * FROM Users WHERE user_id = ? LIMIT 1', [user_id]);
    } catch (e) {
      print(e);
    }

    if (await userInfos.isEmpty) {
      await _close_database();

      return [];
    } else {
      User registeredUser = User();

      registeredUser.set_user_id(await userInfos[0]['user_id']);
      registeredUser.setUserFirstname(await userInfos[0]['firstname']);
      registeredUser.setUserLastname(await userInfos[0]['lastname']);
      registeredUser.setUserEmail(await userInfos[0]['email']);
      registeredUser.setUserPassword(await userInfos[0]['password']);
      registeredUser.set_user_phone_number(await userInfos[0]['phone_number']);

      await _close_database();

      return await registeredUser;
    }
  }

  @override
  _close_database() {}
}
