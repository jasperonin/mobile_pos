import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class Products extends Equatable {
  int id;
  final String name;
  final String category;
  final String description;
  final String imageUrl;
  final bool isRecommended;
  final bool isPopular;
  double price;
  int quantity;

  Products({
    this.id = 0,
    required this.name,
    required this.category,
    required this.description,
    required this.imageUrl,
    required this.isRecommended,
    required this.isPopular,
    this.price = 0,
    this.quantity = 0,
  });

  @override
  List<Object?> get props {
    return [
      id,
      name,
      category,
      description,
      imageUrl,
      isRecommended,
      isPopular,
      price,
      quantity,
    ];
  }

  Products copyWith({
    int? id,
    String? name,
    String? category,
    String? description,
    String? imageUrl,
    bool? isRecommended,
    bool? isPopular,
    double? price,
    int? quantity,
  }) {
    return Products(
      id: id ?? this.id,
      name: name ?? this.name,
      category: category ?? this.category,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
      isRecommended: isRecommended ?? this.isRecommended,
      isPopular: isPopular ?? this.isPopular,
      price: price ?? this.price,
      quantity: quantity ?? this.quantity,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'category': category,
      'description': description,
      'imageUrl': imageUrl,
      'isRecommended': isRecommended,
      'isPopular': isPopular,
      'price': price,
      'quantity': quantity,
    };
  }

  factory Products.fromSnapshot(DocumentSnapshot snap) {
    return Products(
      id: snap['id'],
      name: snap['name'],
      description: snap['description'],
      category: snap['category'],
      imageUrl: snap['imageUrl'],
      isRecommended: snap['isRecommended'],
      isPopular: snap['isPopular'],
      price: snap['price'],
      quantity: snap['quantity'],
    );
  }

  String toJson() => json.encode(toMap());

  @override
  bool get stringify => true;

}