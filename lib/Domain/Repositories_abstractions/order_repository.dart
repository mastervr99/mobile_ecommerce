import 'package:mobile_ecommerce/Domain/Entity/order.dart';

abstract class Order_Repository {
  _init_database();

  retrieve_order_with_reference(String order_reference);

  register_order(Order order);

  _close_database();
}
