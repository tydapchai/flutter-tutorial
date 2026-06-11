import 'package:flutter/foundation.dart';
import '../../domain/entities/product.dart';

class FavoriteProvider with ChangeNotifier {
  final List<Product> _favorites = [];
  String searchQuery = '';
  String selectedCategory = 'All';

  List<Product> get favorites {
    var result = _favorites;
    if (selectedCategory != 'All') {
      result = result.where((p) => 
        p.category.toLowerCase().contains(selectedCategory.toLowerCase()) ||
        p.title.toLowerCase().contains(selectedCategory.toLowerCase()) ||
        p.description.toLowerCase().contains(selectedCategory.toLowerCase())
      ).toList();
    }
    if (searchQuery.isNotEmpty) {
      result = result.where((p) => p.title.toLowerCase().contains(searchQuery.toLowerCase())).toList();
    }
    return result;
  }

  void setCategory(String category) {
    selectedCategory = category;
    notifyListeners();
  }

  void setSearchQuery(String query) {
    searchQuery = query;
    notifyListeners();
  }

  bool isFavorite(Product product) {
    return _favorites.any((p) => p.id == product.id);
  }

  void toggleFavorite(Product product) {
    if (isFavorite(product)) {
      _favorites.removeWhere((p) => p.id == product.id);
    } else {
      _favorites.add(product);
    }
    notifyListeners();
  }
}
