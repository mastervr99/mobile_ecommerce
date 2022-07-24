import 'package:mobile_ecommerce/Domain/Entity/product.dart';
import 'package:mobile_ecommerce/Domain/Entity/shopping_cart_item.dart';
import 'package:mobile_ecommerce/Domain/Repositories_abstractions/shopping_cart_item_repository.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class ShoppingCartItemRepositorySqfliteImpl extends ShoppingCartItemRepository {
  late var database;

  @override
  init() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, 'shoppingCartItems.db');
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
    var productData = product.toMap();
    productData['quantity'] = 1;
    await database.insert('shoppingCartItems', productData);
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

  @override
  retrieveAllItems() async {
    var allCartItemsinDB =
        await database.rawQuery("SELECT * FROM shoppingCartItems");

    List<ShoppingCartItem> allCartItems = [];

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
      shoppingCartItem.setPrice(itemData['price'] ?? '');
      shoppingCartItem.setSku(itemData['sku'] ?? 100);
      shoppingCartItem.setQuantity(itemData['quantity'] ?? '');

      allCartItems.add(shoppingCartItem);
    });

    return allCartItems;
  }

  @override
  close() async {
    await database.close();
  }
}
