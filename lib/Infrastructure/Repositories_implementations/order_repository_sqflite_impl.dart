import 'package:mobile_ecommerce/Domain/Entity/order.dart';
import 'package:mobile_ecommerce/Domain/Entity/user.dart';
import 'package:mobile_ecommerce/Domain/Repositories_abstractions/order_repository.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class Order_Repository_Sqflite_Impl extends Order_Repository {
  late var database;

  @override
  _init_database() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, 'orders4.db');
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
        order_delivery_date TEXT,
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
        'SELECT * FROM orders WHERE order_reference = ? LIMIT 1',
        [order_reference]);

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
  retrieve_all_user_orders(User user) async {
    await _init_database();

    var all_user_orders_in_db = await database.rawQuery(
        "SELECT * FROM orders WHERE user_id = ? ORDER BY id DESC",
        [user.get_user_id()]);

    List<Order> all_user_orders = [];

    if (await all_user_orders_in_db.isNotEmpty) {
      await all_user_orders_in_db.forEach((order_in_db) {
        Order order = Order();
        order.set_order_date(order_in_db['order_date']);
        order.set_order_delivery_date(order_in_db['order_delivery_date']);
        order.set_order_delivery_method(order_in_db['order_delivery_method']);
        order.set_order_hour(order_in_db['order_hour']);
        order.set_order_payment_method(order_in_db['order_payment_method']);
        order.set_order_price(order_in_db['order_price']);
        order.set_order_reference(order_in_db['order_reference']);
        order.set_order_state(order_in_db['order_state']);
        order.set_user_id(order_in_db['user_id']);

        all_user_orders.add(order);
      });
    }

    await _close_database();

    return all_user_orders;
  }

  @override
  _close_database() async {
    await database.close();
    database = null;
  }
}
