import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/product.dart';

class ProductRepository {
  Future<List<Product>> fetchSmartphones() async {
    final url = Uri.parse('https://dummyjson.com/products/category/smartphones');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List productsJson = data['products'];
      return productsJson.map((e) => Product.fromJson(e)).toList();
    } else {
      throw Exception('Lỗi kết nối tới máy chủ');
    }
  }
}
