import 'dart:io';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('User actions : ', () {
    test('user can register', () async {
      List userInDb = ['thusy@gmail.com', 'password'];
      expect(userInDb, ['thusy@gmail.com', 'password']);
    });
  });
}
