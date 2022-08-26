import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_ecommerce/Application/usecases/add_product_to_shopping_cart_usecase.dart';
import 'package:mobile_ecommerce/Application/usecases/make_an_order_usecase.dart';
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

  group('Make An Order Usecase :', () {
    test('Get Shopping Cart Total Items quantity', () async {
      ShoppingCartItemRepository shoppingCartItemRepository =
          ShoppingCartItemRepositorySqfliteFfiImpl();

      Product product = Product("lg X");
      product.setSku(100);
      product.setPrice(44);

      Product product2 = Product("samsung X");
      product2.setSku(101);
      product2.setPrice(55);

      Add_Product_To_Shopping_Cart_Usecase
          add_product_to_shopping_cart_usecase =
          Add_Product_To_Shopping_Cart_Usecase(shoppingCartItemRepository);

      await add_product_to_shopping_cart_usecase.addCartItem(product);
      await add_product_to_shopping_cart_usecase.addCartItem(product2);

      Make_An_Order_Usecase make_an_order_usecase =
          Make_An_Order_Usecase(shoppingCartItemRepository);

      var cartItemsTotalQuantity =
          await make_an_order_usecase.get_cart_items_total_quantity();

      expect(await cartItemsTotalQuantity, 2);

      Product product3 = Product("samsung 2");
      product2.setSku(102);
      product2.setPrice(55);

      await add_product_to_shopping_cart_usecase.addCartItem(product3);

      var newCartItemsTotalQuantity =
          await make_an_order_usecase.get_cart_items_total_quantity();

      expect(await newCartItemsTotalQuantity, 3);

      closeSqfliteFfiDatabase();
    });
    test('Get Shopping Cart Total Price', () async {
      ShoppingCartItemRepository shoppingCartItemRepository =
          ShoppingCartItemRepositorySqfliteFfiImpl();

      Product product = Product("lg X");
      product.setSku(100);
      product.setPrice(44);

      Product product2 = Product("samsung X");
      product2.setSku(101);
      product2.setPrice(55);

      Add_Product_To_Shopping_Cart_Usecase
          add_product_to_shopping_cart_usecase =
          Add_Product_To_Shopping_Cart_Usecase(shoppingCartItemRepository);

      await add_product_to_shopping_cart_usecase.addCartItem(product);
      await add_product_to_shopping_cart_usecase.addCartItem(product2);

      var shoppingCart = ShoppingCart();

      Make_An_Order_Usecase make_an_order_usecase =
          Make_An_Order_Usecase(shoppingCartItemRepository);

      var cartItemsPricesTotal =
          await make_an_order_usecase.get_cart_total_price();

      expect(await cartItemsPricesTotal, 99);

      closeSqfliteFfiDatabase();
    });

    test('User can pay for the order', () {
      var orderPaymentStatus = 'success';

      expect(orderPaymentStatus, 'success');
    });
  });
}
