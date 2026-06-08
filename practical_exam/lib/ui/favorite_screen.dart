import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodel/favorite_viewmodel.dart';
import '../model/product.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9FF),
      appBar: AppBar(
        title: const Text('Favorites', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        backgroundColor: const Color(0xFFF9F9FF).withValues(alpha: 0.8),
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Color(0xFF004AC6)),
            onPressed: () {},
          ),
        ],
      ),
      body: Consumer<FavoriteViewModel>(
        builder: (context, viewModel, child) {
          final favorites = viewModel.favorites;

          if (favorites.isEmpty) {
            return _buildEmptyState();
          }

          return _buildGrid(favorites);
        },
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 160,
              height: 160,
              decoration: const BoxDecoration(
                color: Color(0xFFE7EEFF),
                shape: BoxShape.circle,
              ),
              child: const Center(
                child: Icon(Icons.shopping_bag_outlined, size: 80, color: Color(0xFF004AC6)),
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Chưa có sản phẩm yêu thích',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF111C2D),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            const Text(
              'Hãy bắt đầu khám phá và lưu lại những món đồ tuyệt vời mà bạn yêu thích nhé!',
              style: TextStyle(
                fontSize: 14,
                color: Color(0xFF434655),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF2563EB),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text('Tiếp tục mua sắm', style: TextStyle(fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGrid(List<Product> favorites) {
    return RefreshIndicator(
      onRefresh: () async {},
      child: GridView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.55,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
        ),
        itemCount: favorites.length,
        itemBuilder: (context, index) {
          final product = favorites[index];
          return _buildFavoriteCard(context, product);
        },
      ),
    );
  }

  Widget _buildFavoriteCard(BuildContext context, Product product) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFC3C6D7).withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image Box
          AspectRatio(
            aspectRatio: 1,
            child: Stack(
              children: [
                Container(
                  decoration: const BoxDecoration(
                    color: Color(0xFFF0F3FF),
                    borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                  ),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                    child: Image.network(
                      product.thumbnail,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => const Icon(Icons.broken_image, color: Colors.grey),
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Container(color: const Color(0xFFF0F3FF));
                      },
                    ),
                  ),
                ),
                // Remove Favorite Button (Top Right)
                Positioned(
                  top: 8,
                  right: 8,
                  child: Consumer<FavoriteViewModel>(
                    builder: (context, favoriteVM, child) {
                      return GestureDetector(
                        onTap: () {
                          favoriteVM.toggleFavorite(product);
                        },
                        child: Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.9),
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.1),
                                blurRadius: 4,
                                offset: const Offset(0, 2),
                              )
                            ],
                          ),
                          child: const Icon(
                            Icons.favorite,
                            size: 20,
                            color: Color(0xFFAB0B1C),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          // Info Box
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Smartphone',
                  style: TextStyle(
                    color: Color(0xFF004AC6),
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                Text(
                  product.title,
                  style: const TextStyle(
                    color: Color(0xFF111C2D),
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(Icons.star, color: Colors.amber, size: 14),
                    const SizedBox(width: 4),
                    Text(
                      '\${product.rating}',
                      style: const TextStyle(color: Color(0xFF434655), fontSize: 12),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  '\$\${product.price}',
                  style: const TextStyle(
                    color: Color(0xFF004AC6),
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
