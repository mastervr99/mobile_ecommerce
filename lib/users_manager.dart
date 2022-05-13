import 'package:mobile_ecommerce/User.dart';
import 'package:mobile_ecommerce/database.dart';

import 'clients_data_manager.dart';

class UsersManager {
  late Database database;
  ClientsDataManager clientsDataManager = ClientsDataManager(database);

  UsersManager(this.database);

  register(String email, String password) {
    clientsDataManager.createNewClient(email, password);
  }

  checkRegistrationOf(String email, String password) {
    return clientsDataManager.checkUserRegistration(email, password);
  }
}
