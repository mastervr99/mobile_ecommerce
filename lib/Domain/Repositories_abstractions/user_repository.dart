import 'package:mobile_ecommerce/Domain/Entity/user.dart';

abstract class UserRepository {
  _init_database();

  registerUser(User newUser);

  retrieveUser(User user);

  _close_database();
}
