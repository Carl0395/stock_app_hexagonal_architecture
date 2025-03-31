import 'package:get_it/get_it.dart';
import 'package:stock_app/features/inventory/application/use_cases/edit_inventory.dart';
import 'package:stock_app/features/inventory/presentation/inventory_bloc/inventory_bloc.dart';
import 'package:stock_app/features/product/application/use_cases/edit_product.dart';
import 'package:stock_app/features/product/presentation/product_bloc/product_bloc.dart';
import 'package:stock_app/features/inventory/infrastructure/local_inventory_repository_impl.dart';
import 'package:stock_app/features/product/infrastructure/local_product_repository_impl.dart';
import 'package:stock_app/features/inventory/domain/repositories/inventory_repository.dart';
import 'package:stock_app/features/product/domain/repositories/product_repository.dart';
import 'package:stock_app/features/inventory/application/use_cases/create_inventory.dart';
import 'package:stock_app/features/inventory/application/use_cases/delete_inventory.dart';
import 'package:stock_app/features/inventory/application/use_cases/get_all_inventory.dart';
import 'package:stock_app/features/product/application/use_cases/add_product.dart';
import 'package:stock_app/features/product/application/use_cases/delete_product.dart';
import 'package:stock_app/features/product/application/use_cases/get_products.dart';

final getIt = GetIt.instance;

void setupDependencyInjection() {
  // Repositorios
  getIt.registerLazySingleton<InventoryRepository>(
    () => LocalInventoryRepositoryImpl(),
  );
  getIt.registerLazySingleton<ProductRepository>(
    () => LocalProductRepositoryImpl(),
  );

  // Casos de uso de Inventario
  getIt.registerLazySingleton(
    () => GetAllInventory(getIt<InventoryRepository>()),
  );
  getIt.registerLazySingleton(
    () => CreateInventory(getIt<InventoryRepository>()),
  );
  getIt.registerLazySingleton(
    () => DeleteInventory(getIt<InventoryRepository>()),
  );
  getIt.registerLazySingleton(
    () => EditInventory(getIt<InventoryRepository>()),
  );

  // Casos de uso de Producto
  getIt.registerLazySingleton(() => GetProducts(getIt<ProductRepository>()));
  getIt.registerLazySingleton(() => AddProduct(getIt<ProductRepository>()));
  getIt.registerLazySingleton(() => DeleteProduct(getIt<ProductRepository>()));
  getIt.registerLazySingleton(() => EditProduct(getIt<ProductRepository>()));

  // Blocs
  getIt.registerFactory(
    () => InventoryBloc(
      getInventories: getIt(),
      addInventory: getIt(),
      deleteInventory: getIt(),
      editInventory: getIt(),
    ),
  );

  getIt.registerFactory(
    () => ProductBloc(
      getProducts: getIt(),
      addProduct: getIt(),
      deleteProduct: getIt(),
      editProduct: getIt(),
    ),
  );
}
