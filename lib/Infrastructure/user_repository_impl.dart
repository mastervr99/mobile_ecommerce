import 'package:mobile_ecommerce/Domain/Repositories/UserRepository.dart';
import 'package:mobile_ecommerce/Infrastructure/Datasources_abstraction/user_datasource.dart';

class UserRepositoryImpl extends UserRepository {
  UserDatasource userDatasource;

  UserRepositoryImpl(this.userDatasource);

  @override
  registerUser(Map newUserInfos) {
    return userDatasource.registerUser(newUserInfos);
  }

  @override
  retrieveUser(Map userInfos) {
    return userDatasource.retrieveUser(userInfos);
  }
}
