import 'package:mobile_ecommerce/Domain/Entity/product.dart';
import 'package:mobile_ecommerce/Domain/Repositories_abstractions/shopping_cart_item_repository.dart';

class AddProductToShoppingCartUsecase {
  ShoppingCartItemRepository shoppingCartItemRepository;

  AddProductToShoppingCartUsecase(this.shoppingCartItemRepository);

  addCartItem(Product product) async {
    await shoppingCartItemRepository.init();

    bool isProductalreadyInCart =
        await shoppingCartItemRepository.checkIfProductIsAlreadyInCart(product);

    if (await isProductalreadyInCart) {
      //
    } else {
      await shoppingCartItemRepository.registerItem(product);
    }
    await shoppingCartItemRepository.close();
  }
}
