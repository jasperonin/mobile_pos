import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'product_model.g.dart';

@HiveType(typeId: 0)
class Product extends Equatable {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final String category;
  @HiveField(3)
  final String imageUrl;
  @HiveField(4)
  final double price;
  @HiveField(5)
  final bool isRecommended;
  @HiveField(6)
  final bool isPopular;
  @HiveField(7)
  final String? description;

  static var products;

  const Product({
    required this.id,
    required this.name,
    required this.category,
    required this.imageUrl,
    required this.price,
    required this.isRecommended,
    required this.isPopular,
    this.description,
  });

  static Product fromSnapshot(DocumentSnapshot snap) {
    Product product = Product(
      id: snap['id'],
      name: snap['name'],
      category: snap['category'],
      imageUrl: snap['imageUrl'],
      price: snap['price'],
      isRecommended: snap['isRecommended'],
      isPopular: snap['isPopular'],
      description: snap['description'],
    );
    return product;
  }

  @override
  List<Object?> get props => [
        id,
        name,
        category,
        imageUrl,
        price,
        isRecommended,
        isPopular,
        description,
      ];


}
