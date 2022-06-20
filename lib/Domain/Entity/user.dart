class User {
  late String firstname;
  late String lastname;
  late String email;
  late String password;

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

  getUserEmail() {
    return email;
  }

  getUserPassword() {
    return password;
  }

  Map<String, dynamic> toMap() {
    return {
      'firstname': firstname,
      'lastname': lastname,
      'email': email,
      'password': password
    };
  }
}
