import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_ecommerce/Infrastructure/Datasources_implementation/user_datasource_sqflite_ffi_impl.dart';
import 'package:mobile_ecommerce/Infrastructure/Datasources_implementation/user_datasource_sqflite_impl.dart';
import 'package:mobile_ecommerce/Infrastructure/user_repository_impl.dart';
import 'package:flutter/material.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  group('User actions : ', () {
    //sqfliteFfiInit();

    test('user can sign up', () async {
      List<Map> user1InDb = [
        {'id': 1, 'email': 'thusy@gmail.com', 'password': 'password'},
      ];

      List<Map> user2InDb = [
        {'id': 2, 'email': 'thusy@hotmail.com', 'password': 'password'},
      ];

      final userDatasource = UserDatasourceSqfliteImpl();
      await userDatasource.init();

      final userRepository = UserRepositoryImpl(userDatasource);

      await userRepository.registerUser('thusy@gmail.com', 'password');
      await userRepository.registerUser('thusy@hotmail.com', 'password');

      var dataSearchUser1 =
          await userRepository.retrieveUser('thusy@gmail.com');
      var dataSearchUser2 =
          await userRepository.retrieveUser('thusy@hotmail.com');

      expect(await dataSearchUser1, user1InDb);
      expect(await dataSearchUser2, user2InDb);
      await userDatasource.close();
    });

    test("user can't sign up twice with same email", () async {
      final userDatasource = UserDatasourceSqfliteFfiImpl();
      await userDatasource.init();

      final userRepository = UserRepositoryImpl(userDatasource);
      await userRepository.registerUser('thusy@gmail.com', 'password');

      var isUserRegistered =
          await userRepository.registerUser('thusy@gmail.com', 'password22');
      expect(isUserRegistered, "email already used");
      await userDatasource.close();
    });
  });
}
