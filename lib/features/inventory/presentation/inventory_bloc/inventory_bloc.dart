import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stock_app/features/inventory/application/use_cases/edit_inventory.dart';
import 'package:stock_app/features/inventory/domain/entities/inventory.dart';
import 'package:stock_app/features/inventory/presentation/inventory_bloc/inventory_event.dart';
import 'package:stock_app/features/inventory/presentation/inventory_bloc/inventory_state.dart';
import 'package:stock_app/features/inventory/application/use_cases/create_inventory.dart';
import 'package:stock_app/features/inventory/application/use_cases/delete_inventory.dart';
import 'package:stock_app/features/inventory/application/use_cases/get_all_inventory.dart';

class InventoryBloc extends Bloc<InventoryEvent, InventoryState> {
  final GetAllInventory getInventories;
  final CreateInventory addInventory;
  final DeleteInventory deleteInventory;
  final EditInventory editInventory;

  InventoryBloc({
    required this.getInventories,
    required this.addInventory,
    required this.deleteInventory,
    required this.editInventory,
  }) : super(InventoryState([])) {
    on<LoadInventories>((event, emit) async {
      emit(InventoryState(await getInventories()));
    });
    on<AddNewInventory>((event, emit) async {
      final inventory = Inventory(
        id: 'inv${Random().nextInt(1000) + 1}',
        name: event.name,
      );
      await addInventory(inventory);
      emit(InventoryState(await getInventories()));
    });
    on<RemoveInventory>((event, emit) async {
      await deleteInventory(event.id);
      emit(InventoryState(await getInventories()));
    });
    on<UpdateInventory>((event, emit) async {
      await editInventory(event.id, event.newName);
      emit(InventoryState(await getInventories()));
    });

    add(LoadInventories());
  }
}
