import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_ecommerce/Application/usecases/add_product_to_shopping_cart_usecase.dart';
import 'package:mobile_ecommerce/Domain/Entity/product.dart';
import 'package:mobile_ecommerce/Domain/Entity/shopping_cart.dart';
import 'package:mobile_ecommerce/Domain/Repositories_abstractions/shopping_cart_item_repository.dart';
import 'package:sqflite_common/sqlite_api.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import 'Repositories_test/shopping_cart_item_repository_sqflite_ffi_impl.dart';

void main() {
  closeSqfliteFfiDatabase() async {
    var db = await databaseFactoryFfi.openDatabase(inMemoryDatabasePath);
    await db.close();
  }

  group('Shopping Cart Usecase : ', () {
    test('add product to cart', () async {
      Product product = Product("iphone X");
      product.setSku(100);
      Product product2 = Product("samsung 12");
      product2.setSku(101);

      ShoppingCartItemRepository shoppingCartItemRepository =
          ShoppingCartItemRepositorySqfliteFfiImpl();

      Add_Product_To_Shopping_Cart_Usecase
          add_product_to_shopping_cart_usecase =
          Add_Product_To_Shopping_Cart_Usecase(shoppingCartItemRepository);

      await add_product_to_shopping_cart_usecase.addCartItem(product);
      await add_product_to_shopping_cart_usecase.addCartItem(product2);

      ShoppingCart shoppingCart = ShoppingCart();
      shoppingCart.setItemRepository(shoppingCartItemRepository);

      var shoppingCartProducts = await shoppingCart.getAllCartItems();

      expect(await shoppingCartProducts[0].getTitle(), 'iphone X');
      expect(await shoppingCartProducts[1].getTitle(), 'samsung 12');

      await closeSqfliteFfiDatabase();
    });

    test('increment quantity of existing cart item', () async {
      Product product = Product("lg X");
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

      expect(await shoppingCartProducts[0].getQuantity(), 1);

      await add_product_to_shopping_cart_usecase.addCartItem(product);

      var shoppingCartProducts2 = await shoppingCart.getAllCartItems();

      expect(await shoppingCartProducts2[0].getQuantity(), 2);

      await closeSqfliteFfiDatabase();
    });
  });
}
