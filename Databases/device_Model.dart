const String table_Devices = 'device';

class Devices_Fields {
  static const String id = 'id';
  static const String name = 'name';
  static const String type = 'type';
  static const String price_single = 'price_single';
  static const String price_multy = 'price_multi';
  static const String isActive = 'isActive';

  static final List<String> values = [
    id,
    name,
    type,
    price_single,
    price_multy,
    isActive
  ];
}

class Device {
  final int? id;
  final String name;
  final String type;
  final int price_single;
  final int price_multy;
  final int isActive;

  const Device({
    this.id,
    required this.name,
    required this.type,
    required this.price_single,
    required this.price_multy,
    required this.isActive,
  });

  Device copy({
    int? id,
    String? name,
    String? type,
    int? price_single,
    int? price_multy,
    int? isActive,
  }) =>
      Device(
        id: this.id,
        name: this.name,
        type: this.type,
        price_single: this.price_single,
        price_multy: this.price_multy,
        isActive: this.isActive,
      );
}
