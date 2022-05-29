import 'package:mobile_ecommerce/Infrastructure/DataSources_abstraction/user_datasource.dart';
import 'package:mobile_ecommerce/Domain/Repositories/UserRepository.dart';

class UserRepositoryImpl extends UserRepository {
  UserDatasource userDatasource;

  UserRepositoryImpl(this.userDatasource);

  @override
  registerUser(String email, String password) {
    return userDatasource.registerUser(email, password);
  }

  @override
  retrieveUser(String email) {
    return userDatasource.retrieveUser(email);
  }
}
