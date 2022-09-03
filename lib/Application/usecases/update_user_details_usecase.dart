import 'package:mobile_ecommerce/Domain/Entity/user.dart';
import 'package:mobile_ecommerce/Domain/Repositories_abstractions/user_repository.dart';

class Update_User_Details_Usecase {
  UserRepository user_repository;

  Update_User_Details_Usecase(this.user_repository);

  update(User user) async {
    await user_repository.update_user_data(user);
  }
}
