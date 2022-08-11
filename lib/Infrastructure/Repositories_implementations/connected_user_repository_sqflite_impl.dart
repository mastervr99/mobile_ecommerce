import 'package:mobile_ecommerce/Domain/Entity/user.dart';
import 'package:mobile_ecommerce/Domain/Repositories_abstractions/connected_user_repository.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class ConnectedUserRepositorySqfliteImpl extends ConnectedUserRepository {
  late var database;

  @override
  init() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, 'connectedUsers.db');
    database = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      // When creating the db, create the table
      await db.execute('''
      CREATE TABLE IF NOT EXISTS ConnectedUser (
        id INTEGER PRIMARY KEY,
        email TEXT,
        password TEXT,
        firstname TEXT,
        lastname TEXT
      )
      ''');
    });
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
  close() async {
    await database.close();
  }
}
