import 'package:mobile_ecommerce/Domain/Entity/user.dart';
import 'package:mobile_ecommerce/Domain/Repositories_abstractions/connected_user_repository.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:sqflite_common/sqlite_api.dart';

class ConnectedUserRepositorySqfliteFfiImpl extends ConnectedUserRepository {
  late var database;

  @override
  init() async {
    database = await databaseFactoryFfi.openDatabase(inMemoryDatabasePath);
    await database.execute('''
      CREATE TABLE IF NOT EXISTS ConnectedUser (
        id INTEGER PRIMARY KEY,
        email TEXT,
        password TEXT,
        firstname TEXT,
        lastname TEXT
      )
      ''');
  }

  @override
  registerUser(User newUser) async {
    await database.insert('ConnectedUser', newUser.toMap());
  }

  @override
  retrieveConnectedUser() async {
    var connectedUserData =
        await database.rawQuery('SELECT * FROM ConnectedUser');

    if (await connectedUserData.isEmpty) {
      return [];
    } else {
      User connectedUser = User();

      connectedUser.setUserFirstname(await connectedUserData[0]['lastname']);
      connectedUser.setUserLastname(await connectedUserData[0]['firstname']);
      connectedUser.setUserEmail(await connectedUserData[0]['email']);
      connectedUser.setUserPassword(await connectedUserData[0]['password']);

      return await connectedUser;
    }
  }

  removeConnectedUser() async {
    await database.rawQuery('DELETE FROM ConnectedUser');
  }

  @override
  close() {}
}
