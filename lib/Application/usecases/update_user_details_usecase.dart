import 'package:mobile_ecommerce/Domain/Entity/user.dart';
import 'package:mobile_ecommerce/Domain/Repositories_abstractions/user_repository.dart';

class Update_User_Details_Usecase {
  UserRepository user_repository;

  Update_User_Details_Usecase(this.user_repository);

  update(User user) async {
    if (!await checkIfEmailRegistered(user)) {
      await user_repository.update_user_data(user);
    }
  }

  checkIfEmailRegistered(User user) async {
    var registeredUser = await user_repository.retrieveUser(user);

    if (registeredUser is User) {
      return true;
    } else {
      return false;
    }
  }
}
