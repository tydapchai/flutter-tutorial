import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:pe_test_1/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('End-to-end integration test: Home -> Favorite -> Check tab', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle(const Duration(seconds: 3));

    expect(find.text('New Arrivals'), findsOneWidget);

    final favoriteIcon = find.byIcon(Icons.favorite_border).first;
    expect(favoriteIcon, findsOneWidget);

    await tester.tap(favoriteIcon);
    await tester.pumpAndSettle();

    await tester.tap(find.byIcon(Icons.favorite).last);
    await tester.pumpAndSettle();

    expect(find.text('Bạn chưa có sản phẩm yêu thích nào'), findsNothing);
    expect(find.byIcon(Icons.favorite), findsWidgets);
  });
}
