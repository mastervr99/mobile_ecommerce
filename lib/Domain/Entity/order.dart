import 'package:mobile_ecommerce/Domain/Entity/order_item.dart';

class Order {
  String order_number = '';
  String order_date = '';
  String order_state = '';
  String order_delivery_method = '';

  double order_price = 0;
  List order_items = [];

  set_order_number(String order_number) {
    this.order_number = order_number;
  }

  set_order_date(String order_date) {
    this.order_date = order_date;
  }

  set_order_state(String order_state) {
    this.order_state = order_state;
  }

  set_order_price(double order_price) {
    this.order_price = order_price;
  }

  add_order_items(OrderItem order_items) {
    this.order_items.add(order_items);
  }

  get_order_number() {
    return order_number;
  }

  get_order_date() {
    return order_date;
  }

  get_order_state() {
    return order_state;
  }

  get_order_price() {
    return order_price;
  }

  get_order_items() {
    return order_items;
  }
}
