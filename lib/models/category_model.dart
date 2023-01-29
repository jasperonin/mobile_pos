import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

import '../user_models/category_model.dart';

class Categories extends Equatable {

  final String name;
  final String imageUrl;

  Categories({
    required this.name,
    required this.imageUrl,
  });

  @override
  List<Object?> get props {
    return [
      name,
      imageUrl,
    ];
  }

  Categories copyWith({
    String? name,
    String? imageUrl,
  }) {
    return Categories(
      name: name ?? this.name,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'imageUrl': imageUrl,
    };
  }

  factory Categories.fromSnapshot(DocumentSnapshot snap) {
    return Categories(
      name: snap['name'],
      imageUrl: snap['imageUrl'],
    );
  }

  String toJson() => json.encode(toMap());

  @override
  bool get stringify => true;

}