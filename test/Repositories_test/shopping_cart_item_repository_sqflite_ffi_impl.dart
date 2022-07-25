import 'package:mobile_ecommerce/Domain/Entity/product.dart';
import 'package:mobile_ecommerce/Domain/Entity/shopping_cart_item.dart';
import 'package:mobile_ecommerce/Domain/Repositories_abstractions/shopping_cart_item_repository.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class ShoppingCartItemRepositorySqfliteFfiImpl
    extends ShoppingCartItemRepository {
  late var database;

  @override
  init() async {
    database = await databaseFactoryFfi.openDatabase(inMemoryDatabasePath);
    await database.execute('''
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
  }

  @override
  registerItem(Product product) async {
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
  }

  @override
  checkIfProductIsAlreadyInCart(Product product) async {
    var itemInDb = await database.rawQuery(
        'SELECT * FROM shoppingCartItems WHERE sku = ?', [product.getSku()]);

    if (await itemInDb.isEmpty) {
      return false;
    } else {
      return true;
    }
  }

  // @override
  // incrementItemQuantityByOne(Product product) async {
  //   var itemInDb = await database.rawQuery(
  //       'SELECT * FROM shoppingCartItems WHERE sku = ?', [product.getSku()]);
  //   var newItemQuantity = await itemInDb[0]['quantity'] + 1;
  //   await database.rawUpdate(
  //       'UPDATE shoppingCartItems SET quantity = ? WHERE sku = ?',
  //       [await newItemQuantity, product.getSku()]);
  // }

  @override
  retrieveAllItems() async {
    var allCartItemsinDB =
        await database.rawQuery("SELECT * FROM shoppingCartItems");

    List<ShoppingCartItem> allCartItems = [];

    if (await allCartItemsinDB.isNotEmpty) {
      await allCartItemsinDB.forEach((itemData) {
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
        shoppingCartItem.setQuantity(itemData['quantity'] ?? 1);
        shoppingCartItem.setSku(itemData['sku'] ?? 100);

        allCartItems.add(shoppingCartItem);
      });
    }

    return allCartItems;
  }

  @override
  findItemWithSku(int sku) async {
    var itemData = await database
        .rawQuery('SELECT * FROM shoppingCartItems WHERE sku = ?', [sku]);

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

      return shoppingCartItem;
    } else {
      return [];
    }
  }

  @override
  updateItemData(ShoppingCartItem item) async {
    await database.update('shoppingCartItems', item.toMap(),
        where: "sku = ?", whereArgs: [item.getSku()]);
  }

  @override
  close() {}
}
