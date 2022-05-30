import 'package:flutter/widgets.dart';
import 'package:mobile_ecommerce/Infrastructure/Datasources_implementation/user_datasource_sqflite_impl.dart';
import 'package:mobile_ecommerce/Infrastructure/user_repository_impl.dart';

void main() async {
  // Avoid errors caused by flutter upgrade.
  // Importing 'package:flutter/widgets.dart' is required.
  WidgetsFlutterBinding.ensureInitialized();
  // Open the database and store the reference.

  final userDatasource = UserDatasourceSqfliteImpl();
  await userDatasource.init();

  final userRepository = UserRepositoryImpl(userDatasource);

  await userRepository.registerUser('thusy@gmail.com', 'password');
  var dataSearchUser1 = await userRepository.retrieveUser('thusy@gmail.com');

  print(await dataSearchUser1.toString());
}
