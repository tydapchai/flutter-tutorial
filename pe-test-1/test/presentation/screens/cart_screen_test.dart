import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:pe_test_1/presentation/screens/cart_screen.dart';
import 'package:pe_test_1/presentation/state/cart_provider.dart';

void main() {
  testWidgets('CartScreen displays empty state when cart is empty', (WidgetTester tester) async {
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => CartProvider()),
        ],
        child: const MaterialApp(
          home: Scaffold(body: CartScreen()),
        ),
      ),
    );

    expect(find.text('Your cart is empty'), findsOneWidget);
    expect(find.byIcon(Icons.shopping_cart_checkout), findsOneWidget);
  });
}
