import 'package:mobile_ecommerce/Domain/Entity/product.dart';
import 'package:mobile_ecommerce/Domain/Repositories_abstractions/product_repository.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class ProductRepostitorySqfliteImpl extends ProductRepository {
  late var database;

  @override
  init() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, 'products.db');
    database = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      // When creating the db, create the table
      await db.execute('''
        CREATE TABLE IF NOT EXISTS Products (
          id INTEGER PRIMARY KEY,
          title TEXT,
          description TEXT,
          color TEXT,
          gender TEXT,
          category TEXT,
          subCategory TEXT,
          type TEXT,
          usage TEXT,
          imageUrl TEXT,
          price FLOAT,
          sku INT
        )
      ''');
    });
  }

  registerProduct(Product product) async {
    await database.insert('Products', product.toMap());
  }

  @override
  retrieveProductsByTitle(String searchKeywords) async {
    var searchedProductsInDb = [];

    var searchTerms = searchKeywords.split(' ');

    for (var searchTerm in searchTerms) {
      var searchResults = await database
          .rawQuery("SELECT * FROM Products WHERE title like '%$searchTerm%'");
      for (var searchResult in await searchResults) {
        searchedProductsInDb.add(await searchResult);
      }
    }

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
      product.setPrice(productData['price'] ?? 0);
      product.setSku(productData['sku'] ?? 100);

      searchedProducts.add(product);
    });

    return searchedProducts;
  }

  @override
  close() async {
    await database.close();
  }
}
