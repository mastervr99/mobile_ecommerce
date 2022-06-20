import 'dart:async';
import 'package:mobile_ecommerce/Domain/Entity/user.dart';
import 'package:mobile_ecommerce/Domain/Repositories_abstractions/user_repository.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class UserRepositorySqfliteImpl extends UserRepository {
  late var database;

  @override
  init() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, 'mobile_ecom.db');
    database = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      // When creating the db, create the table
      await db.execute('''
        CREATE TABLE Users (
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
    await database.insert('Users', newUser.toMap());
  }

  @override
  retrieveUser(User user) async {
    return await database
        .rawQuery('SELECT * FROM Users WHERE email = ?', [user.getUserEmail()]);
  }

  @override
  Future<void> close() async {
    await database.close();
  }
}
