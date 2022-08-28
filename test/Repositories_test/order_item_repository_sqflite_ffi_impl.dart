import 'package:mobile_ecommerce/Domain/Entity/order_item.dart';
import 'package:mobile_ecommerce/Domain/Repositories_abstractions/order_item_repository.dart';
import 'package:sqflite_common/sqlite_api.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class Order_Item_Repostitory_Sqflite_Ffi_Impl extends Order_Item_Repository {
  late var database;

  @override
  _init_database() async {
    database = await databaseFactoryFfi.openDatabase(inMemoryDatabasePath);
    await database.execute('''
      CREATE TABLE IF NOT EXISTS order_items (
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

  register_item(Order_Item order_item) async {
    await _init_database();

    await database.insert('order_items', order_item.toMap());

    await _close_database();
  }

  @override
  retrieve_items_by_order_reference(String order_reference) async {
    // await _init_database();

    // var items_in_db = [];

    // var searchResults = await database
    //     .rawQuery("SELECT * FROM Products WHERE title like '%$%'");
    // for (var searchResult in await searchResults) {
    //   searchedProductsInDb.add(await searchResult);
    // }

    // List<Product> searchResults = [];

    // searchedProductsInDb.forEach((productData) {
    //   Product product = Product(productData['title'] ?? '');
    //   product.setDescription(productData['description'] ?? '');
    //   product.setGender(productData['gender'] ?? '');
    //   product.setCategory(productData['category'] ?? '');
    //   product.setSubCategory(productData['subCategory'] ?? '');
    //   product.setType(productData['type'] ?? '');
    //   product.setColor(productData['color'] ?? '');
    //   product.setUsage(productData['usage'] ?? '');
    //   product.setImageUrl(productData['imageUrl'] ?? '');
    //   product.setPrice(productData['price'] ?? 0);
    //   product.setSku(productData['sku'] ?? 100);

    //   searchResults.add(product);
    // });

    // await _close_database();

    // return searchResults;
  }

  @override
  _close_database() {}
}
