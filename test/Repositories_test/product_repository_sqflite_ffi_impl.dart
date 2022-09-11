import 'package:mobile_ecommerce/Domain/Entity/product.dart';
import 'package:mobile_ecommerce/Domain/Repositories_abstractions/product_repository.dart';
import 'package:sqflite_common/sqlite_api.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class ProductRepostitorySqfliteFfiImpl extends ProductRepository {
  late var database;

  @override
  _init_database() async {
    database = await databaseFactoryFfi.openDatabase(inMemoryDatabasePath);
    await database.execute('''
      CREATE TABLE IF NOT EXISTS products (
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
  }

  registerProduct(Product product) async {
    await _init_database();

    await database.insert('products', product.toMap());

    await _close_database();
  }

  @override
  retrieveProductsByTitle(String searchKeywords) async {
    await _init_database();

    var searchedProductsInDb = [];

    var searchTerms = searchKeywords.split(' ');

    for (var searchTerm in searchTerms) {
      var searchResults = await database
          .rawQuery("SELECT * FROM products WHERE title like '%$searchTerm%'");
      for (var searchResult in await searchResults) {
        searchedProductsInDb.add(await searchResult);
      }
    }

    List<Product> searchResults = [];

    await searchedProductsInDb;

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

      searchResults.add(product);
    });

    await _close_database();

    return searchResults;
  }

  retrieve_product_with_sku(int sku) async {
    await _init_database();

    var productData = await database
        .rawQuery("SELECT * FROM products WHERE sku = ? LIMIT 1", [sku]);

    Product product = Product(await productData[0]['title'] ?? '');
    product.setDescription(await productData[0]['description'] ?? '');
    product.setGender(await productData[0]['gender'] ?? '');
    product.setCategory(await productData[0]['category'] ?? '');
    product.setSubCategory(await productData[0]['subCategory'] ?? '');
    product.setType(await productData[0]['type'] ?? '');
    product.setColor(await productData[0]['color'] ?? '');
    product.setUsage(await productData[0]['usage'] ?? '');
    product.setImageUrl(await productData[0]['imageUrl'] ?? '');
    product.setPrice(await productData[0]['price'] ?? 0);
    product.setSku(await productData[0]['sku'] ?? 100);

    await _close_database();

    return await product;
  }

  search_products_with_filters(Map filters) async {
    await _init_database();

    final first_key = filters.keys.elementAt(0);

    var search_query = "SELECT * FROM products";

    filters.forEach((key, value) {
      if (key == first_key) {
        search_query += " WHERE $key = '$value'";
      } else {
        search_query += " AND $key = '$value'";
      }
    });

    var products_found_in_db = [];

    products_found_in_db = await database.rawQuery(search_query);

    List<Product> searchResults = [];

    await products_found_in_db;

    products_found_in_db.forEach((productData) {
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

      searchResults.add(product);
    });

    await _close_database();

    return searchResults;
  }

  @override
  _close_database() {}
}
