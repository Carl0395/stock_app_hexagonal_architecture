import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stock_app/features/product/application/use_cases/edit_product.dart';
import 'package:stock_app/features/product/domain/entities/product.dart';
import 'package:stock_app/features/product/presentation/product_bloc/product_event.dart';
import 'package:stock_app/features/product/presentation/product_bloc/product_state.dart';
import 'package:stock_app/features/product/application/use_cases/add_product.dart';
import 'package:stock_app/features/product/application/use_cases/delete_product.dart';
import 'package:stock_app/features/product/application/use_cases/get_products.dart';
import 'package:stock_app/shared/util/util.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final GetProducts getProducts;
  final AddProduct addProduct;
  final DeleteProduct deleteProduct;
  final EditProduct editProduct;

  ProductBloc({
    required this.getProducts,
    required this.addProduct,
    required this.deleteProduct,
    required this.editProduct,
  }) : super(ProductState([])) {
    on<LoadProducts>((event, emit) async {
      emit(ProductState(await getProducts(event.inventoryId)));
    });
    on<AddNewProduct>((event, emit) async {
      final product = Product(
        id: 'prod${DateTime.now().millisecondsSinceEpoch}',
        name: event.name,
        price: event.price,
        quantity: int.parse(event.quantity),
        barcode: generateRandomNumber(),
        inventoryId: event.inventoryId,
        createdAt: DateTime.now(),
      );
      await addProduct(product);
      emit(ProductState(await getProducts(product.inventoryId)));
    });
    on<RemoveProduct>((event, emit) async {
      await deleteProduct(event.idInventory, event.idProduct);
      emit(ProductState(await getProducts(event.idInventory)));
    });
    on<UpdateProduct>((event, emit) async {
      final product = Product(
        id: event.product.id,
        name: event.name,
        price: event.price,
        quantity: event.quantity,
        barcode: event.product.barcode,
        inventoryId: event.product.inventoryId,
        createdAt: event.product.createdAt,
      );
      await editProduct(product);
      emit(ProductState(await getProducts(product.inventoryId)));
    });
  }
}
