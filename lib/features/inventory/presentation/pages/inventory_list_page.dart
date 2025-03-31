import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stock_app/features/inventory/presentation/inventory_bloc/inventory_bloc.dart';
import 'package:stock_app/features/inventory/presentation/inventory_bloc/inventory_event.dart';
import 'package:stock_app/features/inventory/presentation/inventory_bloc/inventory_state.dart';
import 'package:stock_app/features/inventory/presentation/widgets/inventory_box.dart';
import 'package:stock_app/shared/dialogs.dart';
import 'package:stock_app/shared/widgets/custom_button.dart';

class InventoryListPage extends StatelessWidget {
  const InventoryListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F7FB),
      appBar: AppBar(
        title: const Text('Inventarios'),
        backgroundColor: Color(0xFFF5F7FB),
        centerTitle: false,
      ),
      body: BlocBuilder<InventoryBloc, InventoryState>(
        builder: (_, state) {
          if (state.inventories.isEmpty) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Center(child: Text('No hay inventarios disponibles')),
                SizedBox(height: 12),
                CustomButton(
                  onPressed: () => _createInventory(context),
                  label: 'Crear inventario',
                ),
                SizedBox(height: 60),
              ],
            );
          }
          return ListView.builder(
            itemCount: state.inventories.length,
            padding: EdgeInsets.only(bottom: 100),
            itemBuilder: (context, index) {
              final inventory = state.inventories.reversed.toList()[index];
              return InventoryBox(inventory: inventory);
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: 'add_inventory',
        onPressed: () {
          _createInventory(context);
        },
        backgroundColor: Color(0xFF4780FF),
        shape: CircleBorder(),
        child: const Icon(Icons.add, size: 24, color: Colors.white),
      ),
    );
  }

  void _createInventory(BuildContext context) async {
    final name = await showInputDialog(
      context,
      title: 'Crear Inventario',
      hintText: 'Nombre del inventario',
    );

    if (name.isEmpty) return;
    if (context.mounted) {
      context.read<InventoryBloc>().add(AddNewInventory(name));
    }
  }
}
