import 'package:mobile_ecommerce/Domain/Entity/shopping_cart_item.dart';
import 'package:mobile_ecommerce/Domain/Repositories_abstractions/shopping_cart_item_repository.dart';

class Remove_Shopping_Cart_Item_Usecase {
  ShoppingCartItemRepository shoppingCartItemRepository;

  Remove_Shopping_Cart_Item_Usecase(this.shoppingCartItemRepository);

  removeItem(ShoppingCartItem shoppingCartItem) async {
    await shoppingCartItemRepository.init();

    await shoppingCartItemRepository.deleteItemData(shoppingCartItem);

    await shoppingCartItemRepository.close();
  }
}
