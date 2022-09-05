import 'package:mobile_ecommerce/Domain/Entity/user.dart';

abstract class ConnectedUserRepository {
  _init_database();

  registerUser(User new_user);

  retrieveConnectedUser();

  removeConnectedUser();

  _close_database();
}
