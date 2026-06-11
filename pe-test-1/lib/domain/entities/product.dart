class Review {
  final int rating;
  final String comment;
  final String reviewerName;

  const Review({
    required this.rating,
    required this.comment,
    required this.reviewerName,
  });
}

class Product {
  final int id;
  final String title;
  final String description;
  final double price;
  final double rating;
  final String thumbnail;
  final List<String> images;
  final List<Review> reviews;
  final String category;

  const Product({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.rating,
    required this.thumbnail,
    required this.images,
    this.reviews = const [],
    this.category = 'Other',
  });
}
