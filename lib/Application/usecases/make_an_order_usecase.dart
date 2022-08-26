import 'package:mobile_ecommerce/Domain/Entity/shopping_cart.dart';
import 'package:mobile_ecommerce/Domain/Repositories_abstractions/shopping_cart_item_repository.dart';

class Make_An_Order_Usecase {
  ShoppingCart shoppingCart = ShoppingCart();

  Make_An_Order_Usecase(ShoppingCartItemRepository shoppingCartItemRepository) {
    shoppingCart.setItemRepository(shoppingCartItemRepository);
  }

  get_cart_items_total_quantity() async {
    return await shoppingCart.getItemsTotalQuantity();
  }

  get_cart_total_price() async {
    return await shoppingCart.getCartTotalPrice();
  }
}
