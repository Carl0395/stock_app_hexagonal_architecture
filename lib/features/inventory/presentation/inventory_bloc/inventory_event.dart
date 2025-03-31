abstract class InventoryEvent {}

class LoadInventories extends InventoryEvent {}

class AddNewInventory extends InventoryEvent {
  final String name;
  AddNewInventory(this.name);
}

class RemoveInventory extends InventoryEvent {
  final String id;
  RemoveInventory(this.id);
}

class UpdateInventory extends InventoryEvent {
  final String id;
  final String newName;

  UpdateInventory(this.id, this.newName);
}
