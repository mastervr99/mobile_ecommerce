import 'package:mobile_ecommerce/Domain/Entity/user.dart';
import 'package:mobile_ecommerce/Domain/Repositories_abstractions/user_repository.dart';

class Update_User_Details_Usecase {
  UserRepository user_repository;

  Update_User_Details_Usecase(
    this.user_repository,
  );

  update(User user) async {
    bool is_new_email_available =
        await check_if_new_email_available(user.getUserEmail());
    if (await is_new_email_available) {
      await user_repository.update_user_data(user);
    }
  }

  check_if_new_email_available(String user_email) async {
    var registeredUser =
        await user_repository.retrieve_user_by_email(user_email);

    if (await registeredUser is User) {
      return false;
    } else {
      return true;
    }
  }
}
