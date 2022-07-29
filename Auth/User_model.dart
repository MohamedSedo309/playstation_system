const String table_Users = 'users';

class UserFields {
  static const String id = 'id';
  static const String name = 'name';
  static const String password = 'password';
  static const String admin = 'admin';

  static final List<String> values = [id, name, password, admin];
}

class User {
  final int? id;
  final String name;
  final String password;
  final int isAdmin;

  const User(
      {this.id, required this.name, required this.password, required this.isAdmin});

  Map<String, Object?> toJson() {
    return {
      UserFields.id: id,
      UserFields.name: name,
      UserFields.password: password,
      UserFields.admin: isAdmin
    };
  }

  static User fromJson(Map<String, dynamic> json) {
    return User(
      id: UserFields.id as int,
      name: UserFields.name,
      password: UserFields.password,
      isAdmin: UserFields.admin as int,
    );
  }

  User copy({
    int? id,
    String? name,
    String? password,
    int? isAdmin,
  }) =>
      User(
        id: this.id,
        name: this.name,
        password: this.password,
        isAdmin: this.isAdmin,
      );
}
