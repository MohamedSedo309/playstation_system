const String table_OrderItems = 'order_items';

class OrderItems_Fields {
  static const String id = 'id';
  static const String name = 'name';
  static const String single_price = 'single_price';
  static const String quantity = 'quantity';
  static const String total_price = 'total_price';
  static const String forign_key = 'order_id';

  static final List<String> values = [
    id,
    name,
    single_price,
    quantity,
    total_price,
    forign_key,
  ];
}

class Order_Item {
  final int? id;
  final String name;
  final int single_price;
  final int quantity;
  final int total_price;
  final int forign_key;

  const Order_Item({
    this.id,
    required this.name,
    required this.single_price,
    required this.quantity,
    required this.total_price,
    required this.forign_key,
  });

  Order_Item copy({
    int? id,
    String? name,
    int? single_price,
    int? quantity,
    int? total_price,
    int? forign_key,
  }) =>
      Order_Item(
        id: this.id,
        name: this.name,
        single_price: this.single_price,
        quantity: this.quantity,
        total_price: this.total_price,
        forign_key: this.forign_key,
      );
}
