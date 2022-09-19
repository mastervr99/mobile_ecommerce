import 'dart:math';

import 'package:mobile_ecommerce/Domain/Entity/user.dart';

class Address {
  String user_id = '';
  String recipient_name = '';
  String house_number = '';
  String street_name = '';
  String postal_code = '';
  String city = '';
  String country = '';
  late String address_id;

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

  Address() {
    this.address_id = getRandomString(10);
  }

  set_user_id(String user_id) {
    this.user_id = user_id;
  }

  sset_address_id(String address_id) {
    this.address_id = address_id;
  }

  set_recipient_name(String recipient_name) {
    this.recipient_name = recipient_name;
  }

  set_house_number(String house_number) {
    this.house_number = house_number;
  }

  set_street_name(String street_name) {
    this.street_name = street_name;
  }

  set_postal_code(String postal_code) {
    this.postal_code = postal_code;
  }

  set_city(String city) {
    this.city = city;
  }

  set_country(String country) {
    this.country = country;
  }

  get_user_id() {
    return user_id;
  }

  get_recipient_name() {
    return recipient_name;
  }

  get_house_number() {
    return house_number;
  }

  get_street_name() {
    return street_name;
  }

  get_postal_code() {
    return postal_code;
  }

  get_city() {
    return city;
  }

  get_country() {
    return country;
  }

  get_address_id() {
    return address_id;
  }

  Map<String, dynamic> toMap() {
    return {
      'user_id': user_id,
      'recipient_name': recipient_name,
      'house_number': house_number,
      'street_name': street_name,
      'postal_code': postal_code,
      'city': city,
      'country': country,
      'address_id': address_id
    };
  }
}
