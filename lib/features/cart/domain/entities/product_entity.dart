class ProductEntity {
  final int id;
  final String title;
  final double price;
  final String description;
  final String urlImage;
  final String category; //enum
  final List<String> avgCookingTime;
  final bool isDelivered;
  final String priceDelivery;
  final double avgRating;
  final int ratingCount;

  ProductEntity({
    required this.id,
    required this.title,
    required this.price,
    required this.urlImage,
    required this.description,
    required this.category,
    required this.avgCookingTime,
    required this.isDelivered,
    required this.priceDelivery,
    required this.avgRating,
    required this.ratingCount,
  });

  //get product

  factory ProductEntity.fromMap(Map<String, dynamic> map) {
    return ProductEntity(
      id: map['id'] ?? 0,
      title: map['title'] ?? '',
      price: (map['price'] ?? 0.0).toDouble(),
      urlImage: map['urlImage'] ?? '',
      description: map['description'] ?? '',
      category: map['category'] ?? '',
      avgCookingTime: List<String>.from(map['avgCookingTime'] ?? []),
      isDelivered: map['isDelivered'] ?? false,
      priceDelivery: map['priceDelivery'] ?? '',
      avgRating: (map['avgRating'] ?? 0.0).toDouble(),
      ratingCount: map['ratingCount'] ?? 0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'price': price,
      'urlImage': urlImage,
      'description': description,
      'category': category,
      'avgCookingTime': avgCookingTime,
      'isDelivered': isDelivered,
      'priceDelivery': priceDelivery,
      'avgRating': avgRating,
      'ratingCount': ratingCount,
    };
  }
}