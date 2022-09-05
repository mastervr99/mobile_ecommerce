import 'package:mobile_ecommerce/Domain/Entity/user.dart';
import 'package:mobile_ecommerce/Domain/Repositories_abstractions/user_repository.dart';

class SignUpUsecase {
  UserRepository userRepository;

  SignUpUsecase(this.userRepository);

  signUp(User newUser) async {
    if (await checkIfNewUser(newUser)) {
      await userRepository.registerUser(newUser);
    }
  }

  checkIfNewUser(User user) async {
    var registeredUser = await userRepository.retrieveUser(user);

    if (await registeredUser.runtimeType == User) {
      return false;
    } else {
      return true;
    }
  }
}
