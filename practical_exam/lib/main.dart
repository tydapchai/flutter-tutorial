import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'ui/main_screen.dart';
import 'viewmodel/product_viewmodel.dart';
import 'viewmodel/favorite_viewmodel.dart';
import 'repository/product_repository.dart';
import 'repository/favorite_repository.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ProductViewModel(),
        ),
        ChangeNotifierProvider(
          create: (context) => FavoriteViewModel(FavoriteRepository()),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Smartphones Store',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const MainScreen(),
    );
  }
}
