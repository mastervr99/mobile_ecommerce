import 'package:mobile_ecommerce/Domain/Entity/product.dart';
import 'package:mobile_ecommerce/Domain/Repositories_abstractions/product_repository.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class ProductRepostitorySqfliteImpl extends ProductRepository {
  late var database;

  @override
  init() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, 'eshop.db');
    database = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      // When creating the db, create the table
      await db.execute('''
        CREATE TABLE IF NOT EXISTS Products (
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
    });
  }

  registerProduct(Product product) async {
    await database.insert('Products', product.toMap());
  }

  @override
  retrieveSingleProductByTitle(String productTitle) async {
    var searchedProduct = await database.rawQuery(
        "SELECT * FROM Products WHERE title like '%$productTitle%' LIMIT 1");
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
        .rawQuery("SELECT * FROM Products WHERE title like '%$productTitle%'");

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
  close() async {
    await database.close();
  }
}
