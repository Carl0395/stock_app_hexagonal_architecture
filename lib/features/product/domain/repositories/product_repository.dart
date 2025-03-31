import 'package:stock_app/features/product/domain/entities/product.dart';

abstract class ProductRepository {
  Future<List<Product>> getProducts(String inventoryId);
  Future<void> addProduct(Product product);
  Future<void> deleteProduct({
    required String idInventory,
    required String idProduct,
  });
  Future<void> updateProduct(Product newProduct);
}
