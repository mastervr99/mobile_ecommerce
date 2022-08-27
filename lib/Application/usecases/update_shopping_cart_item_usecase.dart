import 'package:mobile_ecommerce/Domain/Entity/shopping_cart_item.dart';
import 'package:mobile_ecommerce/Domain/Repositories_abstractions/shopping_cart_item_repository.dart';

class UpdateShoppingCartItemUsecase {
  ShoppingCartItemRepository shoppingCartItemRepository;

  UpdateShoppingCartItemUsecase(this.shoppingCartItemRepository);

  updateItem(ShoppingCartItem shoppingCartItem) async {
    await shoppingCartItemRepository.updateItemData(shoppingCartItem);
  }
}
