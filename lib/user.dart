import 'package:mobile_ecommerce/users_manager.dart';

class User {
  UsersManager usersManager = UsersManager();
  register(String name, String password) {
    usersManager.register(name, password);
  }
}
