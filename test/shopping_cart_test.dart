import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_ecommerce/Application/usecases/add_product_to_shopping_cart_usecase.dart';
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

  group('Shopping Cart :', () {
    test('Get Shopping Cart Total Price', () async {
      ShoppingCartItemRepository shoppingCartItemRepository =
          ShoppingCartItemRepositorySqfliteFfiImpl();

      Product product = Product("lg X");
      product.setSku(100);
      product.setPrice(44);

      Product product2 = Product("samsung X");
      product2.setSku(101);
      product2.setPrice(55);

      AddProductToShoppingCartUsecase addProductToShoppingCartUsecase =
          AddProductToShoppingCartUsecase(shoppingCartItemRepository);

      await addProductToShoppingCartUsecase.addCartItem(product);
      await addProductToShoppingCartUsecase.addCartItem(product2);

      var shoppingCart = ShoppingCart();

      await shoppingCart.setItemRepository(shoppingCartItemRepository);

      var cartItemsPricesTotal = await shoppingCart.getCartTotalPrice();
      expect(await cartItemsPricesTotal, 99);

      closeSqfliteFfiDatabase();
    });
  });
}
