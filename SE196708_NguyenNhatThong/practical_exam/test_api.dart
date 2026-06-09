import 'dart:convert';
import 'package:http/http.dart' as http;

class Product {
  final int id;
  final String title;
  final double price;
  final double rating;
  final String thumbnail;
  final int stock;

  Product({
    required this.id,
    required this.title,
    required this.price,
    required this.rating,
    required this.thumbnail,
    required this.stock,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      title: json['title'],
      price: (json['price'] as num).toDouble(),
      rating: (json['rating'] as num).toDouble(),
      thumbnail: json['thumbnail'],
      stock: json['stock'] as int,
    );
  }
}

void main() async {
  try {
    final url = Uri.parse('https://dummyjson.com/products/category/smartphones');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List productsJson = data['products'];
      final products = productsJson.map((e) => Product.fromJson(e)).toList();
      print('Success: \${products.length} products');
    } else {
      print('Error status: \${response.statusCode}');
    }
  } catch (e) {
    print('Exception: \$e');
  }
}
