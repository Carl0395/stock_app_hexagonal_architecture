import 'package:stock_app/features/product/domain/entities/product.dart';

class ProductModel extends Product {
  ProductModel({
    required super.id,
    required super.inventoryId,
    required super.name,
    required super.barcode,
    required super.price,
    required super.quantity,
    required super.createdAt,
  });

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      id: map['id'],
      inventoryId: map['inventoryId'],
      name: map['name'],
      barcode: map['barcode'],
      price: map['price'],
      quantity: int.tryParse('${map['quantity']}') ?? 0,
      createdAt: DateTime.parse(map["createdAt"]),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'inventoryId': inventoryId,
      'name': name,
      'barcode': barcode,
      'price': price,
      'quantity': quantity,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory ProductModel.fromEntity(Product product) {
    return ProductModel(
      id: product.id,
      inventoryId: product.inventoryId,
      name: product.name,
      barcode: product.barcode,
      price: product.price,
      quantity: product.quantity,
      createdAt: product.createdAt,
    );
  }
}
