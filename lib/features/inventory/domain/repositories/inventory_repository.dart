import 'package:stock_app/features/inventory/domain/entities/inventory.dart';

abstract class InventoryRepository {
  Future<List<Inventory>> getAllInventory();
  Future<void> createInventory(Inventory inventory);
  Future<void> deleteInventory(String id);
  Future<void> editInventory(String id, String newName);
}
