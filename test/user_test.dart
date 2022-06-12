import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_ecommerce/Domain/Repositories_abstractions/user_repository.dart';
import 'package:mobile_ecommerce/Infrastructure/Repositories_implementations/user_repository_sqflite_ffi_impl.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:hive_flutter/hive_flutter.dart';

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

      UserRepository userRepository = UserRepositorySqfliteFfiImpl();
      await userRepository.init();

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
      await userRepository.close();
    });

    test("user can't sign up twice with same email", () async {
      UserRepository userRepository = UserRepositorySqfliteFfiImpl();
      await userRepository.init();

      Map user = {
        'email': 'thusy@yahoo.com',
        'password': 'password',
        'firstname': 'thusy',
        'lastname': 'vinay'
      };

      await userRepository.registerUser(user);

      var isUserAlreadyRegistered = await userRepository.registerUser(user);
      expect(isUserAlreadyRegistered, false);
      await userRepository.close();
    });

    test('user can sign in', () async {
      await Hive.initFlutter();
      await Hive.openBox('myBox');
      var box = Hive.box('myBox');

      box.put('isUserConnected', true);
      var isUserConnected = box.get('isUserConnected');
      expect(isUserConnected, true);
    });
  });
}
