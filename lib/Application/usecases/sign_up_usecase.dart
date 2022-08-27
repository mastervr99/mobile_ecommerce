import 'package:mobile_ecommerce/Domain/Entity/user.dart';
import 'package:mobile_ecommerce/Domain/Repositories_abstractions/user_repository.dart';

class SignUpUsecase {
  UserRepository userRepository;

  SignUpUsecase(this.userRepository);

  checkIfNewUser(User user) async {
    var registeredUser = await userRepository.retrieveUser(user);

    if (registeredUser is User) {
      return false;
    } else {
      return true;
    }
  }

  signUp(User newUser) async {
    var result = await userRepository.registerUser(newUser);

    return result;
  }
}
