import 'package:mobile_ecommerce/Domain/Entity/user.dart';

abstract class ConnectedUserRepository {
  _init_database();

  registerUser(User new_user);

  retrieveConnectedUser();

  update_connected_user_data(User user);

  removeConnectedUser();

  _close_database();
}
