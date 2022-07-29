const String table_Drinks = 'drinks';

class Drinks_Fields {
  static const String id = 'id';
  static const String name = 'name';
  static const String price = 'price';
  static const String quantity = 'quantity';

  static final List<String> values = [
    id,
    name,
    price,
    quantity,
  ];
}

class Drink {
  final int? id;
  final String name;
  final int price;
  final int quantity;

  const Drink(
      {this.id,
      required this.name,
      required this.price,
      required this.quantity});

  Map<String, Object?> toJson() {
    return {
      Drinks_Fields.id: id,
      Drinks_Fields.name: name,
      Drinks_Fields.price: price,
      Drinks_Fields.quantity: quantity,
    };
  }

  static Drink fromJson(Map<String, dynamic> json) {
    return Drink(
      id: Drinks_Fields.id as int,
      name: Drinks_Fields.name,
      price: Drinks_Fields.price as int,
      quantity: Drinks_Fields.quantity as int,
    );
  }

  Drink copy({
    int? id,
    String? name,
    int? price,
    int? quantity,
  }) =>
      Drink(
        id: this.id,
        name: this.name,
        price: this.price,
        quantity: this.quantity,
      );
}
