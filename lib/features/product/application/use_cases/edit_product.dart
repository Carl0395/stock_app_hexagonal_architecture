import 'package:stock_app/features/product/domain/entities/product.dart';
import 'package:stock_app/features/product/domain/repositories/product_repository.dart';

class EditProduct {
  final ProductRepository repository;
  EditProduct(this.repository);

  Future<void> call(Product newProduct) async {
    await repository.updateProduct(newProduct);
  }
}
