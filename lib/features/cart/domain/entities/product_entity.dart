class ProductEntity {
  final int id;
  final String image;
  final String name;
  final double price;
  int quantity;

  ProductEntity({
    required this.id,
    required this.name,
    required this.price,
    required this.image,
    this.quantity = 1,
  });

  ProductEntity copyWith({
    int? id,
    String? image,
    String? name,
    double? price,
    int? quantity,
  }) {
    return ProductEntity(
      id: id ?? this.id,
      image: image ?? this.image,
      name: name ?? this.name,
      price: price ?? this.price,
      quantity: quantity ?? this.quantity,
    );
  }
}