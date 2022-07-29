import 'dart:ffi';

const String table_Orders = 'orders';

class Orders_Fields {
  static const String id = 'id';
  static const String name = 'name';
  static const String single = 'single';
  static const String multy = 'multy';
  static const String device_id = 'device_id';
  static const String start_time = 'start_time';
  static const String end_time = 'end_time';
  static const String play_subtotal = 'play_subtotal';
  static const String drinks_subtotal = 'drinks_subtotal';
  static const String total = 'total';
  static const String isMulty = 'isMulty';
  static const String isOpened = 'isOpened';

  static final List<String> values = [
    id,
    name,
    single,
    multy,
    device_id,
    start_time,
    end_time,
    play_subtotal,
    drinks_subtotal,
    total,
    isMulty,
    isOpened,
  ];
}

class Order {
  final int? id;
  final String? name;
  final int? single;
  final int? multy;
  final int? device_id;
  final DateTime start_time;
  final DateTime? end_time;
  final double? playstation_subtotal;
  final double? drinks_subtotal;
  final double? total;
  final int? isMulty;
  final int? isOpened;

  const Order({
    this.id,
    required this.name,
    required this.start_time,
    required this.single,
    required this.multy,
    required this.device_id,
    this.end_time,
    this.playstation_subtotal,
    this.drinks_subtotal,
    this.total,
    required this.isMulty,
    required this.isOpened,
  });

  Order copy({
    int? id,
    String? name,
    int? single,
    int? multy,
    int? device_id,
    DateTime? start_time,
    DateTime? end_time,
    double? single_subtotal,
    double? drinks_subtotal,
    double? total,
    int? isMulty,
    int? isOpened,
  }) =>
      Order(
        id: this.id,
        name: this.name,
        single: this.single,
        multy: this.multy,
        device_id: this.device_id,
        start_time: this.start_time,
        end_time: this.end_time,
        playstation_subtotal: this.playstation_subtotal,
        drinks_subtotal: this.drinks_subtotal,
        total: this.total,
        isMulty: this.isMulty,
        isOpened: this.isOpened,
      );
}
