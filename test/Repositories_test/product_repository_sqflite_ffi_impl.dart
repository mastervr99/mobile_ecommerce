import 'package:mobile_ecommerce/Domain/Entity/product.dart';
import 'package:mobile_ecommerce/Domain/Repositories_abstractions/product_repository.dart';
import 'package:sqflite_common/sqlite_api.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class ProductRepostitorySqfliteFfiImpl extends ProductRepository {
  late var database;

  @override
  init() async {
    database = await databaseFactoryFfi.openDatabase(inMemoryDatabasePath);
    await database.execute('''
      CREATE TABLE IF NOT EXISTS Products (
        id INTEGER PRIMARY KEY,
        title TEXT,
        description TEXT
      )
      ''');
  }

  registerProduct(Product product) async {
    await database.insert('Products', product.toMap());
  }

  @override
  retrieveSingleProductByTitle(String productTitle) async {
    var searchedProduct = await database.rawQuery(
        "SELECT * FROM Products WHERE title like '%$productTitle%' LIMIT 1");
    if (searchedProduct.isEmpty) {
      return false;
    } else {
      Product product = Product(await searchedProduct[0]['title']);
      return product;
    }
  }

  @override
  retrieveProductsByTitle(String productTitle) async {
    var searchedProducts = await database
        .rawQuery("SELECT * FROM Products WHERE title like '%$productTitle%'");
    if (searchedProducts.isEmpty) {
      return false;
    } else {
      return searchedProducts;
    }
  }

  @override
  close() {}
}
