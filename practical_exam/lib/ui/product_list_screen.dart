import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import '../viewmodel/product_viewmodel.dart';
import '../viewmodel/favorite_viewmodel.dart';
import '../model/product.dart';

class ProductListScreen extends StatelessWidget {
  const ProductListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9FF),
      appBar: AppBar(
        backgroundColor: Colors.white.withOpacity(0.9),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF004AC6)),
          onPressed: () {},
        ),
        title: const Text(
          'Tìm kiếm',
          style: TextStyle(color: Color(0xFF111C2D), fontWeight: FontWeight.bold, fontSize: 18),
        ),
        centerTitle: true,
        actions: [
          Consumer<ProductViewModel>(
            builder: (context, viewModel, child) {
              return Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('Warnings', style: TextStyle(color: Colors.grey, fontSize: 12)),
                  Switch(
                    value: viewModel.showStockWarnings,
                    onChanged: (value) => viewModel.toggleStockWarnings(),
                    activeColor: const Color(0xFF004AC6),
                  ),
                ],
              );
            },
          )
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Search Input
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Tìm sản phẩm, thương hiệu...',
                hintStyle: const TextStyle(color: Color(0xFF737686)),
                prefixIcon: const Icon(Icons.search, color: Color(0xFF737686)),
                filled: true,
                fillColor: const Color(0xFFF0F3FF),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Color(0xFFC3C6D7), width: 0.5),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Color(0xFFC3C6D7), width: 0.5),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Color(0xFF004AC6), width: 2),
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 16),
              ),
              onChanged: (query) {
                context.read<ProductViewModel>().searchProducts(query);
              },
            ),
          ),

          // Filter Chips (Demo CR #1)
          Consumer<ProductViewModel>(
            builder: (context, viewModel, child) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  children: [
                    ChoiceChip(
                      label: const Text('Tất cả'),
                      selected: !viewModel.filterInStockOnly,
                      onSelected: (selected) {
                        if (selected) viewModel.setInStockFilter(false);
                      },
                      selectedColor: const Color(0xFFE7EEFF),
                      labelStyle: TextStyle(
                        color: !viewModel.filterInStockOnly ? const Color(0xFF004AC6) : const Color(0xFF737686),
                        fontWeight: !viewModel.filterInStockOnly ? FontWeight.bold : FontWeight.normal,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                        side: BorderSide(
                          color: !viewModel.filterInStockOnly ? const Color(0xFF004AC6) : const Color(0xFFC3C6D7),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    ChoiceChip(
                      label: const Text('Chỉ còn hàng'),
                      selected: viewModel.filterInStockOnly,
                      onSelected: (selected) {
                        if (selected) viewModel.setInStockFilter(true);
                      },
                      selectedColor: const Color(0xFFE7EEFF),
                      labelStyle: TextStyle(
                        color: viewModel.filterInStockOnly ? const Color(0xFF004AC6) : const Color(0xFF737686),
                        fontWeight: viewModel.filterInStockOnly ? FontWeight.bold : FontWeight.normal,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                        side: BorderSide(
                          color: viewModel.filterInStockOnly ? const Color(0xFF004AC6) : const Color(0xFFC3C6D7),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          
          // Results Header
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Consumer<ProductViewModel>(
              builder: (context, viewModel, child) {
                if (viewModel.state == ViewState.loading) return const SizedBox.shrink();
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Gợi ý cho bạn', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Color(0xFF111C2D))),
                    Text('${viewModel.products.length} kết quả', style: const TextStyle(color: Color(0xFF737686), fontSize: 12)),
                  ],
                );
              },
            ),
          ),

          Expanded(
            child: Consumer<ProductViewModel>(
              builder: (context, viewModel, child) {
                switch (viewModel.state) {
                  case ViewState.loading:
                    return _buildSkeletonGrid();
                  case ViewState.error:
                    return _buildErrorState(viewModel);
                  case ViewState.empty:
                    return _buildEmptyState();
                  case ViewState.success:
                      return RefreshIndicator(
                        onRefresh: () async {
                          await viewModel.fetchProducts();
                        },
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
                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: crossAxisCount,
                                childAspectRatio: 0.55,
                                crossAxisSpacing: 16,
                                mainAxisSpacing: 16,
                              ),
                              itemCount: viewModel.products.length,
                              itemBuilder: (context, index) {
                                return _buildProductCard(viewModel.products[index], viewModel.showStockWarnings);
                              },
                            );
                          }
                        ),
                      );
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductCard(Product product, bool showStockWarnings) {
    final isLowStock = product.stock < 10;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFC3C6D7).withOpacity(0.5)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image Area
          Stack(
            children: [
              AspectRatio(
                aspectRatio: 1,
                child: Container(
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
              ),
              // Favorite Button (Top Right)
              Positioned(
                top: 8,
                right: 8,
                child: Consumer<FavoriteViewModel>(
                  builder: (context, favoriteVM, child) {
                    final isFav = favoriteVM.isFavorite(product.id);
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
                        child: Icon(
                          isFav ? Icons.favorite : Icons.favorite_border,
                          size: 20,
                          color: isFav ? const Color(0xFFAB0B1C) : const Color(0xFF737686),
                        ),
                      ),
                    );
                  },
                ),
              ),
              // Warning Badge (Top Left)
              if (showStockWarnings && isLowStock)
                Positioned(
                  top: 8,
                  left: 8,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                    decoration: BoxDecoration(
                      color: const Color(0xFFAB0B1C),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      'ONLY ${product.stock}',
                      style: const TextStyle(color: Colors.white, fontSize: 9, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
            ],
          ),
          
          // Details Area
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'SMARTPHONE',
                    style: TextStyle(color: const Color(0xFF737686).withOpacity(0.8), fontSize: 10, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    product.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(color: Color(0xFF111C2D), fontSize: 14, fontWeight: FontWeight.w600),
                  ),
                  const Spacer(),
                  // Rating
                  Row(
                    children: [
                      const Icon(Icons.star, color: Colors.amber, size: 14),
                      const SizedBox(width: 4),
                      Text(
                        product.rating.toString(),
                        style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '(124)',
                        style: TextStyle(fontSize: 12, color: const Color(0xFF737686).withOpacity(0.8)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  // Price and Add button
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '\$${product.price}',
                        style: const TextStyle(color: Color(0xFF004AC6), fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: const Color(0xFF2563EB),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(Icons.shopping_bag_outlined, size: 16, color: Colors.white),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSkeletonGrid() {
    return GridView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.55,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemCount: 6,
      itemBuilder: (context, index) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const Color(0xFFC3C6D7).withOpacity(0.5)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AspectRatio(
                aspectRatio: 1,
                child: Shimmer.fromColors(
                  baseColor: Colors.grey[200]!,
                  highlightColor: Colors.grey[100]!,
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Shimmer.fromColors(
                        baseColor: Colors.grey[200]!,
                        highlightColor: Colors.grey[100]!,
                        child: Container(width: 60, height: 10, color: Colors.white),
                      ),
                      const SizedBox(height: 8),
                      Shimmer.fromColors(
                        baseColor: Colors.grey[200]!,
                        highlightColor: Colors.grey[100]!,
                        child: Container(width: double.infinity, height: 14, color: Colors.white),
                      ),
                      const SizedBox(height: 4),
                      Shimmer.fromColors(
                        baseColor: Colors.grey[200]!,
                        highlightColor: Colors.grey[100]!,
                        child: Container(width: 80, height: 14, color: Colors.white),
                      ),
                      const Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Shimmer.fromColors(
                            baseColor: Colors.grey[200]!,
                            highlightColor: Colors.grey[100]!,
                            child: Container(width: 60, height: 16, color: Colors.white),
                          ),
                          Shimmer.fromColors(
                            baseColor: Colors.grey[200]!,
                            highlightColor: Colors.grey[100]!,
                            child: Container(width: 28, height: 28, decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8))),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildErrorState(ProductViewModel viewModel) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 120,
            height: 120,
            decoration: const BoxDecoration(
              color: Color(0xFFFFDAD6),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.cloud_off, size: 64, color: Color(0xFFBA1A1A)),
          ),
          const SizedBox(height: 24),
          const Text('Có lỗi xảy ra', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF111C2D))),
          const SizedBox(height: 8),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 32.0),
            child: Text(
              'Kết nối không ổn định hoặc hệ thống đang gặp sự cố. Vui lòng kiểm tra lại.',
              textAlign: TextAlign.center,
              style: TextStyle(color: Color(0xFF434655)),
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF004AC6),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            onPressed: () => viewModel.fetchProducts(),
            icon: const Icon(Icons.refresh),
            label: const Text('Thử lại', style: TextStyle(fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
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
            child: const Icon(Icons.shopping_bag_outlined, size: 80, color: Color(0xFF004AC6)),
          ),
          const SizedBox(height: 24),
          const Text('Chưa có sản phẩm', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF111C2D))),
          const SizedBox(height: 8),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 32.0),
            child: Text(
              'Không tìm thấy sản phẩm nào phù hợp với yêu cầu của bạn.',
              textAlign: TextAlign.center,
              style: TextStyle(color: Color(0xFF434655)),
            ),
          ),
        ],
      ),
    );
  }
}
