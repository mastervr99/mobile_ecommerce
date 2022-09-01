import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_ecommerce/Application/usecases/add_product_to_shopping_cart_usecase.dart';
import 'package:mobile_ecommerce/Application/usecases/make_an_order_usecase.dart';
import 'package:mobile_ecommerce/Application/usecases/sign_in_usecase.dart';
import 'package:mobile_ecommerce/Application/usecases/sign_up_usecase.dart';
import 'package:mobile_ecommerce/Domain/Entity/order.dart';
import 'package:mobile_ecommerce/Domain/Entity/product.dart';
import 'package:mobile_ecommerce/Domain/Entity/user.dart';
import 'package:mobile_ecommerce/Domain/Repositories_abstractions/connected_user_repository.dart';
import 'package:mobile_ecommerce/Domain/Repositories_abstractions/order_item_repository.dart';
import 'package:mobile_ecommerce/Domain/Repositories_abstractions/order_repository.dart';
import 'package:mobile_ecommerce/Domain/Repositories_abstractions/shopping_cart_item_repository.dart';
import 'package:mobile_ecommerce/Domain/Repositories_abstractions/user_repository.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import 'Repositories_test/connected_user_repository_sqflite_ffi_impl.dart';
import 'Repositories_test/order_item_repository_sqflite_ffi_impl.dart';
import 'Repositories_test/order_repository_sqflite_ffi_impl.dart';
import 'Repositories_test/shopping_cart_item_repository_sqflite_ffi_impl.dart';
import 'Repositories_test/user_repository_sqflite_ffi_impl.dart';

void main() {
  closeSqfliteFfiDatabase() async {
    var db = await databaseFactoryFfi.openDatabase(inMemoryDatabasePath);
    await db.close();
  }

  group('Order Items Repository test :', () {
    test('Get all order items', () async {
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

      await make_an_order_usecase.register_order_items(
          order_item_repository, order);

      var orders_items_in_db = await order_item_repository
          .retrieve_items_by_order_reference(order.get_order_reference());

      expect(await orders_items_in_db[0].getTitle(), product.getTitle());
      expect(await orders_items_in_db[1].getTitle(), product2.getTitle());
    });
  });
}
