import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import 'core/theme/app_theme.dart';
import 'data/datasources/product_remote_data_source.dart';
import 'data/repositories_impl/product_repository_impl.dart';
import 'domain/usecases/get_products.dart';
import 'presentation/screens/main_screen.dart';
import 'presentation/state/cart_provider.dart';
import 'presentation/state/favorite_provider.dart';
import 'presentation/state/product_provider.dart';

void main() {
  // Dependency Injection Setup
  final client = http.Client();
  final remoteDataSource = ProductRemoteDataSourceImpl(client: client);
  final repository = ProductRepositoryImpl(remoteDataSource: remoteDataSource);
  final getProducts = GetProducts(repository);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProductProvider(getProducts: getProducts)..fetchProducts()),
        ChangeNotifierProvider(create: (_) => FavoriteProvider()),
        ChangeNotifierProvider(create: (_) => CartProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'E-Commerce App',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.dark,
      home: const MainScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
