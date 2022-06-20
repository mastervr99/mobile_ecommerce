import 'package:mobile_ecommerce/Domain/Entity/user.dart';

abstract class UserRepository {
  init();

  registerUser(User newUser);

  retrieveUser(User user);

  close();
}
