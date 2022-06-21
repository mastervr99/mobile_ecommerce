import 'package:mobile_ecommerce/Domain/Entity/user.dart';
import 'package:mobile_ecommerce/Domain/Repositories_abstractions/user_repository.dart';

class SignUpUsecase {
  UserRepository userRepository;

  SignUpUsecase(this.userRepository);

  checkIfNewUser(User user) async {
    await userRepository.init();

    var registeredUser = await userRepository.retrieveUser(user);
    await userRepository.close();

    if (registeredUser is User) {
      return false;
    } else {
      return true;
    }
  }

  signUp(User newUser) async {
    await userRepository.init();

    var result = await userRepository.registerUser(newUser);
    await userRepository.close();

    return result;
  }
}
