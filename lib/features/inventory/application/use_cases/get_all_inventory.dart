import 'package:stock_app/features/inventory/domain/entities/inventory.dart';
import 'package:stock_app/features/inventory/domain/repositories/inventory_repository.dart';

class GetAllInventory {
  final InventoryRepository repository;
  GetAllInventory(this.repository);

  Future<List<Inventory>> call() async {
    return await repository.getAllInventory();
  }
}
