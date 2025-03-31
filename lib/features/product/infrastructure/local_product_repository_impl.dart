import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:stock_app/features/product/infrastructure/product_model.dart';
import 'package:stock_app/features/product/domain/entities/product.dart';
import 'package:stock_app/features/product/domain/repositories/product_repository.dart';

class LocalProductRepositoryImpl implements ProductRepository {
  LocalProductRepositoryImpl();

  @override
  Future<void> addProduct(Product product) async {
    final products = await _getAllProducts();
    products.add(ProductModel.fromEntity(product));
    _saveProducts(products);
  }

  @override
  Future<void> deleteProduct({
    required String idInventory,
    required String idProduct,
  }) async {
    final products = await _getAllProducts();
    final updatedList = products.where((prod) => prod.id != idProduct).toList();
    _saveProducts(updatedList);
  }

  @override
  Future<List<Product>> getProducts(String inventoryId) async {
    final preferences = await SharedPreferences.getInstance();

    final data = preferences.getString('products') ?? '[]';
    List<dynamic> jsonData = json.decode(data);

    return jsonData
        .where((prod) => json.decode(prod)['inventoryId'] == inventoryId)
        .map((prodMap) => ProductModel.fromMap(json.decode(prodMap)))
        .toList();
  }

  @override
  Future<void> updateProduct(Product newProduct) async {
    final products = await _getAllProducts();
    final index = products.indexWhere((prod) => prod.id == newProduct.id);
    if (index != -1) {
      products[index] = ProductModel.fromEntity(newProduct);
    }
    _saveProducts(products);
  }

  Future<List<Product>> _getAllProducts() async {
    final preferences = await SharedPreferences.getInstance();
    final data = preferences.getString('products') ?? '[]';
    List<dynamic> jsonData = json.decode(data);
    return jsonData
        .map((prodMap) => ProductModel.fromMap(json.decode(prodMap)))
        .toList();
  }

  Future<void> _saveProducts(List<Product> products) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    List<String> productsJson =
        products.map((product) {
          return json.encode(ProductModel.fromEntity(product).toMap());
        }).toList();

    preferences.setString('products', json.encode(productsJson));
  }
}
