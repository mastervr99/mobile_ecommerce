import 'package:mobile_ecommerce/Domain/Entity/order_item.dart';

abstract class Order_Item_Repository {
  _init_database();

  register_item(Order_Item order_item);

  retrieve_items_by_order_reference(String order_reference);

  _close_database();
}
