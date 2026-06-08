import 'package:flutter/material.dart';

// ── Movie Model ──
class Movie {
  final String title;
  final int year;
  final List<String> genres;
  final String posterUrl;
  final double rating;

  const Movie({
    required this.title,
    required this.year,
    required this.genres,
    required this.posterUrl,
    required this.rating,
  });
}

// ── Sample Data ──
const List<Movie> allMovies = [
  Movie(
    title: 'Dune: Part Two',
    year: 2024,
    genres: ['Sci-Fi', 'Adventure', 'Drama'],
    posterUrl: 'https://picsum.photos/seed/dune/400/600',
    rating: 8.6,
  ),
  Movie(
    title: 'Deadpool & Wolverine',
    year: 2024,
    genres: ['Action', 'Comedy'],
    posterUrl: 'https://picsum.photos/seed/deadpool/400/600',
    rating: 8.3,
  ),
  Movie(
    title: 'The Batman',
    year: 2022,
    genres: ['Action', 'Drama'],
    posterUrl: 'https://picsum.photos/seed/batman/400/600',
    rating: 7.8,
  ),
  Movie(
    title: 'Interstellar',
    year: 2014,
    genres: ['Sci-Fi', 'Drama'],
    posterUrl: 'https://picsum.photos/seed/interstellar/400/600',
    rating: 8.7,
  ),
  Movie(
    title: 'The Hangover',
    year: 2009,
    genres: ['Comedy'],
    posterUrl: 'https://picsum.photos/seed/hangover/400/600',
    rating: 7.7,
  ),
  Movie(
    title: 'John Wick 4',
    year: 2023,
    genres: ['Action'],
    posterUrl: 'https://picsum.photos/seed/johnwick/400/600',
    rating: 7.9,
  ),
];

// ── Available genres & sort options ──
const List<String> genres = [
  'Action',
  'Comedy',
  'Drama',
  'Sci-Fi',
  'Adventure',
];

const List<String> sortOptions = ['A-Z', 'Z-A', 'Year', 'Rating'];

// ── Main ──
void main() {
  runApp(const ResponsiveMovieApp());
}

class ResponsiveMovieApp extends StatelessWidget {
  const ResponsiveMovieApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lab 6 - Responsive Movie Browser',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        scaffoldBackgroundColor: const Color(0xFFF9F9FB),
      ),
      home: const GenreScreen(),
    );
  }
}

// ── Genre Screen (Stateful) ──
class GenreScreen extends StatefulWidget {
  const GenreScreen({super.key});

  @override
  State<GenreScreen> createState() => _GenreScreenState();
}

class _GenreScreenState extends State<GenreScreen> {
  String searchQuery = '';
  Set<String> selectedGenres = {};
  String selectedSort = 'A-Z';

  // Filter and sort logic
  List<Movie> get visibleMovies {
    List<Movie> filtered = allMovies.where((movie) {
      // Search filter (case-insensitive)
      final matchesSearch =
          movie.title.toLowerCase().contains(searchQuery.toLowerCase());
      // Genre filter: if no genre selected show all, else match at least one
      final matchesGenre = selectedGenres.isEmpty ||
          movie.genres.any((g) => selectedGenres.contains(g));
      return matchesSearch && matchesGenre;
    }).toList();

    // Sort
    switch (selectedSort) {
      case 'A-Z':
        filtered.sort((a, b) => a.title.compareTo(b.title));
        break;
      case 'Z-A':
        filtered.sort((a, b) => b.title.compareTo(a.title));
        break;
      case 'Year':
        filtered.sort((a, b) => b.year.compareTo(a.year));
        break;
      case 'Rating':
        filtered.sort((a, b) => b.rating.compareTo(a.rating));
        break;
    }
    return filtered;
  }

  void _toggleGenre(String genre) {
    setState(() {
      if (selectedGenres.contains(genre)) {
        selectedGenres.remove(genre);
      } else {
        selectedGenres.add(genre);
      }
    });
  }

  void _clearFilters() {
    setState(() {
      searchQuery = '';
      selectedGenres.clear();
      selectedSort = 'A-Z';
    });
  }

  @override
  Widget build(BuildContext context) {
    final movies = visibleMovies;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ── Title ──
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Find a Movie',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1E1E2C),
                    ),
                  ),
                  if (selectedGenres.isNotEmpty || searchQuery.isNotEmpty)
                    TextButton.icon(
                      onPressed: _clearFilters,
                      icon: const Icon(Icons.clear_all, size: 20),
                      label: const Text('Clear'),
                    ),
                ],
              ),
              const SizedBox(height: 16),

              // ── Search Bar ──
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.withOpacity(0.2)),
                ),
                child: TextField(
                  onChanged: (value) {
                    setState(() {
                      searchQuery = value;
                    });
                  },
                  decoration: const InputDecoration(
                    hintText: 'Search movies...',
                    prefixIcon: Icon(Icons.search, color: Colors.grey),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(vertical: 14),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // ── Genre Chips (Wrap) ──
              Row(
                children: [
                  const Text(
                    'Genres',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF1E1E2C),
                    ),
                  ),
                  if (selectedGenres.isNotEmpty)
                    Container(
                      margin: const EdgeInsets.only(left: 8),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.indigo,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        '${selectedGenres.length}',
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: genres.map((genre) {
                  final isSelected = selectedGenres.contains(genre);
                  return GestureDetector(
                    onTap: () => _toggleGenre(genre),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 10),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? Colors.indigo
                            : const Color(0xFFF4F3F8),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: isSelected
                              ? Colors.indigo
                              : Colors.grey.withOpacity(0.3),
                        ),
                      ),
                      child: Text(
                        genre,
                        style: TextStyle(
                          color: isSelected ? Colors.white : Colors.black87,
                          fontWeight:
                              isSelected ? FontWeight.w600 : FontWeight.normal,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 16),

              // ── Sort Dropdown ──
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${movies.length} movie${movies.length == 1 ? '' : 's'} found',
                    style: const TextStyle(color: Colors.black54),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.grey.withOpacity(0.2)),
                    ),
                    child: DropdownButton<String>(
                      value: selectedSort,
                      underline: const SizedBox(),
                      icon: const Icon(Icons.sort, size: 20),
                      items: sortOptions.map((option) {
                        return DropdownMenuItem<String>(
                          value: option,
                          child: Text(option,
                              style: const TextStyle(fontSize: 14)),
                        );
                      }).toList(),
                      onChanged: (value) {
                        if (value != null) {
                          setState(() {
                            selectedSort = value;
                          });
                        }
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // ── Responsive Movie List ──
              Expanded(
                child: movies.isEmpty
                    ? const Center(
                        child: Text('No movies found.',
                            style:
                                TextStyle(fontSize: 16, color: Colors.grey)),
                      )
                    : LayoutBuilder(
                        builder: (context, constraints) {
                          // Breakpoint: >= 800px -> 2 columns GridView
                          if (constraints.maxWidth >= 800) {
                            return GridView.builder(
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisSpacing: 16,
                                crossAxisSpacing: 16,
                                childAspectRatio: 2.2,
                              ),
                              itemCount: movies.length,
                              itemBuilder: (context, index) {
                                return _MovieCard(
                                  movie: movies[index],
                                  isWide: true,
                                );
                              },
                            );
                          } else {
                            // Single column ListView for phones
                            return ListView.separated(
                              itemCount: movies.length,
                              separatorBuilder: (_, __) =>
                                  const SizedBox(height: 12),
                              itemBuilder: (context, index) {
                                return _MovieCard(
                                  movie: movies[index],
                                  isWide: false,
                                );
                              },
                            );
                          }
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Movie Card Widget ──
class _MovieCard extends StatelessWidget {
  final Movie movie;
  final bool isWide;

  const _MovieCard({required this.movie, required this.isWide});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Adjust poster size based on available width
        final posterWidth = isWide
            ? constraints.maxWidth * 0.35
            : 90.0;
        final posterHeight = isWide ? 140.0 : 120.0;

        return Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: Colors.grey.withOpacity(0.1)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.04),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Poster
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  movie.posterUrl,
                  width: posterWidth,
                  height: posterHeight,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(
                    width: posterWidth,
                    height: posterHeight,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(Icons.movie, size: 40, color: Colors.grey),
                  ),
                ),
              ),
              const SizedBox(width: 14),
              // Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      movie.title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2C2C34),
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Year: ${movie.year}',
                      style: const TextStyle(
                          fontSize: 13, color: Colors.black54),
                    ),
                    const SizedBox(height: 6),
                    // Rating stars
                    Row(
                      children: [
                        const Icon(Icons.star, size: 16, color: Colors.amber),
                        const SizedBox(width: 4),
                        Text(
                          '${movie.rating}',
                          style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: Colors.black87),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    // Genre chips
                    Wrap(
                      spacing: 6,
                      runSpacing: 4,
                      children: movie.genres.map((g) {
                        return Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF0EFFA),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            g,
                            style: const TextStyle(
                                fontSize: 11, color: Colors.indigo),
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
