import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_ecommerce/Infrastructure/Datasources_implementation/user_datasource_sqflite_ffi_impl.dart';
import 'package:mobile_ecommerce/Infrastructure/user_repository_impl.dart';
import 'package:flutter/material.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  group('User actions : ', () {
    sqfliteFfiInit();

    test('user can register', () async {
      List<Map> user1InDb = [
        {'id': 1, 'email': 'thusy@gmail.com', 'password': 'password'},
      ];

      List<Map> user2InDb = [
        {'id': 2, 'email': 'thusy@hotmail.com', 'password': 'password'},
      ];

      UserDatasourceSqfliteFfiImpl userDatasourceSqfliteFfiImpl =
          UserDatasourceSqfliteFfiImpl();
      await userDatasourceSqfliteFfiImpl.init();

      UserRepositoryImpl userRepositoryImpl =
          UserRepositoryImpl(userDatasourceSqfliteFfiImpl);

      await userRepositoryImpl.registerUser('thusy@gmail.com', 'password');
      await userRepositoryImpl.registerUser('thusy@hotmail.com', 'password');

      var dataSearchUser1 =
          await userRepositoryImpl.retrieveUser('thusy@gmail.com');
      var dataSearchUser2 =
          await userRepositoryImpl.retrieveUser('thusy@hotmail.com');

      expect(await dataSearchUser1, user1InDb);
      expect(await dataSearchUser2, user2InDb);
      await userDatasourceSqfliteFfiImpl.close();
    });

    test("user can't register twice with same email", () async {
      UserDatasourceSqfliteFfiImpl userDatasourceSqfliteFfiImpl =
          UserDatasourceSqfliteFfiImpl();
      await userDatasourceSqfliteFfiImpl.init();

      UserRepositoryImpl userRepositoryImpl =
          UserRepositoryImpl(userDatasourceSqfliteFfiImpl);
      await userRepositoryImpl.registerUser('thusy@gmail.com', 'password');

      var isUserRegistered = await userRepositoryImpl.registerUser(
          'thusy@gmail.com', 'password22');
      expect(isUserRegistered, "email already used");
      await userDatasourceSqfliteFfiImpl.close();
    });
  });
}
