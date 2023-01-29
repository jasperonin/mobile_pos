import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class Category extends Equatable {
  final String name;
  final String imageUrl;

  const Category({
    required this.name,
    required this.imageUrl,
  });

  @override
  List<Object?> get props => [
        name,
        imageUrl,
      ];

  static Category fromSnapshot(DocumentSnapshot snap) {
    Category category = Category(
      name: snap['name'],
      imageUrl: snap['imageUrl'],
    );
    return category;
  }

  static List<Category> categories = [

    Category(
      name: 'Smoothies',
      imageUrl:
          'https://n2.sdlcdn.com/imgs/b/c/g/Adidas-Gray-Sport-Shoes-SDL384296450-1-db03a.jpg',//https://n2.sdlcdn.com/imgs/b/c/g/Adidas-Gray-Sport-Shoes-SDL384296450-1-db03a
    ),

  ];
}
