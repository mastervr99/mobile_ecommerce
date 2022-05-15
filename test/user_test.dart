import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter/material.dart';
import 'package:sqflite_common/sqlite_api.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  group('User actions : ', () {
    sqfliteFfiInit();

    test('user can register', () async {
      List<Map> userInDb = [
        {'id': 1, 'email': 'thusy@gmail.com', 'password': 'password'},
      ];
      var db = await databaseFactoryFfi.openDatabase(inMemoryDatabasePath);
      await db.execute('''
      CREATE TABLE UsersTest (
        id INTEGER PRIMARY KEY,
        email TEXT,
        password TEXT
      )
      ''');
      await db.insert('UsersTest', <String, Object?>{
        'email': 'thusy@gmail.com',
        'password': 'password'
      });
      var result = await db.query('UsersTest');
      expect(result, userInDb);
      await db.close();
    });
  });
}
