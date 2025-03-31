import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:stock_app/features/inventory/domain/entities/inventory.dart';

import '../../../mocks/mock_inventory_repository.dart';

void main() {
  late MockInventoryRepository mockRepository;

  setUp(() {
    mockRepository = MockInventoryRepository();
  });

  group('InventoryRepository Tests', () {
    test('Debe obtener una lista de inventarios', () async {
      // Simulamos datos de inventario
      final fakeInventoryList = [
        Inventory(id: "1", name: "Producto A"),
        Inventory(id: "2", name: "Producto B"),
      ];

      // Configurar el mock para devolver la lista simulada
      when(
        () => mockRepository.getAllInventory(),
      ).thenAnswer((_) async => fakeInventoryList);

      // Llamamos a la función
      final result = await mockRepository.getAllInventory();

      // Verificaciones
      expect(result, fakeInventoryList);
      verify(() => mockRepository.getAllInventory()).called(1);
    });

    test('Debe crear un inventario correctamente', () async {
      final newInventory = Inventory(id: "3", name: "Producto C");

      // Configuramos el mock para que simplemente complete la función
      when(
        () => mockRepository.createInventory(newInventory),
      ).thenAnswer((_) async {});

      // Llamamos a la función
      await mockRepository.createInventory(newInventory);

      // Verificar que el método fue llamado una vez con el objeto correcto
      verify(() => mockRepository.createInventory(newInventory)).called(1);
    });

    test('Debe eliminar un inventario por ID', () async {
      const id = "1";

      when(() => mockRepository.deleteInventory(id)).thenAnswer((_) async {});

      await mockRepository.deleteInventory(id);

      verify(() => mockRepository.deleteInventory(id)).called(1);
    });

    test('Debe editar el nombre de un inventario', () async {
      const id = "2";
      const newName = "Producto B Editado";

      when(
        () => mockRepository.editInventory(id, newName),
      ).thenAnswer((_) async {});

      await mockRepository.editInventory(id, newName);

      verify(() => mockRepository.editInventory(id, newName)).called(1);
    });
  });
}
