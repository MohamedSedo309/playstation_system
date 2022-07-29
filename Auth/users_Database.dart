import 'package:mysql1/mysql1.dart';
import 'User_model.dart';

class Users_DB {
  var users_db;

  get_DB() async {
    users_db = await MySqlConnection.connect(ConnectionSettings(
        host: 'localhost',
        port: 3306,
        user: 'user2',
        db: 'playstation',
        password: '1234'));
    return users_db;
  }

  intializeDB() async {
    get_DB();
    await users_db.query('''
    CREATE TABLE IF NOT EXISTS $table_Users (
   ${UserFields.id} INTEGER PRIMARY KEY AUTO_INCREMENT , 
    ${UserFields.name} TEXT NOT NULL , 
    ${UserFields.password} TEXT NOT NULL ,
    ${UserFields.admin} INTEGER NOT NULL 
    

    )
    ''');

    print('db created');
  }

  createItem(User user) async {
    await users_db.query(
        'insert into users (${UserFields.name}, ${UserFields.password}  , ${UserFields.admin} ) values (?, ? , ?)',
        [user.name, user.password, user.isAdmin]);
  }

  Future<User> readUser(int id) async {
    var user = User(name: '', password: '', isAdmin: 0);
    Results maps = await users_db.query('SELECT * FROM users WHERE id = $id ');
    for (var row in maps) {
      user = User(
        id: row[0],
        name: row[1].toString(),
        password: row[2].toString(),
        isAdmin: row[3],
      );
    }
    return user;
  }

  Future<List<User>> readAllData() async {
    List<User> users_list = [];
    Results maps = await users_db.query('SELECT * FROM users ORDER BY id');

    for (var row in maps) {
      users_list.add(User(
        id: row[0],
        name: row[1].toString(),
        password: row[2].toString(),
        isAdmin: row[3],
      ));
    }

    return users_list;
  }

  updateDB(User user, int id) async {
    users_db.query('''UPDATE users
        SET ${UserFields.name} = ?, 
         ${UserFields.password} = ? , 
         ${UserFields.admin}  = ?
     
        WHERE id = $id''', [
      user.name,
      user.password,
      user.isAdmin,
    ]);
    print('edited');
  }

  delete_user(int id) async {
    users_db.query('DELETE FROM users WHERE id = $id');
  }

  Future closeDB() async {
    users_db.close();
  }
}
