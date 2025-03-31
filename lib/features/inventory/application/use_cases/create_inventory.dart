import 'package:stock_app/features/inventory/domain/entities/inventory.dart';
import 'package:stock_app/features/inventory/domain/repositories/inventory_repository.dart';

class CreateInventory {
  final InventoryRepository repository;
  CreateInventory(this.repository);

  Future<void> call(Inventory inventory) async {
    await repository.createInventory(inventory);
  }
}
