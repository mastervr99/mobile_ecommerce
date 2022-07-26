import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_ecommerce/Application/usecases/add_product_to_shopping_cart_usecase.dart';
import 'package:mobile_ecommerce/Application/usecases/update_shopping_cart_item_usecase.dart';
import 'package:mobile_ecommerce/Domain/Entity/product.dart';
import 'package:mobile_ecommerce/Domain/Entity/shopping_cart.dart';
import 'package:mobile_ecommerce/Domain/Repositories_abstractions/shopping_cart_item_repository.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import 'Repositories_test/shopping_cart_item_repository_sqflite_ffi_impl.dart';

void main() {
  closeSqfliteFfiDatabase() async {
    var db = await databaseFactoryFfi.openDatabase(inMemoryDatabasePath);
    await db.close();
  }

  group('Update Shopping Cart Item Usecase : ', () {
    test('update shopping cart item parameters', () async {
      Product product = Product("lg X");
      product.setSku(100);

      ShoppingCartItemRepository shoppingCartItemRepository =
          ShoppingCartItemRepositorySqfliteFfiImpl();

      AddProductToShoppingCartUsecase addProductToShoppingCartUsecase =
          AddProductToShoppingCartUsecase(shoppingCartItemRepository);

      await addProductToShoppingCartUsecase.addCartItem(product);

      ShoppingCart shoppingCart = ShoppingCart();
      shoppingCart.setItemRepository(shoppingCartItemRepository);

      var shoppingCartProducts = await shoppingCart.getAllCartItems();

      expect(await shoppingCartProducts[0].getSku(), product.getSku());
      expect(await shoppingCartProducts[0].getQuantity(), 1);

      UpdateShoppingCartItemUsecase updateShoppingCartItemUsecase =
          UpdateShoppingCartItemUsecase(shoppingCartItemRepository);

      await shoppingCartProducts[0].setQuantity(5);

      updateShoppingCartItemUsecase.updateItem(await shoppingCartProducts[0]);

      var shoppingCartProducts2 = await shoppingCart.getAllCartItems();

      expect(await shoppingCartProducts2[0].getSku(), product.getSku());
      expect(await shoppingCartProducts2[0].getQuantity(), 5);

      await closeSqfliteFfiDatabase();
    });
  });
}
