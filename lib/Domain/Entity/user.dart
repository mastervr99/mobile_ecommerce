import 'dart:math';

class User {
  String firstname = '';
  String lastname = '';
  String email = '';
  String password = '';
  late String user_id;
  String phone_number = '';

  String getRandomString(int length) {
    var _chars =
        'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    Random _rnd = Random();

    return String.fromCharCodes(
      Iterable.generate(
        length,
        (_) => _chars.codeUnitAt(
          _rnd.nextInt(_chars.length),
        ),
      ),
    );
  }

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

  set_user_phone_number(String phone_number) {
    this.phone_number = phone_number;
  }

  get_user_id() {
    return user_id;
  }

  get_user_firstname() {
    return firstname;
  }

  get_user_lastname() {
    return lastname;
  }

  getUserEmail() {
    return email;
  }

  getUserPassword() {
    return password;
  }

  get_user_phone_number() {
    return phone_number;
  }

  Map<String, dynamic> toMap() {
    return {
      'user_id': user_id,
      'firstname': firstname,
      'lastname': lastname,
      'email': email,
      'password': password,
      'phone_number': phone_number
    };
  }
}
