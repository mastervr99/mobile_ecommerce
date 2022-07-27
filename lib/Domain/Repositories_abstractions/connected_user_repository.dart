import 'package:mobile_ecommerce/Domain/Entity/user.dart';

abstract class ConnectedUserRepository {
  init();

  registerUser(User newUser);

  retrieveConnectedUser();

  close();
}
