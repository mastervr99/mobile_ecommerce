import 'package:mobile_ecommerce/Domain/Entity/order.dart';
import 'package:mobile_ecommerce/Domain/Entity/order_item.dart';
import 'package:mobile_ecommerce/Domain/Entity/shopping_cart.dart';
import 'package:mobile_ecommerce/Domain/Entity/user.dart';
import 'package:mobile_ecommerce/Domain/Repositories_abstractions/connected_user_repository.dart';
import 'package:mobile_ecommerce/Domain/Repositories_abstractions/order_item_repository.dart';
import 'package:mobile_ecommerce/Domain/Repositories_abstractions/order_repository.dart';
import 'package:mobile_ecommerce/Domain/Repositories_abstractions/shopping_cart_item_repository.dart';

class Make_An_Order_Usecase {
  ShoppingCart shoppingCart = ShoppingCart();
  ShoppingCartItemRepository shoppingCartItemRepository;

  Make_An_Order_Usecase(this.shoppingCartItemRepository) {
    shoppingCart.setItemRepository(shoppingCartItemRepository);
  }

  get_cart_items_total_quantity() async {
    return await shoppingCart.getItemsTotalQuantity();
  }

  get_cart_total_price() async {
    return await shoppingCart.getCartTotalPrice();
  }

  register_user_order(ConnectedUserRepository connectedUserRepository,
      Order order, Order_Repository order_repository) async {
    User user = await connectedUserRepository.retrieveConnectedUser();

    order.set_user_id(user.get_user_id());
    await order_repository.register_order(order);
  }

  register_order_items(
      Order_Item_Repository order_item_repository, Order order) async {
    var shopping_cart_items =
        await shoppingCartItemRepository.retrieveAllItems();

    await shopping_cart_items.forEach((cart_item) async {
      Order_Item order_item = Order_Item(cart_item.getTitle());
      order_item.setDescription(cart_item.getDescription());
      order_item.setGender(cart_item.getGender());
      order_item.setCategory(cart_item.getCategory());
      order_item.setSubCategory(cart_item.getSubCategory());
      order_item.setType(cart_item.getType());
      order_item.setColor(cart_item.getColor());
      order_item.setUsage(cart_item.getUsage());
      order_item.setImageUrl(cart_item.getImageUrl());
      order_item.setPrice(cart_item.getPrice());
      order_item.setSku(cart_item.getSku());
      order_item.setOrderReference(order.get_order_reference());
      order_item.set_quantity(cart_item.getQuantity());

      await order_item_repository.register_item(order_item);
    });

    _clear_shopping_cart_items();
  }

  _clear_shopping_cart_items() async {
    await shoppingCartItemRepository.deleteAllItems();
  }
}
