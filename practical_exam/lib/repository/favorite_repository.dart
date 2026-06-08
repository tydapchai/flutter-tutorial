import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/product.dart';

class FavoriteRepository {
  static const String _storageKey = 'favorite_products';

  Future<List<Product>> loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_storageKey);
    if (jsonString != null) {
      final List<dynamic> jsonList = jsonDecode(jsonString);
      return jsonList.map((json) => Product.fromJson(json)).toList();
    }
    return [];
  }

  Future<void> saveFavorites(List<Product> favorites) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = jsonEncode(favorites.map((p) => p.toJson()).toList());
    await prefs.setString(_storageKey, jsonString);
  }
}
