import 'package:mobile_ecommerce/Infrastructure/Datasources_abstraction/user_datasource.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:sqflite_common/sqlite_api.dart';
import 'dart:async';

class UserDatasourceSqfliteFfiImpl extends UserDatasource {
  late var database;

  init() async {
    database = await databaseFactoryFfi.openDatabase(inMemoryDatabasePath);
    database.execute('''
      CREATE TABLE UsersTest (
        id INTEGER PRIMARY KEY,
        email TEXT,
        password TEXT,
        firstname TEXT,
        lastname TEXT
      )
      ''');
  }

  @override
  registerUser(Map newUserInfos) async {
    var user = await retrieveUser(newUserInfos);
    if (user.isEmpty) {
      await database.insert('UsersTest', <String, Object?>{
        'email': newUserInfos['email'],
        'password': newUserInfos['password'],
        'firstname': newUserInfos['firstname'],
        'lastname': newUserInfos['lastname'],
      });
      return "user is registered";
    } else {
      return "email already used";
    }
  }

  @override
  Future retrieveUser(Map userInfos) async {
    return await database.rawQuery(
        'SELECT * FROM UsersTest WHERE email = ?', [userInfos['email']]);
  }

  Future<void> close() async {
    await database.close();
  }
}
