import 'package:mobile_ecommerce/Domain/Entity/product.dart';
import 'package:mobile_ecommerce/Domain/Entity/shopping_cart_item.dart';

abstract class ShoppingCartItemRepository {
  init();

  registerItem(Product product);

  checkIfProductIsAlreadyInCart(Product product);

  findItemWithSku(int sku);

  updateItemData(ShoppingCartItem item);

  retrieveAllItems();

  deleteItemData(ShoppingCartItem shoppingCartItem);

  close();
}
