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
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: 250,
                  height: 250,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: const Color(0xFFE7EEFF).withValues(alpha: 0.5),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFFE7EEFF).withValues(alpha: 0.5),
                        blurRadius: 50,
                        spreadRadius: 20,
                      )
                    ],
                  ),
                ),
                Image.network(
                  'https://lh3.googleusercontent.com/aida-public/AB6AXuDlTTmpPw1nSdIB617uHHByOGb3ffhcotcF2ZK02raGAhBIDwJPVCuVokqfNfWHbsoesZs3jSGRreiRg1RKr-iPK5A3J6h3TSb1fCIAc_0qSNwNN6yjrIoIMMGepVOerMpXMUwATnkcPBrv9j49ARLydRzG6S1ZefSnRZ3HOTTNwksNZWnvc0RNsNN8xo8iC_P9jpJyCkSBDbXZ77pfm6VGkFxqorhYA_6UWAIwkv80iuuNwgU6Fnh8YOyLJFwXhG5z3y4DrkCd',
                  width: 256,
                  height: 256,
                  fit: BoxFit.contain,
                ),
              ],
            ),
            const SizedBox(height: 32),
            const Text(
              'Chưa có sản phẩm yêu thích',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w700,
                color: Color(0xFF111C2D),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            const Text(
              'Hãy bắt đầu khám phá và lưu lại những món đồ tuyệt vời mà bạn yêu thích nhất.',
              style: TextStyle(
                fontSize: 16,
                color: Color(0xFF434655),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.shopping_bag, color: Colors.white),
                label: const Text('Tiếp tục mua sắm', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF004AC6),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 2,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGrid(List<Product> favorites) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${favorites.length} sản phẩm đã lưu',
                style: const TextStyle(
                  fontSize: 12,
                  color: Color(0xFF434655),
                ),
              ),
              InkWell(
                onTap: () {},
                child: const Row(
                  children: [
                    Icon(Icons.filter_list, size: 16, color: Color(0xFF004AC6)),
                    SizedBox(width: 4),
                    Text(
                      'Lọc',
                      style: TextStyle(
                        fontSize: 12,
                        color: Color(0xFF004AC6),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: RefreshIndicator(
            onRefresh: () async {},
            child: LayoutBuilder(
              builder: (context, constraints) {
                int crossAxisCount = 2;
                if (constraints.maxWidth > 1200) {
                  crossAxisCount = 5;
                } else if (constraints.maxWidth > 800) {
                  crossAxisCount = 4;
                } else if (constraints.maxWidth > 600) {
                  crossAxisCount = 3;
                }
                
                return GridView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: crossAxisCount,
                    childAspectRatio: 0.55,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                  ),
                  itemCount: favorites.length,
                  itemBuilder: (context, index) {
                    final product = favorites[index];
                    return _buildFavoriteCard(context, product);
                  },
                );
              }
            ),
          ),
        ),
      ],
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
                      '${product.rating}',
                      style: const TextStyle(color: Color(0xFF434655), fontSize: 12),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  '\$${product.price}',
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
