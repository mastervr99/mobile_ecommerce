import 'package:mobile_ecommerce/Infrastructure/DataSources_abstraction/user_datasource.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:sqflite_common/sqlite_api.dart';
import 'dart:async';

class UserDatasourceSqfliteFfiImpl extends UserDatasource {
  late var database;
  var initialisationCompleter = Completer();
  Future get instanceReady => initialisationCompleter.future;

  init() async {
    database = await databaseFactoryFfi.openDatabase(inMemoryDatabasePath);
    database.execute('''
      CREATE TABLE UsersTest (
        id INTEGER PRIMARY KEY,
        email TEXT,
        password TEXT
      )
      ''');
  }

  @override
  registerUser(String email, String password) async {
    await database.insert(
        'UsersTest', <String, Object?>{'email': email, 'password': password});
  }

  @override
  Future retrieveUser(String email) async {
    return await database.query('UsersTest');
  }

  Future<void> close() async {
    await database.close();
  }
}
