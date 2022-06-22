import 'package:mobile_ecommerce/Application/hive_data_stocker.dart';
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
    await userRepository.init();
    var registeredUser = await userRepository.retrieveUser(user);
    var registeredUserPassword = await registeredUser.getUserPassword();
    await userRepository.close();

    if (user.getUserPassword() == await registeredUserPassword) {
      return true;
    } else {
      return false;
    }
  }

  signIn(User user) async {
    bool isUserConnected = true;

    HiveDataStocker localDataStocker = HiveDataStocker();
    await localDataStocker.init();

    await localDataStocker.registerUserStatus(isUserConnected);
  }

  checkUserStatus() async {
    HiveDataStocker localDataStocker = HiveDataStocker();
    await localDataStocker.init();
    bool userStatus = await localDataStocker.checkUserStatus();

    if (userStatus) {
      return true;
    } else {
      return false;
    }
  }
}
