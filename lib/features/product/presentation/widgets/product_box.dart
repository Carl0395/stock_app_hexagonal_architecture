import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stock_app/features/product/domain/entities/product.dart';
import 'package:stock_app/features/product/presentation/pages/product_page.dart';
import 'package:stock_app/features/product/presentation/product_bloc/product_bloc.dart';
import 'package:stock_app/features/product/presentation/product_bloc/product_event.dart';
import 'package:stock_app/shared/dialogs.dart';

class ProductBox extends StatelessWidget {
  final Product product;
  const ProductBox({super.key, required this.product});

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
                builder: (context) => ProductPage(product: product),
              ),
            );
          },
          child: ListTile(
            title: Text(product.name),
            subtitle: Text('ID: ${product.id}'),
            trailing: Wrap(
              children: [
                InkWell(
                  onTap: () => _editProduct(context),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                    color: Colors.transparent,
                    child: Icon(Icons.edit, color: Colors.blue[300]),
                  ),
                ),

                InkWell(
                  onTap: () {
                    context.read<ProductBloc>().add(
                      RemoveProduct(
                        idInventory: product.inventoryId,
                        idProduct: product.id,
                      ),
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

  Future<void> _editProduct(BuildContext context) async {
    final values = await showFormDialog(
      context,
      title: 'Actualizar Inventario',
      defaultValue1: product.name,
      defaultValue2: product.price,
      defaultValue3: product.quantity.toString(),
      actionText: 'Guardar',
    );

    if (values[0].isEmpty || values[1].isEmpty || values[2].isEmpty) {
      return;
    }

    if (context.mounted) {
      // context.read<InventoryBloc>().add(UpdateInventory(inventory.id, name));
      context.read<ProductBloc>().add(
        UpdateProduct(
          name: values[0],
          price: values[1],
          quantity: int.parse(values[2]),
          product: product,
        ),
      );
    }
  }
}
