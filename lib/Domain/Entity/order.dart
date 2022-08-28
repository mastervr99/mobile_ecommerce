import 'dart:ffi';

import 'package:mobile_ecommerce/Domain/Entity/order_item.dart';

class Order {
  String order_reference = "";
  String order_date = '';
  String order_hour = '';
  String order_state = '';
  String order_delivery_method = '';
  String order_payment_method = '';
  double order_price = 0;
  String order_delivery_date = '';

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

  Map<String, dynamic> toMap() {
    return {
      'order_reference': order_reference,
      'order_date': order_date,
      'order_hour': order_hour,
      'order_state': order_state,
      'order_price': order_price,
      'order_delivery_method': order_delivery_method,
      'order_payment_method': order_payment_method,
      'order_delivery_date': order_delivery_date
    };
  }
}
