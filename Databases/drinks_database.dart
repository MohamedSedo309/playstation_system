import 'package:mysql1/mysql1.dart';

import 'drink_Model.dart';

class Drinks_DB {
  var drinks_db;

  get_DB() async {
    drinks_db = await MySqlConnection.connect(ConnectionSettings(
        host: 'localhost',
        port: 3306,
        user: 'user1',
        db: 'playstation',
        password: '1234'));
    return drinks_db;
  }

  intializeDB() async {
    await drinks_db.query('''
    CREATE TABLE IF NOT EXISTS $table_Drinks (
    ${Drinks_Fields.id} INTEGER PRIMARY KEY AUTO_INCREMENT  , 
    ${Drinks_Fields.name} TEXT NOT NULL , 
    ${Drinks_Fields.price} INTEGER NOT NULL ,
    ${Drinks_Fields.quantity} INTEGER NOT NULL 

    )
    ''');

    print('db created');
  }

  createItem(Drink drink) async {
    await drinks_db.query(
        'insert into drinks (${Drinks_Fields.name}, ${Drinks_Fields.price}, ${Drinks_Fields.quantity} ) values (?, ?, ?)',
        [drink.name, drink.price, drink.quantity]);
  }

  Future<Drink> readDevice(int id) async {
    var dev = Drink(id: 0, name: '', price: 0, quantity: 0);
    Results maps =
        await drinks_db.query('SELECT * FROM drinks WHERE id = $id ');
    for (var row in maps) {
      dev = Drink(
          id: row[0], name: row[1].toString(), price: row[2], quantity: row[3]);
    }
    return dev;
  }

  Future<List<Drink>> readAllData() async {
    List<Drink> dev_list = [];
    Results maps = await drinks_db.query('SELECT * FROM drinks ORDER BY id');

    for (var row in maps) {
      dev_list.add(Drink(
        id: row[0],
        name: row[1].toString(),
        price: row[2],
        quantity: row[3],
      ));
    }

    return dev_list;
  }

  updateDB(Drink drink, int id) async {
    drinks_db.query('''UPDATE drinks
        SET ${Drinks_Fields.name} = ?, 
         ${Drinks_Fields.price} = ? , 
         ${Drinks_Fields.quantity}  = ?
        WHERE id = $id''', [drink.name, drink.price, drink.quantity]);
    print('edited');
  }

  delete_device(int id) async {
    drinks_db.query('DELETE FROM drinks WHERE id = $id');
  }

  Future closeDB() async {
    drinks_db.close();
  }
}
