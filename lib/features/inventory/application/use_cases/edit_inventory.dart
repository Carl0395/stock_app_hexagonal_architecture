import 'package:stock_app/features/inventory/domain/repositories/inventory_repository.dart';

class EditInventory {
  final InventoryRepository repository;
  EditInventory(this.repository);

  Future<void> call(String idInventory, String newName) async {
    await repository.editInventory(idInventory, newName);
  }
}
