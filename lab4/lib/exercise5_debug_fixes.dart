import 'package:flutter/material.dart';

class DebugFixesDemo extends StatelessWidget {
  const DebugFixesDemo({super.key});

  @override
  Widget build(BuildContext context) {
    final movies = ['Movie A', 'Movie B', 'Movie C', 'Movie D'];

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        title: const Text('Exercise 5 – Common U...', style: TextStyle(color: Colors.black)),
        backgroundColor: const Color(0xFFF8F9FA),
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Correct ListView inside Column using Expanded',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.separated(
                itemCount: movies.length,
                separatorBuilder: (_, __) => const SizedBox(height: 16),
                itemBuilder: (context, index) {
                  return Row(
                    children: [
                      const Icon(Icons.movie, color: Colors.black54),
                      const SizedBox(width: 16),
                      Text(movies[index], style: const TextStyle(fontSize: 16, color: Colors.black87)),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
