import 'package:flutter/foundation.dart';
import '../../domain/entities/product.dart';
import '../../domain/usecases/get_products.dart';

enum ProductState { initial, loading, loaded, error }

class ProductProvider with ChangeNotifier {
  final GetProducts getProducts;

  ProductProvider({required this.getProducts});

  ProductState state = ProductState.initial;
  List<Product> products = [];
  String errorMessage = '';
  String searchQuery = '';
  String selectedCategory = 'All';

  List<Product> get filteredProducts {
    var result = products;
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

  Future<void> fetchProducts() async {
    state = ProductState.loading;
    notifyListeners();

    try {
      products = await getProducts();
      state = ProductState.loaded;
    } catch (e) {
      state = ProductState.error;
      errorMessage = e.toString();
    }
    notifyListeners();
  }
}
