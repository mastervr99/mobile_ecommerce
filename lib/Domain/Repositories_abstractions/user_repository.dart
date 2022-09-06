import 'package:mobile_ecommerce/Domain/Entity/user.dart';

abstract class UserRepository {
  _init_database();

  registerUser(User newUser);

  update_user_data(User user);

  retrieve_user_by_email(String user_email);

  retrieve_user_by_id(String user_id);

  _close_database();
}
