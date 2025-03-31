import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stock_app/features/inventory/domain/entities/inventory.dart';
import 'package:stock_app/features/product/presentation/product_bloc/product_bloc.dart';
import 'package:stock_app/features/product/presentation/product_bloc/product_event.dart';
import 'package:stock_app/features/product/presentation/product_bloc/product_state.dart';
import 'package:stock_app/features/product/presentation/widgets/product_box.dart';
import 'package:stock_app/shared/dialogs.dart';
import 'package:stock_app/shared/widgets/custom_button.dart';

class ProductsListPage extends StatefulWidget {
  final Inventory inventory;
  const ProductsListPage({super.key, required this.inventory});

  @override
  State<ProductsListPage> createState() => _ProductsListPageState();
}

class _ProductsListPageState extends State<ProductsListPage> {
  @override
  void initState() {
    super.initState();
    context.read<ProductBloc>().add(LoadProducts(widget.inventory.id));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F7FB),
      appBar: AppBar(
        title: Text(widget.inventory.name),
        backgroundColor: Color(0xFFF5F7FB),
      ),
      body: BlocBuilder<ProductBloc, ProductState>(
        builder: (_, state) {
          if (state.products.isEmpty) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Center(child: Text('No hay productos disponibles')),
                SizedBox(height: 12),
                CustomButton(
                  label: 'Crear producto',
                  onPressed: () async {
                    _createProduct(context);
                  },
                ),
                SizedBox(height: 60),
              ],
            );
          }

          return ListView.builder(
            itemCount: state.products.length,
            padding: EdgeInsets.only(bottom: 100),
            itemBuilder: (context, index) {
              final product = state.products.reversed.toList()[index];
              return ProductBox(product: product);
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: 'add_inventory',
        onPressed: () {
          _createProduct(context);
        },
        backgroundColor: Color(0xFF4780FF),
        shape: CircleBorder(),
        child: const Icon(Icons.add, size: 24, color: Colors.white),
      ),
    );
  }

  Future<void> _createProduct(BuildContext context) async {
    final values = await showFormDialog(
      context,
      title: 'Producto',
      hintTextField1: 'Nombre',
      hintTextField2: 'Precio',
      hintTextField3: 'Cantidad',
    );

    if (values[0].isEmpty || values[1].isEmpty || values[2].isEmpty) {
      return;
    }

    if (context.mounted) {
      context.read<ProductBloc>().add(
        AddNewProduct(
          name: values[0],
          price: values[1],
          quantity: values[2],
          inventoryId: widget.inventory.id,
        ),
      );
    }
  }
}
