import 'package:mobile_ecommerce/Domain/Entity/user.dart';
import 'package:mobile_ecommerce/Domain/Repositories_abstractions/connected_user_repository.dart';
import 'package:mobile_ecommerce/Domain/Repositories_abstractions/user_repository.dart';

class SignInUsecase {
  UserRepository userRepository;
  ConnectedUserRepository connectedUserRepository;

  SignInUsecase(this.userRepository, this.connectedUserRepository);

  checkIfEmailRegistered(User user) async {
    var registeredUser = await userRepository.retrieveUser(user);

    if (registeredUser is User) {
      return true;
    } else {
      return false;
    }
  }

  checkIfValidAccountPassword(User user) async {
    var registeredUser = await userRepository.retrieveUser(user);
    var registeredUserPassword = await registeredUser.getUserPassword();

    if (user.getUserPassword() == await registeredUserPassword) {
      return true;
    } else {
      return false;
    }
  }

  signIn(User userToConnect) async {
    User registeredUser = await userRepository.retrieveUser(userToConnect);
    await connectedUserRepository.registerUser(await registeredUser);
  }

  checkIfUserConnected() async {
    var connectedUser = await connectedUserRepository.retrieveConnectedUser();
    // **************** REMOVED BECAUSE OF A PROBLEM - TO REMOVE *****************
    // await connectedUserRepository.close();

    if (await connectedUser.runtimeType == User) {
      return true;
    } else {
      return false;
    }
  }
}
