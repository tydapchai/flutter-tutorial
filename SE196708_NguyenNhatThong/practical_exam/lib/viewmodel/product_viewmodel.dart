import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../model/product.dart';
import '../repository/product_repository.dart';

enum ViewState { loading, success, error, empty }

class ProductViewModel extends ChangeNotifier {
  final ProductRepository _repository = ProductRepository();
  
  ViewState _state = ViewState.loading;
  ViewState get state => _state;

  List<Product> _allProducts = []; // Store all fetched products
  List<Product> _filteredProducts = []; // Products to display
  List<Product> get products => _filteredProducts;

  String _errorMessage = '';
  String get errorMessage => _errorMessage;

  bool _showStockWarnings = true;
  bool get showStockWarnings => _showStockWarnings;

  bool _filterInStockOnly = true;
  bool get filterInStockOnly => _filterInStockOnly;

  Timer? _debounce;
  String _searchQuery = '';

  ProductViewModel() {
    Future.microtask(() => fetchProducts());
  }

  void toggleStockWarnings() {
    _showStockWarnings = !_showStockWarnings;
    notifyListeners();
  }

  void setInStockFilter(bool value) {
    _filterInStockOnly = value;
    _applyFilters();
  }

  void searchProducts(String query) {
    debugPrint('⌨️ [TYPING] Người dùng vừa gõ: "\$query"');
    if (_debounce?.isActive ?? false) {
      debugPrint('⏳ [CANCEL] Hủy lệnh lọc cũ vì người dùng gõ phím mới...');
      _debounce!.cancel();
    }
    
    _debounce = Timer(const Duration(milliseconds: 500), () {
      debugPrint('✅ [DEBOUNCE SUCCESS] Đã chờ đủ 500ms. Tiến hành lọc dữ liệu cho: "\$query"');
      _searchQuery = query;
      _applyFilters();
    });
  }

  void _applyFilters() {
    // CR #1: Display only products that are in stock
    // CR #4, #5: Search filtering
    _filteredProducts = _allProducts.where((p) {
      final inStock = !_filterInStockOnly || p.stock > 0;
      final matchesSearch = p.title.toLowerCase().contains(_searchQuery.toLowerCase());
      return inStock && matchesSearch;
    }).toList();

    if (_filteredProducts.isEmpty && _state != ViewState.error) {
      _state = ViewState.empty;
    } else if (_state != ViewState.error) {
      _state = ViewState.success;
    }
    notifyListeners();
  }

  Future<void> fetchProducts() async {
    _state = ViewState.loading;
    notifyListeners();

    try {
      _allProducts = await _repository.fetchSmartphones();
      _applyFilters(); // This will update state to success or empty
    } catch (e) {
      _errorMessage = e.toString();
      _state = ViewState.error;
      notifyListeners();
    }
  }
}
