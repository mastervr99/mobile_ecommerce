import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_ecommerce/Application/usecases/sign_up_usecase.dart';
import 'package:mobile_ecommerce/Domain/Repositories_abstractions/user_repository.dart';
import 'Repositories_test/user_repository_sqflite_ffi_impl.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('SignUpUsecase : ', () {
    sqfliteFfiInit();

    test('user can sign up', () async {
      Map user1 = {
        'email': 'test@gmail.com',
        'password': 'password',
        'firstname': 'testFirstname',
        'lastname': 'testLastname'
      };

      UserRepository userRepository = UserRepositorySqfliteFfiImpl();

      SignUpUsecase signUpUsecase = SignUpUsecase(userRepository);

      await signUpUsecase.signUpNewUSer(user1);

      var dataSearchUser1 = await userRepository.retrieveUser(user1);

      expect(await dataSearchUser1[0]['email'], user1['email']);
    });

    test("user can't sign up twice with same email", () async {
      UserRepository userRepository = UserRepositorySqfliteFfiImpl();

      SignUpUsecase signUpUsecase = SignUpUsecase(userRepository);

      Map user = {
        'email': 'testt@aol.com',
        'password': 'password',
        'firstname': 'testFirstname',
        'lastname': 'testLastname'
      };

      var isNewUser = await signUpUsecase.checkIfNewUser(user);

      expect(await isNewUser, true);

      await signUpUsecase.signUpNewUSer(user);

      var isStillNewUser = await signUpUsecase.checkIfNewUser(user);

      expect(await isStillNewUser, false);
    });
  });
}
