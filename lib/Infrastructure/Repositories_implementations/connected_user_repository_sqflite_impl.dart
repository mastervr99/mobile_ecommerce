import 'package:mobile_ecommerce/Domain/Entity/user.dart';
import 'package:mobile_ecommerce/Domain/Repositories_abstractions/connected_user_repository.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class ConnectedUserRepositorySqfliteImpl extends ConnectedUserRepository {
  static Database? database;

  @override
  _init_database() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, 'connected_user2.db');
    Database _database = await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        // When creating the db, create the table
        await db.execute('''
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
      },
    );

    return await _database;
  }

  Future<Database> get_database() async {
    if (await database != null) {
      return await database!;
    } else {
      database = await _init_database();
      return await database!;
    }
  }

  @override
  registerUser(User newUser) async {
    Database _database = await get_database();
    await _database.insert('ConnectedUser', newUser.toMap());
    await _close_database();
  }

  @override
  retrieveConnectedUser() async {
    Database _database = await get_database();

    var connectedUserData = [];

    connectedUserData =
        await _database.rawQuery('SELECT * FROM ConnectedUser LIMIT 1');

    await connectedUserData;

    // await _close_database();

    if (await connectedUserData.isEmpty) {
      return [];
    } else {
      User connectedUser = User();

      connectedUser.set_user_id(await connectedUserData[0]['user_id']);
      connectedUser.setUserFirstname(await connectedUserData[0]['firstname']);
      connectedUser.setUserLastname(await connectedUserData[0]['lastname']);
      connectedUser.setUserEmail(await connectedUserData[0]['email']);
      connectedUser.setUserPassword(await connectedUserData[0]['password']);
      connectedUser.setUserPassword(await connectedUserData[0]['password']);
      connectedUser
          .set_user_phone_number(await connectedUserData[0]['phone_number']);

      return await connectedUser;
    }
  }

  @override
  update_connected_user_data(User user) async {
    Database _database = await get_database();

    await _database.update('ConnectedUser', user.toMap(),
        where: 'user_id = ?', whereArgs: [user.get_user_id()]);
    await _close_database();
  }

  @override
  removeConnectedUser() async {
    Database _database = await get_database();

    await _database.rawQuery('DELETE FROM ConnectedUser');
    await _close_database();
  }

  @override
  _close_database() async {
    // final _database = await get_database();
    // database = null;
    // await _database.close();
  }
}
