import 'package:mobile_ecommerce/Domain/Entity/user.dart';
import 'package:mobile_ecommerce/Domain/Repositories_abstractions/connected_user_repository.dart';
import 'package:mobile_ecommerce/Domain/Repositories_abstractions/user_repository.dart';

class SignInUsecase {
  UserRepository userRepository;
  ConnectedUserRepository connectedUserRepository;

  SignInUsecase(this.userRepository, this.connectedUserRepository);

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

  signIn(User userToConnect) async {
    await userRepository.init();
    await connectedUserRepository.init();
    User registeredUser = await userRepository.retrieveUser(userToConnect);
    await connectedUserRepository.registerUser(await registeredUser);

    await userRepository.close();
    await connectedUserRepository.close();
  }

  checkIfUserConnected() async {
    await connectedUserRepository.init();
    var connectedUser = await connectedUserRepository.retrieveConnectedUser();
    await connectedUserRepository.close();

    if (await connectedUser.runtimeType == User) {
      return true;
    } else {
      return false;
    }
  }
}
