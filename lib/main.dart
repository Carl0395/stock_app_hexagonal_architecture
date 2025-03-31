import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:stock_app/features/inventory/presentation/inventory_bloc/inventory_bloc.dart';
import 'package:stock_app/features/product/presentation/product_bloc/product_bloc.dart';
import 'package:stock_app/core/dependency_injection.dart';
import 'package:stock_app/features/inventory/presentation/pages/inventory_list_page.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initializeDateFormatting('es', '');
  setupDependencyInjection();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => GetIt.I<InventoryBloc>()),
        BlocProvider(create: (_) => GetIt.I<ProductBloc>()),
      ],
      child: MaterialApp(
        title: 'Gestión de Inventarios',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          textButtonTheme: TextButtonThemeData(
            style: ButtonStyle(
              foregroundColor: WidgetStateProperty.resolveWith(
                (state) => Color(0xFF4780FF),
              ),
            ),
          ),
          textSelectionTheme: TextSelectionThemeData(
            cursorColor: Color(0xFF4780FF),
            selectionColor: Color(0xFF4780FF).withValues(alpha: 0.4),
          ),
        ),
        debugShowCheckedModeBanner: false,
        home: const InventoryListPage(),
      ),
    );
  }
}
