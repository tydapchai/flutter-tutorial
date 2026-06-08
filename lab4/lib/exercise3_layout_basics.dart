import 'package:flutter/material.dart';

class LayoutBasicsDemo extends StatelessWidget {
  const LayoutBasicsDemo({super.key});

  @override
  Widget build(BuildContext context) {
    final movies = [
      {'title': 'Avatar', 'desc': 'Sample description', 'initial': 'A'},
      {'title': 'Inception', 'desc': 'Sample description', 'initial': 'I'},
      {'title': 'Interstellar', 'desc': 'Sample description', 'initial': 'I'},
      {'title': 'Joker', 'desc': 'Sample description', 'initial': 'J'},
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        title: const Text('Exercise 3 – Layout De...', style: TextStyle(color: Colors.black)),
        backgroundColor: const Color(0xFFF8F9FA),
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 10),
            const Text(
              'Now Playing',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.separated(
                itemCount: movies.length,
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final movie = movies[index];
                  return Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFFF3F2F8),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey.withOpacity(0.2)),
                    ),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: const Color(0xFFE5E5FF),
                        child: Text(
                          movie['initial']!,
                          style: const TextStyle(color: Colors.indigo, fontWeight: FontWeight.w500),
                        ),
                      ),
                      title: Text(movie['title']!, style: const TextStyle(fontWeight: FontWeight.w500, color: Colors.black87)),
                      subtitle: Text(movie['desc']!, style: const TextStyle(color: Colors.black54)),
                    ),
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
