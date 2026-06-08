import 'package:flutter/material.dart';
import 'exercise1_core_widgets.dart';
import 'exercise2_input_widgets.dart';
import 'exercise3_layout_basics.dart';
import 'exercise4_app_structure.dart';
import 'exercise5_debug_fixes.dart';

void main() {
  runApp(const Lab4App());
}

class Lab4App extends StatelessWidget {
  const Lab4App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lab 4 - Flutter UI',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: const Color(0xFFF8F9FA),
      ),
      home: const MainScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  Widget _buildMenuButton(BuildContext context, String title, Widget page) {
    return InkWell(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => page),
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        decoration: BoxDecoration(
          color: const Color(0xFFF3F2F8),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.withOpacity(0.2)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                title,
                style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500, color: Colors.black87),
              ),
            ),
            const Icon(Icons.chevron_right, color: Colors.black54),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lab 4 – Flutter UI Fundament...', style: TextStyle(color: Colors.black)),
        backgroundColor: const Color(0xFFF8F9FA),
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildMenuButton(context, 'Exercise 1 – Core Widgets\nDemo', const CoreWidgetsDemo()),
          const SizedBox(height: 12),
          _buildMenuButton(context, 'Exercise 2 – Input Controls\nDemo', const InputControlsDemo()),
          const SizedBox(height: 12),
          _buildMenuButton(context, 'Exercise 3 – Layout Demo', const LayoutBasicsDemo()),
          const SizedBox(height: 12),
          _buildMenuButton(context, 'Exercise 4 – App Structure &\nTheme', const AppStructureDemo()),
          const SizedBox(height: 12),
          _buildMenuButton(context, 'Exercise 5 – Common UI\nFixes', const DebugFixesDemo()),
        ],
      ),
    );
  }
}
