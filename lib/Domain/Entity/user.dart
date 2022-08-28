import 'dart:math';

class User {
  String firstname = '';
  String lastname = '';
  String email = '';
  String password = '';
  late String user_id;

  final _chars =
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  final Random _rnd = Random();

  String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
      length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));

  User() {
    user_id = getRandomString(10);
  }

  set_user_id(String user_id) {
    this.user_id = user_id;
  }

  setUserFirstname(String firstname) {
    this.firstname = firstname;
  }

  setUserLastname(String lastname) {
    this.lastname = lastname;
  }

  setUserEmail(String email) {
    this.email = email;
  }

  setUserPassword(String password) {
    this.password = password;
  }

  get_user_id() {
    return user_id;
  }

  getUserEmail() {
    return email;
  }

  getUserPassword() {
    return password;
  }

  Map<String, dynamic> toMap() {
    return {
      'user_id': user_id,
      'firstname': firstname,
      'lastname': lastname,
      'email': email,
      'password': password
    };
  }
}
