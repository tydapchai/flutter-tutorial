import 'package:flutter/material.dart';

class AppStructureDemo extends StatefulWidget {
  const AppStructureDemo({super.key});

  @override
  State<AppStructureDemo> createState() => _AppStructureDemoState();
}

class _AppStructureDemoState extends State<AppStructureDemo> {
  // Toggle state for Dark Mode
  bool _isDarkMode = false;

  @override
  Widget build(BuildContext context) {
    // Define ThemeData customization
    final lightTheme = ThemeData(
      brightness: Brightness.light,
      primarySwatch: Colors.blue,
      scaffoldBackgroundColor: Colors.white,
    );
    
    final darkTheme = ThemeData(
      brightness: Brightness.dark,
      primarySwatch: Colors.indigo,
      scaffoldBackgroundColor: Colors.grey[900],
    );

    // We wrap inside a Theme widget to apply the local theme dynamically
    return Theme(
      data: _isDarkMode ? darkTheme : lightTheme,
      child: Scaffold(
        // Scaffold inherently inherits the theme's background color
        appBar: AppBar(
          title: const Text('Exercise 4: App Structure'),
          actions: [
            // Toggle for Dark Mode using themeMode concept locally
            IconButton(
              icon: Icon(_isDarkMode ? Icons.light_mode : Icons.dark_mode),
              onPressed: () {
                setState(() {
                  _isDarkMode = !_isDarkMode;
                });
              },
            )
          ],
        ),
        body: Center(
          child: Text(
            _isDarkMode ? 'Dark Mode is ON' : 'Light Mode is ON',
            style: TextStyle(
              fontSize: 24,
              color: _isDarkMode ? Colors.white : Colors.black,
            ),
          ),
        ),
        // FloatingActionButton
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('FAB Clicked!')),
            );
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
