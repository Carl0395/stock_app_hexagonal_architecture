import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stock_app/features/inventory/domain/entities/inventory.dart';
import 'package:stock_app/features/inventory/presentation/inventory_bloc/inventory_bloc.dart';
import 'package:stock_app/features/inventory/presentation/inventory_bloc/inventory_event.dart';
import 'package:stock_app/features/product/presentation/pages/products_list_page.dart';
import 'package:stock_app/shared/dialogs.dart';

class InventoryBox extends StatelessWidget {
  final Inventory inventory;
  const InventoryBox({super.key, required this.inventory});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Material(
        color: Colors.white,
        elevation: 2,
        borderRadius: BorderRadius.circular(4),
        child: InkWell(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => ProductsListPage(inventory: inventory),
              ),
            );
          },
          child: ListTile(
            title: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(inventory.name),
            ),
            subtitle: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text('ID: ${inventory.id}'),
            ),
            contentPadding: EdgeInsets.all(0),
            trailing: Wrap(
              children: [
                InkWell(
                  onTap: () => _editInventory(context),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                    color: Colors.transparent,
                    child: Icon(Icons.edit, color: Colors.blue[300]),
                  ),
                ),

                InkWell(
                  onTap: () {
                    context.read<InventoryBloc>().add(
                      RemoveInventory(inventory.id),
                    );
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                    color: Colors.transparent,
                    child: Icon(
                      Icons.delete_outline_rounded,
                      color: Colors.red[300],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _editInventory(BuildContext context) async {
    final name = await showInputDialog(
      context,
      title: 'Actualizar Inventario',
      hintText: 'Nombre del inventario',
      defaultValue: inventory.name,
      actionText: 'Guardar',
    );

    if (name.isEmpty) return;
    if (context.mounted) {
      context.read<InventoryBloc>().add(UpdateInventory(inventory.id, name));
    }
  }
}
