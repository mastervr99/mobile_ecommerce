import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_ecommerce/Application/usecases/add_product_to_shopping_cart_usecase.dart';
import 'package:mobile_ecommerce/Application/usecases/make_an_order_usecase.dart';
import 'package:mobile_ecommerce/Application/usecases/sign_in_usecase.dart';
import 'package:mobile_ecommerce/Application/usecases/sign_up_usecase.dart';
import 'package:mobile_ecommerce/Domain/Entity/order.dart';
import 'package:mobile_ecommerce/Domain/Entity/product.dart';
import 'package:mobile_ecommerce/Domain/Entity/shopping_cart.dart';
import 'package:mobile_ecommerce/Domain/Entity/user.dart';
import 'package:mobile_ecommerce/Domain/Repositories_abstractions/connected_user_repository.dart';
import 'package:mobile_ecommerce/Domain/Repositories_abstractions/order_item_repository.dart';
import 'package:mobile_ecommerce/Domain/Repositories_abstractions/order_repository.dart';
import 'package:mobile_ecommerce/Domain/Repositories_abstractions/payment_gateway.dart';
import 'package:mobile_ecommerce/Domain/Repositories_abstractions/shopping_cart_item_repository.dart';
import 'package:mobile_ecommerce/Domain/Repositories_abstractions/user_repository.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import 'Repositories_test/connected_user_repository_sqflite_ffi_impl.dart';
import 'Repositories_test/order_item_repository_sqflite_ffi_impl.dart';
import 'Repositories_test/shopping_cart_item_repository_sqflite_ffi_impl.dart';
import 'Repositories_test/order_repository_sqflite_ffi_impl.dart';
import 'Repositories_test/test_payment_gateway.dart';
import 'Repositories_test/user_repository_sqflite_ffi_impl.dart';

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

    test('register user order', () async {
      ShoppingCartItemRepository shoppingCartItemRepository =
          ShoppingCartItemRepositorySqfliteFfiImpl();

      Order_Repository order_repository = Order_Repository_Sqflite_Ffi_Impl();

      Order_Item_Repository order_item_repository =
          Order_Item_Repostitory_Sqflite_Ffi_Impl();

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

      User user = User();
      user.set_user_id('DFG4545J');
      user.setUserFirstname('testFirstname');
      user.setUserLastname('testLastname');
      user.setUserEmail('test23@gmail.com');
      user.setUserPassword('password');

      UserRepository userRepository = UserRepositorySqfliteFfiImpl();

      SignUpUsecase signUpUsecase = SignUpUsecase(userRepository);

      await signUpUsecase.signUp(user);

      ConnectedUserRepository connectedUserRepository =
          ConnectedUserRepositorySqfliteFfiImpl();
      SignInUsecase signInUsecase =
          SignInUsecase(userRepository, connectedUserRepository);

      await signInUsecase.signIn(user);

      Make_An_Order_Usecase make_an_order_usecase =
          Make_An_Order_Usecase(shoppingCartItemRepository);

      Order order = Order();
      order.set_order_date('2022-02-02');
      order.set_order_reference("CVD455");
      order.set_order_price(await make_an_order_usecase.get_cart_total_price());
      order.set_order_state("processing");
      order.set_order_delivery_date("2022-06-24");
      order.set_order_hour("16h04");
      order.set_order_delivery_method("UPS");
      order.set_order_payment_method("CREDIT CARD");
      order.set_user_id(user.get_user_id());

      await make_an_order_usecase.register_user_order(
          connectedUserRepository, order, order_repository);

      var order_in_db =
          await order_repository.retrieve_order_with_reference("CVD455");

      expect(
          await order_in_db.get_order_reference(), order.get_order_reference());
      expect(await order_in_db.get_user_id(), user.get_user_id());

      closeSqfliteFfiDatabase();
    });

    test('Register Shopping Cart items as order items', () async {
      ShoppingCartItemRepository shoppingCartItemRepository =
          ShoppingCartItemRepositorySqfliteFfiImpl();

      Order_Item_Repository order_item_repository =
          Order_Item_Repostitory_Sqflite_Ffi_Impl();

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

      Order order = Order();
      order.set_order_date('2022-02-02');
      order.set_order_reference("BDC454");

      await make_an_order_usecase.register_order_items(
          order_item_repository, order);

      var order_items_in_db = await order_item_repository
          .retrieve_items_by_order_reference("BDC454");

      expect(await order_items_in_db[0].getTitle(), 'lg X');
      expect(await order_items_in_db[1].getTitle(), 'samsung X');

      closeSqfliteFfiDatabase();
    });
  });
}
