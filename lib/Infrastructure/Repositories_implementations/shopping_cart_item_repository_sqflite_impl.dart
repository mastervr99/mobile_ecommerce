import 'package:mobile_ecommerce/Domain/Entity/product.dart';
import 'package:mobile_ecommerce/Domain/Entity/shopping_cart_item.dart';
import 'package:mobile_ecommerce/Domain/Repositories_abstractions/shopping_cart_item_repository.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class ShoppingCartItemRepositorySqfliteImpl extends ShoppingCartItemRepository {
  late var database;

  @override
  _init_database() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, 'shopping_cart_items2.db');
    database = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      // When creating the db, create the table
      await db.execute('''
      CREATE TABLE IF NOT EXISTS shoppingCartItems (
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
        quantity INT,
        sku INT
      )
      ''');
    });
  }

  @override
  registerItem(Product product) async {
    await _init_database();

    var productData = product.toMap();
    ShoppingCartItem shoppingCartItem =
        ShoppingCartItem(productData['title'] ?? '');
    shoppingCartItem.setDescription(productData['description'] ?? '');
    shoppingCartItem.setGender(productData['gender'] ?? '');
    shoppingCartItem.setCategory(productData['category'] ?? '');
    shoppingCartItem.setSubCategory(productData['subCategory'] ?? '');
    shoppingCartItem.setType(productData['type'] ?? '');
    shoppingCartItem.setColor(productData['color'] ?? '');
    shoppingCartItem.setUsage(productData['usage'] ?? '');
    shoppingCartItem.setImageUrl(productData['imageUrl'] ?? '');
    shoppingCartItem.setPrice(productData['price'] ?? 0);
    shoppingCartItem.setSku(productData['sku'] ?? 100);
    shoppingCartItem.setQuantity(1);
    await database.insert('shoppingCartItems', shoppingCartItem.toMap());
    await _close_database();
  }

  @override
  checkIfProductIsAlreadyInCart(Product product) async {
    await _init_database();

    var itemInDb = await database.rawQuery(
        'SELECT * FROM shoppingCartItems WHERE sku = ?', [product.getSku()]);

    if (await itemInDb.isEmpty) {
      await _close_database();

      return false;
    } else {
      await _close_database();

      return true;
    }
  }

  @override
  retrieveAllItems() async {
    await _init_database();

    var allCartItemsinDB = [];

    try {
      allCartItemsinDB =
          await database.rawQuery("SELECT * FROM shoppingCartItems");
    } catch (e) {
      print(e);
    }

    List<ShoppingCartItem> allCartItems = [];

    await allCartItemsinDB;

    if (await allCartItemsinDB.isNotEmpty) {
      allCartItemsinDB.forEach((itemData) {
        ShoppingCartItem shoppingCartItem =
            ShoppingCartItem(itemData['title'] ?? '');
        shoppingCartItem.setDescription(itemData['description'] ?? '');
        shoppingCartItem.setGender(itemData['gender'] ?? '');
        shoppingCartItem.setCategory(itemData['category'] ?? '');
        shoppingCartItem.setSubCategory(itemData['subCategory'] ?? '');
        shoppingCartItem.setType(itemData['type'] ?? '');
        shoppingCartItem.setColor(itemData['color'] ?? '');
        shoppingCartItem.setUsage(itemData['usage'] ?? '');
        shoppingCartItem.setImageUrl(itemData['imageUrl'] ?? '');
        shoppingCartItem.setPrice(itemData['price'] ?? 0);
        shoppingCartItem.setSku(itemData['sku'] ?? 100);
        shoppingCartItem.setQuantity(itemData['quantity'] ?? 1);

        allCartItems.add(shoppingCartItem);
      });
    }
    await _close_database();

    return allCartItems;
  }

  @override
  findItemWithSku(int sku) async {
    await _init_database();

    var itemData = await database.rawQuery(
        'SELECT * FROM shoppingCartItems WHERE sku = ? LIMIT 1', [sku]);

    if (await itemData.isNotEmpty) {
      ShoppingCartItem shoppingCartItem =
          ShoppingCartItem(await itemData[0]['title'] ?? '');
      shoppingCartItem.setDescription(await itemData[0]['description'] ?? '');
      shoppingCartItem.setGender(await itemData[0]['gender'] ?? '');
      shoppingCartItem.setCategory(await itemData[0]['category'] ?? '');
      shoppingCartItem.setSubCategory(await itemData[0]['subCategory'] ?? '');
      shoppingCartItem.setType(await itemData[0]['type'] ?? '');
      shoppingCartItem.setColor(await itemData[0]['color'] ?? '');
      shoppingCartItem.setUsage(await itemData[0]['usage'] ?? '');
      shoppingCartItem.setImageUrl(await itemData[0]['imageUrl'] ?? '');
      shoppingCartItem.setPrice(await itemData[0]['price'] ?? 0);
      shoppingCartItem.setQuantity(await itemData[0]['quantity'] ?? 1);
      shoppingCartItem.setSku(itemData[0]['sku'] ?? 100);

      await _close_database();

      return shoppingCartItem;
    } else {
      await _close_database();

      return [];
    }
  }

  @override
  updateItemData(ShoppingCartItem item) async {
    await _init_database();

    await database.update('shoppingCartItems', item.toMap(),
        where: "sku = ?", whereArgs: [item.getSku()]);

    await _close_database();
  }

  @override
  deleteItemData(ShoppingCartItem item) async {
    await _init_database();

    await database.delete('shoppingCartItems',
        where: "sku = ?", whereArgs: [item.getSku()]);

    await _close_database();
  }

  @override
  deleteAllItems() async {
    await _init_database();

    await database.rawQuery('DELETE FROM shoppingCartItems');

    await _close_database();
  }

  @override
  _close_database() async {
    await database.close();
    database = null;
  }
}
