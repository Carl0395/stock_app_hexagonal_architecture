import 'package:stock_app/features/inventory/domain/repositories/inventory_repository.dart';

class DeleteInventory {
  final InventoryRepository repository;
  DeleteInventory(this.repository);

  Future<void> call(String id) async {
    await repository.deleteInventory(id);
  }
}
