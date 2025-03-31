import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:stock_app/features/product/domain/entities/product.dart';

import '../../mocks/mock_product_repository.dart';

void main() {
  late MockProductRepository mockRepository;

  setUp(() {
    mockRepository = MockProductRepository();
  });

  group('ProductRepository Tests', () {
    setUpAll(() {
      registerFallbackValue(
        Product(
          id: '0',
          name: 'Fallback',
          price: '0',
          inventoryId: '',
          barcode: '1',
          createdAt: DateTime.now(),
          quantity: 1,
        ),
      );
    });

    test('Debe obtener una lista de productos', () async {
      const inventoryId = "inv123";
      final fakeProducts = [
        Product(
          id: "1",
          name: "Producto A",
          price: '10',
          inventoryId: '',
          barcode: '1',
          createdAt: DateTime.now(),
          quantity: 1,
        ),
        Product(
          id: "2",
          name: "Producto B",
          price: '20',
          inventoryId: '',
          barcode: '1',
          createdAt: DateTime.now(),
          quantity: 1,
        ),
      ];

      // Simular respuesta del mock
      when(
        () => mockRepository.getProducts(inventoryId),
      ).thenAnswer((_) async => fakeProducts);

      // Llamar al método
      final result = await mockRepository.getProducts(inventoryId);

      // Verificaciones
      expect(result, fakeProducts);
      verify(() => mockRepository.getProducts(inventoryId)).called(1);
    });

    test('Debe agregar un producto', () async {
      final newProduct = Product(
        id: "3",
        name: "Producto C",
        price: '30',
        inventoryId: '',
        barcode: '1',
        createdAt: DateTime.now(),
        quantity: 1,
      );

      when(
        () => mockRepository.addProduct(newProduct),
      ).thenAnswer((_) async {});

      await mockRepository.addProduct(newProduct);

      verify(() => mockRepository.addProduct(newProduct)).called(1);
    });

    test(
      'Debe eliminar un producto dado un ID de inventario y de producto',
      () async {
        const inventoryId = "inv123";
        const productId = "prod456";

        when(
          () => mockRepository.deleteProduct(
            idInventory: inventoryId,
            idProduct: productId,
          ),
        ).thenAnswer((_) async {});

        await mockRepository.deleteProduct(
          idInventory: inventoryId,
          idProduct: productId,
        );

        verify(
          () => mockRepository.deleteProduct(
            idInventory: inventoryId,
            idProduct: productId,
          ),
        ).called(1);
      },
    );

    test('Debe actualizar un producto', () async {
      final updatedProduct = Product(
        id: "1",
        name: "Producto A Modificado",
        price: '15',
        inventoryId: '',
        barcode: '1',
        createdAt: DateTime.now(),
        quantity: 1,
      );

      when(
        () => mockRepository.updateProduct(updatedProduct),
      ).thenAnswer((_) async {});

      await mockRepository.updateProduct(updatedProduct);

      verify(() => mockRepository.updateProduct(updatedProduct)).called(1);
    });
  });
}
