import 'package:mobile_ecommerce/Domain/Entity/product.dart';

abstract class ShoppingCartItemRepository {
  init();

  registerItem(Product product);

  checkIfProductIsAlreadyInCart(Product product);

  retrieveAllItems();

  close();
}
