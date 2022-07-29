import 'package:mysql1/mysql1.dart';
import 'Order_Model.dart';

class Orders_DB {
  var orders_db;

  get_DB() async {
    orders_db = await MySqlConnection.connect(ConnectionSettings(
        host: 'localhost',
        port: 3306,
        user: 'user1',
        db: 'playstation',
        password: '1234'));
    return orders_db;
  }

  intializeDB() async {
    await orders_db.query('''
    CREATE TABLE IF NOT EXISTS $table_Orders (
    ${Orders_Fields.id} INTEGER PRIMARY KEY AUTO_INCREMENT  , 
    ${Orders_Fields.name} TEXT NOT NULL , 
    ${Orders_Fields.single} INTEGER NOT NULL , 
    ${Orders_Fields.multy} INTEGER NOT NULL , 
    ${Orders_Fields.device_id} INTEGER NOT NULL , 
    ${Orders_Fields.start_time} DATETIME ,
    ${Orders_Fields.end_time} DATETIME  ,
    ${Orders_Fields.play_subtotal} FLOAT , 
    ${Orders_Fields.drinks_subtotal} FLOAT , 
    ${Orders_Fields.total} FLOAT ,
    ${Orders_Fields.isMulty} INTEGER NOT NULL ,
    ${Orders_Fields.isOpened} INTEGER NOT NULL 
    

    )
    ''');

    print('db created');
  }

  create_Order(Order order) async {
    await orders_db.query(
        'insert into orders (${Orders_Fields.name} , ${Orders_Fields.single} , ${Orders_Fields.multy}, ${Orders_Fields.device_id}, ${Orders_Fields.start_time} , ${Orders_Fields.isMulty}, ${Orders_Fields.isOpened}) values (? , ? ,?, ?, ?, ? ,?)',
        [
          order.name,
          order.single,
          order.multy,
          order.device_id,
          order.start_time,
          order.isMulty,
          order.isOpened,
        ]);
  }

  Future<Order> readOrder(int id) async {
    var dev = Order(
      name: '',
      single: 0,
      multy: 0,
      device_id: 0,
      start_time: DateTime.now(),
      end_time: DateTime.now(),
      playstation_subtotal: 0,
      drinks_subtotal: 0,
      total: 0,
      isMulty: 0,
      isOpened: 0,
    );
    Results maps =
        await orders_db.query('SELECT * FROM orders WHERE id = $id ');
    for (var row in maps) {
      dev = Order(
        id: row[0],
        name: row[1].toString(),
        single: row[2],
        multy: row[3],
        device_id: row[4],
        start_time: row[5],
        end_time: row[6],
        playstation_subtotal: row[7],
        drinks_subtotal: row[8],
        total: row[9],
        isMulty: row[10],
        isOpened: row[11],
      );
    }
    return dev;
  }

  close_Order_time(Order order) async {
    orders_db.query(
      '''UPDATE orders
        SET ${Orders_Fields.end_time} = ? ,
        ${Orders_Fields.play_subtotal} = ?
        
        WHERE id = ${order.id}''',
      [
        DateTime.now().toUtc(),
        order.playstation_subtotal,
      ],
    );
    print('edited');
  }

  close_Order(Order order) async {
    orders_db.query('''UPDATE orders
        SET ${Orders_Fields.play_subtotal} = ?, 
         ${Orders_Fields.drinks_subtotal} = ? , 
         ${Orders_Fields.total}  = ?, 
     ${Orders_Fields.isOpened} = ?
        WHERE id = ${order.id}''', [
      order.playstation_subtotal,
      order.drinks_subtotal,
      order.total,
      order.isOpened,
    ]);
    print('edited');
  }

  Future<List<Order>> readAllData() async {
    List<Order> orders_list = [];
    Results maps = await orders_db.query('SELECT * FROM orders ORDER BY id');

    for (var row in maps) {
      orders_list.add(Order(
        id: row[0],
        name: row[1].toString(),
        single: row[2],
        multy: row[3],
        device_id: row[4],
        start_time: row[5],
        end_time: row[6],
        playstation_subtotal: row[7],
        drinks_subtotal: row[8],
        total: row[9],
        isMulty: row[10],
        isOpened: row[11],
      ));
    }

    return orders_list;
  }

  delete_order(int id) async {
    orders_db.query('DELETE FROM orders WHERE id = $id');
  }

  Future closeDB() async {
    orders_db.close();
  }
}
