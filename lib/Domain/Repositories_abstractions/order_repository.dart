import 'package:mobile_ecommerce/Domain/Entity/order.dart';
import 'package:mobile_ecommerce/Domain/Entity/user.dart';

abstract class Order_Repository {
  _init_database();

  retrieve_order_with_reference(String order_reference);

  register_order(Order order);

  retrieve_all_user_orders(User user);

  _close_database();
}
