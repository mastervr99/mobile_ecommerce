import 'package:mobile_ecommerce/Domain/Repositories_abstractions/user_repository.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:sqflite_common/sqlite_api.dart';

class UserRepositorySqfliteFfiImpl extends UserRepository {
  late var database;

  @override
  init() async {
    database = await databaseFactoryFfi.openDatabase(inMemoryDatabasePath);
    database.execute('''
      CREATE TABLE IF NOT EXISTS Users (
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
    await database.insert('Users', <String, Object?>{
      'email': newUserInfos['email'],
      'password': newUserInfos['password'],
      'firstname': newUserInfos['firstname'],
      'lastname': newUserInfos['lastname'],
    });
  }

  @override
  retrieveUser(Map userInfos) async {
    return await database
        .rawQuery('SELECT * FROM Users WHERE email = ?', [userInfos['email']]);
  }

  @override
  close() {}
}
