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

  bool check_if_valid_street_name(street_name) {
    final street_name_reg_exp = RegExp(r"^[#.0-9a-zA-Z\s,-]+$");
    return street_name_reg_exp.hasMatch(street_name);
  }

  bool check_if_valid_phone_number(phone_number) {
    final phone_number_reg_exp = RegExp(r'(^(?:[+0]9)?[0-9]{10,12}$)');

    return phone_number_reg_exp.hasMatch(phone_number);
  }

  bool check_if_valid_house_number(house_number) {
    final house_number_reg_exp = RegExp(r"^[#.0-9a-zA-Z\s,-]+$");

    return house_number_reg_exp.hasMatch(house_number);
  }

  bool check_if_valid_postal_code(postal_code) {
    final postal_code_reg_exp =
        RegExp(r"^[a-z0-9][a-z0-9\- ]{0,10}[a-z0-9]$", caseSensitive: false);

    return postal_code_reg_exp.hasMatch(postal_code);
  }
}
