import 'package:mobile_ecommerce/Domain/Entity/order.dart';
import 'package:mobile_ecommerce/Domain/Repositories_abstractions/order_repository.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class Order_Repository_Sqflite_Impl extends Order_Repository {
  late var database;

  @override
  _init_database() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, 'orders.db');
    database = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      // When creating the db, create the table
      await db.execute('''
      CREATE TABLE IF NOT EXISTS orders (
        id INTEGER PRIMARY KEY,
        user_id TEXT,
        order_reference TEXT,
        order_date TEXT,
        order_hour TEXT,
        order_state TEXT,
        order_delivery_method TEXT,
        order_payment_method TEXT,
        order_delivery_date,
        order_price FLOAT
      )
      ''');
    });
  }

  register_order(Order order) async {
    await _init_database();

    await database.insert('orders', order.toMap());

    await _close_database();
  }

  @override
  retrieve_order_with_reference(String order_reference) async {
    await _init_database();

    var order_in_db = await database.rawQuery(
        'SELECT * FROM orders WHERE order_reference = ?', [order_reference]);

    if (await order_in_db.isEmpty) {
      await _close_database();

      return [];
    } else {
      Order order = Order();

      order.set_order_date(await order_in_db[0]['order_date']);
      order
          .set_order_delivery_date(await order_in_db[0]['order_delivery_date']);
      order.set_order_delivery_method(
          await order_in_db[0]['order_delivery_method']);
      order.set_order_hour(await order_in_db[0]['order_hour']);
      order.set_order_payment_method(
          await order_in_db[0]['order_payment_method']);
      order.set_order_price(await order_in_db[0]['order_price']);
      order.set_order_reference(await order_in_db[0]['order_reference']);
      order.set_order_state(await order_in_db[0]['order_state']);
      order.set_user_id(await order_in_db[0]['user_id']);

      await _close_database();

      return order;
    }
  }

  @override
  _close_database() {}
}
