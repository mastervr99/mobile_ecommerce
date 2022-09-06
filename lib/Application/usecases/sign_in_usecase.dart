import 'package:mobile_ecommerce/Domain/Entity/user.dart';
import 'package:mobile_ecommerce/Domain/Repositories_abstractions/connected_user_repository.dart';
import 'package:mobile_ecommerce/Domain/Repositories_abstractions/user_repository.dart';

class SignInUsecase {
  UserRepository userRepository;
  ConnectedUserRepository connectedUserRepository;

  SignInUsecase(this.userRepository, this.connectedUserRepository);

  signIn(User userToConnect) async {
    if (await checkIfUserConnected() == false) {
      if (await checkIfEmailRegistered(userToConnect)) {
        if (await checkIfValidAccountPassword(userToConnect)) {
          User registeredUser = await userRepository
              .retrieve_user_by_email(userToConnect.getUserEmail());
          await connectedUserRepository.registerUser(await registeredUser);
        }
      }
    }
  }

  checkIfEmailRegistered(User user) async {
    var registeredUser =
        await userRepository.retrieve_user_by_email(user.getUserEmail());

    if (await registeredUser is User) {
      return true;
    } else {
      return false;
    }
  }

  checkIfValidAccountPassword(User user) async {
    var registeredUser =
        await userRepository.retrieve_user_by_email(user.getUserEmail());
    var registeredUserPassword = await registeredUser.getUserPassword();

    if (user.getUserPassword() == await registeredUserPassword) {
      return true;
    } else {
      return false;
    }
  }

  checkIfUserConnected() async {
    var connectedUser = await connectedUserRepository.retrieveConnectedUser();

    if (await connectedUser.runtimeType == User) {
      return true;
    } else {
      return false;
    }
  }
}
