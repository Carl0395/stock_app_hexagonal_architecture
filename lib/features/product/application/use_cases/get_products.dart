import 'package:stock_app/features/product/domain/entities/product.dart';
import 'package:stock_app/features/product/domain/repositories/product_repository.dart';

class GetProducts {
  final ProductRepository repository;
  GetProducts(this.repository);

  Future<List<Product>> call(String inventoryId) async {
    return await repository.getProducts(inventoryId);
  }
}
