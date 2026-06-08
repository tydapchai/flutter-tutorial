import 'package:flutter/material.dart';
import 'movie_model.dart';

class MovieDetailScreen extends StatefulWidget {
  final Movie movie;

  const MovieDetailScreen({super.key, required this.movie});

  @override
  State<MovieDetailScreen> createState() => _MovieDetailScreenState();
}

class _MovieDetailScreenState extends State<MovieDetailScreen> {
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFAFAFA),
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black87),
        title: Text(widget.movie.title, style: const TextStyle(color: Colors.black87, fontSize: 18)),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Hero Banner
            Hero(
              tag: 'movie_\${widget.movie.id}',
              child: Stack(
                children: [
                  Image.network(
                    widget.movie.posterUrl,
                    width: double.infinity,
                    height: 250,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Container(
                      width: double.infinity, height: 250, color: Colors.grey[300],
                      child: const Center(child: Icon(Icons.movie, size: 50)),
                    ),
                  ),
                  // Gradient for better text readability
                  Positioned.fill(
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            Colors.black.withOpacity(0.8),
                          ],
                          stops: const [0.5, 1.0],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 16,
                    left: 16,
                    child: Text(
                      widget.movie.title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Genres
                  Wrap(
                    spacing: 8,
                    children: widget.movie.genres.map((genre) {
                      return Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.grey.withOpacity(0.3)),
                        ),
                        child: Text(
                          genre,
                          style: const TextStyle(color: Colors.black54, fontSize: 13),
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 20),
                  
                  // Overview
                  Text(
                    widget.movie.overview,
                    style: const TextStyle(fontSize: 15, color: Colors.black87, height: 1.5),
                  ),
                  const SizedBox(height: 30),
                  
                  // Action buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildActionButton(
                        icon: isFavorite ? Icons.favorite : Icons.favorite_border,
                        color: isFavorite ? Colors.red : Colors.black54,
                        label: 'Favorite',
                        onTap: () {
                          setState(() {
                            isFavorite = !isFavorite;
                          });
                        },
                      ),
                      _buildActionButton(
                        icon: Icons.star,
                        color: Colors.black54,
                        label: 'Rate',
                        onTap: () {},
                      ),
                      _buildActionButton(
                        icon: Icons.share,
                        color: Colors.black54,
                        label: 'Share',
                        onTap: () {},
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),
                  
                  // Trailers section
                  const Text(
                    'Trailers',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87),
                  ),
                  const SizedBox(height: 12),
                  
                  // Trailer list
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: widget.movie.trailers.length,
                    separatorBuilder: (_, __) => Divider(height: 1, color: Colors.grey.withOpacity(0.3)),
                    itemBuilder: (context, index) {
                      final trailer = widget.movie.trailers[index];
                      return ListTile(
                        contentPadding: const EdgeInsets.symmetric(vertical: 4),
                        leading: const Icon(Icons.play_circle_filled, color: Colors.black54, size: 28),
                        title: Text(trailer.title, style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 15, color: Colors.black87)),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton({required IconData icon, required String label, required VoidCallback onTap, required Color color}) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          children: [
            Icon(icon, color: color, size: 28),
            const SizedBox(height: 8),
            Text(label, style: const TextStyle(color: Colors.black54, fontSize: 13)),
          ],
        ),
      ),
    );
  }
}
