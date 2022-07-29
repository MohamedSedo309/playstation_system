import 'package:mysql1/mysql1.dart';

import 'OrderItem_Model.dart';
import 'Order_Model.dart';

class OrderItems_DB {
  var orderItems_db;

  get_DB() async {
    orderItems_db = await MySqlConnection.connect(ConnectionSettings(
        host: 'localhost',
        port: 3306,
        user: 'user1',
        db: 'playstation',
        password: '1234'));
    return orderItems_db;
  }

  intializeDB() async {
    await orderItems_db.query('''
    CREATE TABLE IF NOT EXISTS $table_OrderItems (
    ${OrderItems_Fields.id} INTEGER PRIMARY KEY AUTO_INCREMENT  , 
    ${OrderItems_Fields.name} TEXT NOT NULL , 
    ${OrderItems_Fields.single_price} INTEGER NOT NULL ,
    ${OrderItems_Fields.quantity} INTEGER NOT NULL ,
    ${OrderItems_Fields.total_price} INTEGER NOT NULL ,
    ${OrderItems_Fields.forign_key} INTEGER NOT NULL ,
    FOREIGN KEY(${OrderItems_Fields.forign_key}) REFERENCES $table_Orders (${Orders_Fields.id})

    )
    ''');

    print('db created');
  }

  createItem(Order_Item order_item) async {
    final id = await orderItems_db.query(
        'insert into order_items (${OrderItems_Fields.name}, ${OrderItems_Fields.single_price}, ${OrderItems_Fields.quantity} , ${OrderItems_Fields.total_price}, ${OrderItems_Fields.forign_key}) values (?, ?, ?, ? ,?)',
        [
          order_item.name,
          order_item.single_price,
          order_item.quantity,
          order_item.total_price,
          order_item.forign_key
        ]);
  }

  Future<List<Order_Item>> readAllData(int fk) async {
    List<Order_Item> dev_list = [];
    Results maps = await orderItems_db
        .query('SELECT * FROM order_items WHERE order_id = $fk ORDER BY id');

    for (var row in maps) {
      dev_list.add(Order_Item(
        id: row[0],
        name: row[1].toString(),
        single_price: row[2],
        quantity: row[3],
        total_price: row[4],
        forign_key: row[5],
      ));
    }

    return dev_list;
  }

  delete_orderITem(int id) async {
    orderItems_db.query('DELETE FROM order_items WHERE id = $id');
  }

  Future closeDB() async {
    orderItems_db.close();
  }
}
