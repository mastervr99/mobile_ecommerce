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
        sku INT,
        order_reference TEXT,
        quantity INT
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
    await _init_database();

    var items_in_db = await database.rawQuery(
        "SELECT * FROM order_items WHERE order_reference = ?",
        [order_reference]);

    if (await items_in_db.isEmpty) {
      await _close_database();

      return [];
    } else {
      List<Order_Item> order_items = [];

      await items_in_db.forEach((itemData) async {
        Order_Item order_item = Order_Item(itemData['title']);
        order_item.setDescription(itemData['description']);
        order_item.setGender(itemData['gender']);
        order_item.setCategory(itemData['category']);
        order_item.setSubCategory(itemData['subCategory']);
        order_item.setType(itemData['type']);
        order_item.setColor(itemData['color']);
        order_item.setUsage(itemData['usage']);
        order_item.setImageUrl(itemData['imageUrl']);
        order_item.setPrice(itemData['price']);
        order_item.setSku(itemData['sku']);
        order_item.setOrderReference(itemData['order_reference']);
        order_item.set_quantity(itemData['quantity']);

        order_items.add(order_item);
      });

      await _close_database();

      return order_items;
    }
  }

  @override
  _close_database() {}
}
