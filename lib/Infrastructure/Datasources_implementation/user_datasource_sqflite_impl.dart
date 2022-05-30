import 'package:mobile_ecommerce/Infrastructure/DataSources_abstraction/user_datasource.dart';
import 'package:sqflite_common/sqlite_api.dart';
import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class UserDatasourceSqfliteImpl extends UserDatasource {
  late var database;

  init() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, 'mobile_shop.db');
    database = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      // When creating the db, create the table
      await db.execute('''
        CREATE TABLE Users (
        id INTEGER PRIMARY KEY,
        email TEXT,
        password TEXT
      )
      ''');
    });
  }

  @override
  registerUser(String email, String password) async {
    var user = await retrieveUser(email);
    if (user.isEmpty) {
      await database.insert(
          'Users', <String, Object?>{'email': email, 'password': password});
    }
  }

  @override
  Future retrieveUser(String email) async {
    return await database
        .rawQuery('SELECT * FROM Users WHERE email = ?', [email]);
  }

  Future<void> close() async {
    await database.close();
  }
}
