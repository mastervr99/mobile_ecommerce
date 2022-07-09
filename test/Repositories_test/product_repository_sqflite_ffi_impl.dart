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
      CREATE TABLE IF NOT EXISTS products (
        id INTEGER PRIMARY KEY,
        title TEXT,
        description TEXT,
        colour TEXT,
        gender TEXT,
        category TEXT,
        subCategory TEXT,
        type TEXT,
        usage TEXT,
        imageUrl TEXT
      )
      ''');
  }

  registerProduct(Product product) async {
    await database.insert('products', product.toMap());
  }

  @override
  retrieveSingleProductByTitle(String productTitle) async {
    var searchedProduct = await database.rawQuery(
        "SELECT * FROM products WHERE title like '%$productTitle%' LIMIT 1");
    if (await searchedProduct.isEmpty) {
      return false;
    } else {
      Product product = Product(await searchedProduct[0]['title']);
      return product;
    }
  }

  @override
  retrieveProductsByTitle(String productTitle) async {
    var searchedProductsInDb = [];
    searchedProductsInDb = await database
        .rawQuery("SELECT * FROM products WHERE title like '%$productTitle%'");

    List<Product> searchedProducts = [];

    searchedProductsInDb.forEach((productData) {
      Product product = Product(productData['title'] ?? '');
      product.setDescription(productData['description'] ?? '');
      product.setGender(productData['gender'] ?? '');
      product.setCategory(productData['category'] ?? '');
      product.setSubCategory(productData['subCategory'] ?? '');
      product.setType(productData['type'] ?? '');
      product.setColor(productData['color'] ?? '');
      product.setUsage(productData['usage'] ?? '');
      product.setImageUrl(productData['imageUrl'] ?? '');

      searchedProducts.add(product);
    });

    return searchedProducts;
  }

  @override
  close() {}
}
