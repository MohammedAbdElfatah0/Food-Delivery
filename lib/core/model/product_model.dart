import 'package:food_delivery/core/service/firestore_model.dart';

class ProductModel implements FirestoreModel {
  @override
  final String id;
  final String name;
  final String description;
  final String price;
  final String category;
  final String? imageUrl;

  ProductModel({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.category,
    this.imageUrl,
  });

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'category': category,
      'imageUrl': imageUrl ?? "",
    };
  }
}
