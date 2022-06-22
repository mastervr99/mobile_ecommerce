import 'package:hive_flutter/hive_flutter.dart';
import 'package:mobile_ecommerce/Domain/local_data_stocker.dart';

class HiveDataStocker extends LocalDataStocker {
  late var box;

  @override
  init() async {
    await Hive.initFlutter();
    await Hive.openBox('myBox');
    box = Hive.box('myBox');
  }

  @override
  registerUserStatus(bool isUserConnected) async {
    await box.put('isUserConnected', isUserConnected);
  }

  @override
  checkUserStatus() async {
    var userStatus = await box.get('isUserConnected');
    return await userStatus;
  }
}
