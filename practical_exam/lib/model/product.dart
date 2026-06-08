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
