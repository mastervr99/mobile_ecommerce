import 'package:mobile_ecommerce/Infrastructure/DataSources_abstraction/user_datasource.dart';

class UserRepositoryImpl {
  UserDatasource userDatasource;

  UserRepositoryImpl(this.userDatasource);

  registerUser(String email, String password) {
    return userDatasource.registerUser(email, password);
  }

  retrieveUser(String email) {
    return userDatasource.retrieveUser(email);
  }
}
