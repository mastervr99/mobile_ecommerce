import 'package:hive_flutter/hive_flutter.dart';
import 'package:mobile_ecommerce/Domain/Entity/user.dart';

class HiveDataStocker {
  late var box;

  init() async {
    await Hive.initFlutter();
    await Hive.openBox('myBox');
    box = Hive.box('myBox');
  }

  registerUserStatus(bool isUserConnected) async {
    await box.put('isUserConnected', isUserConnected);
  }

  checkUserStatus() async {
    var userStatus = await box.get('isUserConnected');
    return await userStatus;
  }
}
