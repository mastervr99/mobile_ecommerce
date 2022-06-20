import 'package:hive_flutter/hive_flutter.dart';

class HiveDataStocker {
  registerUserStatus(bool isUserConnected) async {
    await Hive.initFlutter();
    await Hive.openBox('myBox');
    var box = Hive.box('myBox');
    box.put('isUserConnected', isUserConnected);
  }

  checkUserStatus() async {
    await Hive.initFlutter();
    await Hive.openBox('myBox');
    var box = Hive.box('myBox');
    var userStatus = await box.get('isUserConnected');
    return await userStatus;
  }
}
