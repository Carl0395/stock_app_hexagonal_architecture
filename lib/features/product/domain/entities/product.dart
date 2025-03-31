class Product {
  final String id;
  final String inventoryId;
  final String name;
  final String barcode;
  final String price;
  final int quantity;
  final DateTime createdAt;

  Product({
    required this.id,
    required this.inventoryId,
    required this.name,
    required this.barcode,
    required this.price,
    required this.quantity,
    required this.createdAt,
  });
}
