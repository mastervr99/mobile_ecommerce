import 'package:mobile_ecommerce/Domain/Entity/user.dart';

abstract class UserRepository {
  _init_database();

  registerUser(User newUser);

  update_user_data(User user);

  retrieveUser(User user);

  _close_database();
}
