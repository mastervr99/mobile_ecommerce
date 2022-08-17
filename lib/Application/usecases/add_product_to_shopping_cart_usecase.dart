import 'package:mobile_ecommerce/Domain/Entity/product.dart';
import 'package:mobile_ecommerce/Domain/Entity/shopping_cart_item.dart';
import 'package:mobile_ecommerce/Domain/Repositories_abstractions/shopping_cart_item_repository.dart';

class Add_Product_To_Shopping_Cart_Usecase {
  ShoppingCartItemRepository shoppingCartItemRepository;

  Add_Product_To_Shopping_Cart_Usecase(this.shoppingCartItemRepository);

  addCartItem(Product product) async {
    await shoppingCartItemRepository.init();

    var shoppingCartItem =
        await shoppingCartItemRepository.findItemWithSku(product.getSku());

    if (await shoppingCartItem.runtimeType == ShoppingCartItem) {
      var itemQuantity = await shoppingCartItem.getQuantity();
      await shoppingCartItem.setQuantity(await itemQuantity + 1);

      await shoppingCartItemRepository.updateItemData(await shoppingCartItem);
    } else {
      await shoppingCartItemRepository.registerItem(product);
    }
    await shoppingCartItemRepository.close();
  }
}
