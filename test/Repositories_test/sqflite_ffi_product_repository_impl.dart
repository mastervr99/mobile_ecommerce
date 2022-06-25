import 'package:mobile_ecommerce/Domain/Entity/product.dart';
import 'package:mobile_ecommerce/Domain/Repositories_abstractions/product_repository.dart';
import 'package:sqflite_common/sqlite_api.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class SqfliteFfiProductRepostitoryImpl extends ProductRepository {
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

  @override
  registerProduct(Product product) async {
    await database.insert('Products', product.toMap());
  }

  @override
  retrieveProduct(String productTitle) async {
    var searchedProduct = await database
        .rawQuery('SELECT * FROM Products WHERE title = ?', [productTitle]);
    if (searchedProduct.isEmpty) {
      return false;
    } else {
      Product product = Product(await searchedProduct[0]['title']);
      return product;
    }
  }

  @override
  close() {}
}
