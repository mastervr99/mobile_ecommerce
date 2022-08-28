import 'package:mobile_ecommerce/Domain/Entity/order.dart';
import 'package:mobile_ecommerce/Domain/Entity/order_item.dart';
import 'package:mobile_ecommerce/Domain/Entity/shopping_cart.dart';
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

  register_order(Order order, Order_Repository order_repository,
      Order_Item_Repository order_item_repository) async {
    await order_repository.register_order(order);

    var shopping_cart_items =
        await shoppingCartItemRepository.retrieveAllItems();

    await shopping_cart_items.forEach((cart_item) async {
      Order_Item order_item = Order_Item(await cart_item.getTitle());
      order_item.setDescription(await cart_item.getDescription());
      order_item.setGender(await cart_item.getGender());
      order_item.setCategory(await cart_item.getCategory());
      order_item.setSubCategory(await cart_item.getSubCategory());
      order_item.setType(await cart_item.getType());
      order_item.setColor(await cart_item.getColor());
      order_item.setUsage(await cart_item.getUsage());
      order_item.setImageUrl(await cart_item.getImageUrl());
      order_item.setPrice(await cart_item.getPrice());
      order_item.setSku(await cart_item.getSku());
      order_item.setOrderReference(order.get_order_reference());

      await order_item_repository.register_item(order_item);
    });
  }
}
