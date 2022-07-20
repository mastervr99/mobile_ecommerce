import 'package:flutter_test/flutter_test.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mobile_ecommerce/Domain/Entity/product.dart';
import 'package:mobile_ecommerce/Domain/Entity/shopping_cart.dart';

void main() {
  group('Shopping Cart Usecase : ', () {
    test('add item', () async {
      Product product = Product("iphone X");
      Product product2 = Product("samsung 12");

      // expect(product.toMap(), true);

      ShoppingCart shoppingCart = ShoppingCart();

      shoppingCart.addItem(product);
      shoppingCart.addItem(product2);

      var shoppingCartProducts = shoppingCart.getAllCartItems();

      expect(shoppingCartProducts[0].getTitle(), 'iphone X');
      expect(shoppingCartProducts[1].getTitle(), 'samsung 12');

      await Hive.initFlutter();
      await Hive.openBox('testBox');
      var box = Hive.box('testBox');
      var test = [
        ['testing'],
        ['test']
      ];
      await box.put('test', test);
      var testHive = await box.get('test');
      expect(testHive, [
        ['testing'],
        ['test']
      ]);

      var collection =
          await BoxCollection.open('MyFirstFluffyBox', // Name of your database
              {'products'});
    });
  });
}
