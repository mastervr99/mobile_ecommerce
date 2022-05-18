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
      List<Map> userInDb = [
        {'id': 1, 'email': 'thusy@gmail.com', 'password': 'password'},
      ];

      String email = 'thusy@gmail.com';
      String password = 'password';

      UserDatasourceSqfliteFfiImpl userDatasourceSqfliteFfiImpl =
          UserDatasourceSqfliteFfiImpl();
      await userDatasourceSqfliteFfiImpl.init();

      UserRepositoryImpl userRepositoryImpl =
          UserRepositoryImpl(userDatasourceSqfliteFfiImpl);

      await userRepositoryImpl.registerUser(email, password);

      var dataSearchResult = await userRepositoryImpl.retrieveUser(email);

      expect(await dataSearchResult, userInDb);
      await userDatasourceSqfliteFfiImpl.close();
    });
  });
}
