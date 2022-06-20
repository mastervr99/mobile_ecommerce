import 'package:mobile_ecommerce/Domain/Entity/user.dart';
import 'package:mobile_ecommerce/Domain/Repositories_abstractions/user_repository.dart';
import 'package:hive_flutter/hive_flutter.dart';

class SignInUsecase {
  UserRepository userRepository;

  SignInUsecase(this.userRepository);

  checkIfEmailRegistered(User user) async {
    await userRepository.init();

    var registeredUser = await userRepository.retrieveUser(user);
    await userRepository.close();

    if (registeredUser is User) {
      return true;
    } else {
      return false;
    }
  }

  checkIfValidAccountPassword(User user) async {
    var registeredUser = await userRepository.retrieveUser(user);
    if (user.getUserPassword() == await registeredUser.getUserPassword()) {
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

  checkIfUserConnected() async {
    await Hive.initFlutter();
    await Hive.openBox('myBox');
    var box = Hive.box('myBox');
    var isUserConnected = await box.get('isUserConnected');
    if (isUserConnected == true) {
      return true;
    } else {
      return false;
    }
  }
}
