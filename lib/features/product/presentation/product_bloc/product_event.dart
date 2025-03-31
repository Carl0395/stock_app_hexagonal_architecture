import 'package:stock_app/features/product/domain/entities/product.dart';

abstract class ProductEvent {}

class LoadProducts extends ProductEvent {
  final String inventoryId;
  LoadProducts(this.inventoryId);
}

class AddNewProduct extends ProductEvent {
  final String name;
  final String price;
  final String quantity;
  final String inventoryId;
  AddNewProduct({
    required this.name,
    required this.price,
    required this.quantity,
    required this.inventoryId,
  });
}

class RemoveProduct extends ProductEvent {
  final String idProduct;
  final String idInventory;
  RemoveProduct({required this.idProduct, required this.idInventory});
}

class UpdateProduct extends ProductEvent {
  final String name;
  final String price;
  final int quantity;
  final Product product;
  UpdateProduct({
    required this.name,
    required this.price,
    required this.quantity,
    required this.product,
  });
}
