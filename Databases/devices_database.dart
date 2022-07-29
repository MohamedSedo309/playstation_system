import 'package:mysql1/mysql1.dart';
import 'device_Model.dart';

class Devices_DB {
  var devices_db;

  get_DB() async {
    devices_db = await MySqlConnection.connect(ConnectionSettings(
        host: 'localhost',
        port: 3306,
        user: 'user1',
        db: 'playstation',
        password: '1234'));
    return devices_db;
  }

  intializeDB() async {
    await devices_db.query('''
    CREATE TABLE IF NOT EXISTS $table_Devices (
    ${Devices_Fields.id} INTEGER PRIMARY KEY AUTO_INCREMENT  , 
    ${Devices_Fields.name} TEXT NOT NULL , 
    ${Devices_Fields.type} TEXT NOT NULL ,
    ${Devices_Fields.price_single} INTEGER NOT NULL ,
    ${Devices_Fields.price_multy} INTEGER NOT NULL ,
    ${Devices_Fields.isActive} INTEGER NOT NULL 

    )
    ''');

    print('db created');
  }

  createItem(Device device) async {
    final id = await devices_db.query(
        'insert into device (${Devices_Fields.name}, ${Devices_Fields.type}, ${Devices_Fields.price_single} , ${Devices_Fields.price_multy}) values (?, ?, ?, ?)',
        [device.name, device.type, device.price_single, device.price_multy]);
  }

  Future<Device> readDevice(int id) async {
    var dev = Device(
        id: 0,
        name: '',
        type: '',
        price_single: 0,
        price_multy: 0,
        isActive: 0);
    Results maps =
        await devices_db.query('SELECT * FROM device WHERE id = $id ');
    for (var row in maps) {
      dev = Device(
          id: row[0],
          name: row[1].toString(),
          type: row[2].toString(),
          price_single: row[3],
          price_multy: row[4],
          isActive: row[5]);
    }
    return dev;
  }

  Future<List<Device>> readAllData() async {
    List<Device> dev_list = [];
    Results maps = await devices_db.query('SELECT * FROM device ORDER BY id');

    for (var row in maps) {
      dev_list.add(Device(
        id: row[0],
        name: row[1].toString(),
        type: row[2].toString(),
        price_single: row[3],
        price_multy: row[4],
        isActive: row[5],
      ));
    }

    return dev_list;
  }

  updateDB(Device device, int id) async {
    devices_db.query('''UPDATE device
        SET ${Devices_Fields.name} = ?, 
         ${Devices_Fields.type} = ? , 
         ${Devices_Fields.price_single}  = ?, 
     ${Devices_Fields.price_multy} = ?
        WHERE id = $id''', [
      device.name,
      device.type,
      device.price_single,
      device.price_multy,
    ]);
    print('edited');
  }

  open_Device(int id) async {
    devices_db.query('''UPDATE device
        SET ${Devices_Fields.isActive} = ?
        
        WHERE id = $id''', [1]);
    print('edited');
  }

  close_Device(int id) async {
    devices_db.query('''UPDATE device
        SET ${Devices_Fields.isActive} = ?
        
        WHERE id = $id''', [0]);
    print('edited');
  }

  delete_device(int id) async {
    devices_db.query('DELETE FROM device WHERE id = $id');
  }

  Future closeDB() async {
    devices_db.close();
  }
}
