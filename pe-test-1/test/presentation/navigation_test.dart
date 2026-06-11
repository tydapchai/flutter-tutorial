import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:pe_test_1/domain/entities/product.dart';
import 'package:pe_test_1/domain/repositories/product_repository.dart';
import 'package:pe_test_1/domain/usecases/get_products.dart';
import 'package:pe_test_1/presentation/screens/main_screen.dart';
import 'package:pe_test_1/presentation/screens/product_detail_screen.dart';
import 'package:pe_test_1/presentation/state/cart_provider.dart';
import 'package:pe_test_1/presentation/state/favorite_provider.dart';
import 'package:pe_test_1/presentation/state/product_provider.dart';

class MockProductRepository implements ProductRepository {
  @override
  Future<List<Product>> getProducts() async {
    return [
      const Product(
        id: 1,
        title: 'Mock Product',
        description: 'Description',
        price: 9.99,
        rating: 4.5,
        thumbnail: 'https://via.placeholder.com/150',
        images: ['https://via.placeholder.com/150'],
      )
    ];
  }
}

void main() {
  testWidgets('Navigation from Home to Detail Screen', (WidgetTester tester) async {
    final getProducts = GetProducts(MockProductRepository());

    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => ProductProvider(getProducts: getProducts)..fetchProducts()),
          ChangeNotifierProvider(create: (_) => FavoriteProvider()),
          ChangeNotifierProvider(create: (_) => CartProvider()),
        ],
        child: const MaterialApp(
          home: MainScreen(),
        ),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.text('Mock Product'), findsOneWidget);

    await tester.tap(find.text('Mock Product'));
    await tester.pumpAndSettle();

    expect(find.byType(ProductDetailScreen), findsOneWidget);
    expect(find.text('Color'), findsOneWidget);
  });
}
