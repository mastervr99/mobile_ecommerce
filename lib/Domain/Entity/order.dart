import 'dart:math';

import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

class Order {
  String order_reference = "";
  String order_date = '';
  String order_hour = '';
  String order_state = '';
  String order_delivery_method = '';
  String order_payment_method = '';
  double order_price = 0;
  String order_delivery_date = '';
  String user_id = '';
  String order_delivery_address = '';

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

  Order() {
    this.order_reference = getRandomString(10).toUpperCase();
    initializeDateFormatting();
    DateTime currentDateTime = DateTime.now();
    this.order_date = DateFormat("dd-MM-yyyy").format(currentDateTime);
    this.order_hour = DateFormat("HH:mm").format(currentDateTime);
  }

  set_order_reference(String order_reference) {
    this.order_reference = order_reference;
  }

  set_order_date(String order_date) {
    this.order_date = order_date;
  }

  set_order_hour(String order_hour) {
    this.order_hour = order_hour;
  }

  set_order_state(String order_state) {
    this.order_state = order_state;
  }

  set_order_price(double order_price) {
    this.order_price = order_price;
  }

  set_order_payment_method(String order_payment_method) {
    this.order_payment_method = order_payment_method;
  }

  set_order_delivery_method(String order_delivery_method) {
    this.order_delivery_method = order_delivery_method;
  }

  set_order_delivery_date(String order_delivery_date) {
    this.order_delivery_date = order_delivery_date;
  }

  set_user_id(String user_id) {
    this.user_id = user_id;
  }

  set_order_delivery_address(String order_delivery_address) {
    this.order_delivery_address = order_delivery_address;
  }

  get_order_reference() {
    return order_reference;
  }

  get_order_date() {
    return order_date;
  }

  get_order_hour() {
    return order_hour;
  }

  get_order_state() {
    return order_state;
  }

  get_order_price() {
    return order_price;
  }

  get_order_delivery_date() {
    return order_delivery_date;
  }

  get_order_delivery_method() {
    return order_delivery_method;
  }

  get_order_payment_method() {
    return order_payment_method;
  }

  get_order_delivery_address() {
    return order_delivery_address;
  }

  get_user_id() {
    return user_id;
  }

  Map<String, dynamic> toMap() {
    return {
      'user_id': user_id,
      'order_reference': order_reference,
      'order_date': order_date,
      'order_hour': order_hour,
      'order_state': order_state,
      'order_price': order_price,
      'order_delivery_method': order_delivery_method,
      'order_payment_method': order_payment_method,
      'order_delivery_date': order_delivery_date,
      'order_delivery_address': order_delivery_address
    };
  }
}
