class CustomFormFieldValidator {
  bool isValidEmail(email) {
    final emailRegExp = RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    return emailRegExp.hasMatch(email);
  }

  bool isValidName(name) {
    final nameRegExp = RegExp(r"^(?=.{1,40}$)[a-zA-Z]+(?:[-'\s][a-zA-Z]+)*$");
    return nameRegExp.hasMatch(name);
  }

  bool isValidPassword(password) {
    /**password with minimum eight characters, at least one uppercase letter, one lowercase letter, one number and one special character**/
    final passwordRegExp = RegExp(
        r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$');
    return passwordRegExp.hasMatch(password);
  }
}
