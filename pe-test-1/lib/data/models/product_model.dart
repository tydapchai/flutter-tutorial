import '../../domain/entities/product.dart';

class ProductModel extends Product {
  const ProductModel({
    required super.id,
    required super.title,
    required super.description,
    required super.price,
    required super.rating,
    required super.thumbnail,
    required super.images,
    required super.reviews,
    required super.category,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      price: (json['price'] as num).toDouble(),
      rating: (json['rating'] as num).toDouble(),
      thumbnail: json['thumbnail'],
      images: List<String>.from(json['images'] ?? []),
      category: json['category'] ?? 'Other',
      reviews: (json['reviews'] as List?)?.map((r) => Review(
        rating: r['rating'] ?? 5,
        comment: r['comment'] ?? '',
        reviewerName: r['reviewerName'] ?? 'Anonymous',
      )).toList() ?? [],
    );
  }
}
