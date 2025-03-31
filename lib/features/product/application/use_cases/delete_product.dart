import 'package:stock_app/features/product/domain/repositories/product_repository.dart';

class DeleteProduct {
  final ProductRepository repository;
  DeleteProduct(this.repository);

  Future<void> call(String idInventory, String idProduct) async {
    await repository.deleteProduct(
      idInventory: idInventory,
      idProduct: idProduct,
    );
  }
}
