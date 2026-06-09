import 'package:flutter/material.dart';
import '../model/product.dart';
import '../repository/favorite_repository.dart';

class FavoriteViewModel extends ChangeNotifier {
  final FavoriteRepository _repository;
  List<Product> _favorites = [];

  FavoriteViewModel(this._repository) {
    _loadFavorites();
  }

  List<Product> get favorites => _favorites;

  Future<void> _loadFavorites() async {
    _favorites = await _repository.loadFavorites();
    notifyListeners();
  }

  bool isFavorite(int productId) {
    return _favorites.any((p) => p.id == productId);
  }

  Future<void> toggleFavorite(Product product) async {
    final isExist = _favorites.any((p) => p.id == product.id);
    if (isExist) {
      _favorites.removeWhere((p) => p.id == product.id);
    } else {
      _favorites.add(product);
    }
    notifyListeners();
    await _repository.saveFavorites(_favorites);
  }
}
