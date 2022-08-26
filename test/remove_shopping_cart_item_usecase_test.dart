import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_ecommerce/Application/usecases/add_product_to_shopping_cart_usecase.dart';
import 'package:mobile_ecommerce/Application/usecases/remove_shopping_cart_item_usecase.dart';
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

  group('Remove Shopping Cart Item Usecase : ', () {
    test('remove cart item', () async {
      Product product = Product("iphone X");
      product.setSku(100);

      ShoppingCartItemRepository shoppingCartItemRepository =
          ShoppingCartItemRepositorySqfliteFfiImpl();

      Add_Product_To_Shopping_Cart_Usecase
          add_product_to_shopping_cart_usecase =
          Add_Product_To_Shopping_Cart_Usecase(shoppingCartItemRepository);

      await add_product_to_shopping_cart_usecase.addCartItem(product);

      ShoppingCart shoppingCart = ShoppingCart();
      shoppingCart.setItemRepository(shoppingCartItemRepository);

      var shoppingCartProducts = await shoppingCart.getAllCartItems();

      expect(await shoppingCartProducts[0].getSku(), product.getSku());

      Remove_Shopping_Cart_Item_Usecase remove_shopping_cart_item_usecase =
          Remove_Shopping_Cart_Item_Usecase(shoppingCartItemRepository);

      await remove_shopping_cart_item_usecase
          .removeItem(await shoppingCartProducts[0]);

      var shoppingCartProductsAfterRemoval =
          await shoppingCart.getAllCartItems();

      expect(await shoppingCartProductsAfterRemoval.isEmpty, true);

      await closeSqfliteFfiDatabase();
    });
  });
}
