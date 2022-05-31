import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_ecommerce/Infrastructure/Datasources_implementation/user_datasource_sqflite_ffi_impl.dart';
import 'package:mobile_ecommerce/Infrastructure/user_repository_impl.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  group('User actions : ', () {
    sqfliteFfiInit();

    test('user can sign up', () async {
      Map user1 = {
        'email': 'thusy@gmail.com',
        'password': 'password',
        'firstname': 'thusy',
        'lastname': 'vinay'
      };

      Map user2 = {
        'email': 'thusy@hotmail.com',
        'password': 'password',
        'firstname': 'thusy',
        'lastname': 'vinay'
      };

      final userDatasource = UserDatasourceSqfliteFfiImpl();
      await userDatasource.init();

      final userRepository = UserRepositoryImpl(userDatasource);

      await userRepository.registerUser(user1);
      await userRepository.registerUser(user2);

      var dataSearchUser1 = await userRepository.retrieveUser(user1);
      var dataSearchUser2 = await userRepository.retrieveUser(user2);

      List<Map> user1InDb = [
        {
          'id': 1,
          'email': 'thusy@gmail.com',
          'password': 'password',
          'firstname': 'thusy',
          'lastname': 'vinay'
        },
      ];

      List<Map> user2InDb = [
        {
          'id': 2,
          'email': 'thusy@hotmail.com',
          'password': 'password',
          'firstname': 'thusy',
          'lastname': 'vinay'
        },
      ];

      expect(await dataSearchUser1, user1InDb);
      expect(await dataSearchUser2, user2InDb);
      await userDatasource.close();
    });

    test("user can't sign up twice with same email", () async {
      final userDatasource = UserDatasourceSqfliteFfiImpl();
      await userDatasource.init();

      final userRepository = UserRepositoryImpl(userDatasource);

      Map user = {
        'email': 'thusy@yahoo.com',
        'password': 'password',
        'firstname': 'thusy',
        'lastname': 'vinay'
      };

      await userRepository.registerUser(user);

      var isUserAlreadyRegistered = await userRepository.registerUser(user);
      expect(isUserAlreadyRegistered, "email already used");
      await userDatasource.close();
    });
  });
}
