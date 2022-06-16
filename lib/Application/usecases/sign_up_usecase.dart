import 'package:mobile_ecommerce/Domain/Repositories_abstractions/user_repository.dart';

class SignUpUsecase {
  UserRepository userRepository;

  SignUpUsecase(this.userRepository);

  checkIfNewUser(Map newUserInfos) async {
    await userRepository.init();

    var user = await userRepository.retrieveUser(newUserInfos);
    await userRepository.close();

    if (user.isEmpty) {
      return true;
    } else {
      return false;
    }
  }

  signUpNewUSer(Map newUser) async {
    await userRepository.init();

    var result = await userRepository.registerUser(newUser);
    await userRepository.close();

    return result;
  }
}
