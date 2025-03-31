import 'package:stock_app/features/inventory/domain/entities/inventory.dart';

class InventoryModel extends Inventory {
  InventoryModel({required super.id, required super.name});

  factory InventoryModel.fromMap(Map<String, dynamic> map) {
    return InventoryModel(id: map['id'] as String, name: map['name'] as String);
  }

  Map<String, dynamic> toMap() {
    return {'id': id, 'name': name};
  }

  factory InventoryModel.fromEntity(Inventory inventory) {
    return InventoryModel(id: inventory.id, name: inventory.name);
  }

  InventoryModel copyWidth({String? id, String? name}) {
    return InventoryModel(id: id ?? this.id, name: name ?? this.name);
  }
}
