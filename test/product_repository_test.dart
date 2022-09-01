import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_ecommerce/Domain/Entity/product.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import 'Repositories_test/product_repository_sqflite_ffi_impl.dart';

void main() {
  closeSqfliteFfiDatabase() async {
    var db = await databaseFactoryFfi.openDatabase(inMemoryDatabasePath);
    await db.close();
  }

  group('Product Repository test :', () {
    test('Retrieve product with sku', () async {
      var productRepository = ProductRepostitorySqfliteFfiImpl();

      Product product = Product("lg 10 red");
      product.setSku(342423424);

      await productRepository.registerProduct(product);

      var product_in_db =
          await productRepository.retrieve_product_with_sku(product.getSku());

      expect(await product_in_db.getTitle(), 'lg 10 red');

      await closeSqfliteFfiDatabase();
    });
  });
}
