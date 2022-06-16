import 'package:mobile_ecommerce/Domain/Repositories_abstractions/user_repository.dart';
import 'package:hive_flutter/hive_flutter.dart';

class SignInUsecase {
  UserRepository userRepository;

  SignInUsecase(this.userRepository);

  checkIfEmailRegistered(Map userInfos) async {
    await userRepository.init();

    var user = await userRepository.retrieveUser(userInfos);
    await userRepository.close();

    if (user.isEmpty) {
      return false;
    } else {
      return true;
    }
  }

  checkIfValidAccountPassword(Map userInfos) async {
    var registeredUser = await userRepository.retrieveUser(userInfos);
    if (userInfos['password'] == await registeredUser[0]['password']) {
      return true;
    } else {
      return false;
    }
  }

  signInRegisteredUser() async {
    await Hive.initFlutter();
    await Hive.openBox('myBox');
    var box = Hive.box('myBox');

    box.put('isUserConnected', true);
  }
}
