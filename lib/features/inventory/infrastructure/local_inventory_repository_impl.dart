import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:stock_app/features/inventory/domain/entities/inventory.dart';
import 'package:stock_app/features/inventory/domain/repositories/inventory_repository.dart';
import 'package:stock_app/features/inventory/infrastructure/inventory_model.dart';

class LocalInventoryRepositoryImpl implements InventoryRepository {
  LocalInventoryRepositoryImpl();

  @override
  Future<void> createInventory(Inventory inventory) async {
    final inventories = await getAllInventory();
    inventories.add(InventoryModel.fromEntity(inventory));

    await _saveInventories(inventories);
  }

  @override
  Future<void> deleteInventory(String id) async {
    final inventories = await getAllInventory();
    final updatedList = inventories.where((inv) => inv.id != id).toList();
    await _saveInventories(updatedList);
  }

  @override
  Future<List<Inventory>> getAllInventory() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    final data = preferences.getString('inventories') ?? '[]';
    List<dynamic> jsonData = json.decode(data);
    return jsonData
        .map((inv) => InventoryModel.fromMap(json.decode(inv)))
        .toList();
  }

  Future<void> _saveInventories(List<Inventory> inventories) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    List<String> inventoriesJson =
        inventories.map((inventory) {
          return json.encode(InventoryModel.fromEntity(inventory).toMap());
        }).toList();

    preferences.setString('inventories', json.encode(inventoriesJson));
  }

  @override
  Future<void> editInventory(String id, String newName) async {
    final inventories = await getAllInventory();
    final index = inventories.indexWhere((inv) => inv.id == id);
    final inventory = InventoryModel.fromEntity(
      inventories[index],
    ).copyWidth(name: newName);

    inventories[index] = inventory;

    await _saveInventories(inventories);
  }
}
