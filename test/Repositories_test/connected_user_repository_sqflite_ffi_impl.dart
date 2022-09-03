import 'package:mobile_ecommerce/Domain/Entity/user.dart';
import 'package:mobile_ecommerce/Domain/Repositories_abstractions/connected_user_repository.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:sqflite_common/sqlite_api.dart';

class ConnectedUserRepositorySqfliteFfiImpl extends ConnectedUserRepository {
  late var database;

  @override
  _init_database() async {
    database = await databaseFactoryFfi.openDatabase(inMemoryDatabasePath);
    await database.execute('''
      CREATE TABLE IF NOT EXISTS ConnectedUser (
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
    await database.insert('ConnectedUser', newUser.toMap());
    await _close_database();
  }

  @override
  retrieveConnectedUser() async {
    await _init_database();

    var connectedUserData =
        await database.rawQuery('SELECT * FROM ConnectedUser');

    if (await connectedUserData.isEmpty) {
      await _close_database();

      return [];
    } else {
      User connectedUser = User();

      connectedUser.set_user_id(await connectedUserData[0]['user_id']);
      connectedUser.setUserFirstname(await connectedUserData[0]['lastname']);
      connectedUser.setUserLastname(await connectedUserData[0]['firstname']);
      connectedUser.setUserEmail(await connectedUserData[0]['email']);
      connectedUser.setUserPassword(await connectedUserData[0]['password']);
      connectedUser.setUserPassword(await connectedUserData[0]['password']);
      connectedUser
          .set_user_phone_number(await connectedUserData[0]['phone_number']);

      await _close_database();

      return await connectedUser;
    }
  }

  @override
  update_connected_user_data(User user) async {
    await _init_database();

    await database.update('ConnectedUser', user.toMap());
    await _close_database();
  }

  @override
  removeConnectedUser() async {
    await _init_database();

    await database.rawQuery('DELETE FROM ConnectedUser');
    await _close_database();
  }

  @override
  _close_database() {}
}
