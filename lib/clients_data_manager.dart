import 'database.dart';

class ClientsDataManager {
  Database database;

  ClientsDataManager(this.database);

  createNewClient(String email, String password) {
    database.saveData(email, password);
  }

  checkUserRegistration(String email, String password) {
    if (database.retrieveData(email, password) == [email, password]) {
      return true;
    } else {
      return "user not registered";
    }
  }
}
