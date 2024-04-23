import 'dart:convert';

import 'package:interior_design_arapp/models/rating.module.dart';

class Product {
  final String threeName;
  final String name;
  final String description;
  final List<String> images;
  final double price;
  final double quantity;
  final String category;
  final String? id;
  final List<Rating>? rating;

  Product({
    required this.threeName,
    required this.name,
    required this.description,
    required this.images,
    required this.price,
    required this.quantity,
    required this.category,
    this.id,
    this.rating,
  });

  Map<String, dynamic> toMap() {
    return {
      'threeName': threeName,
      'name': name,
      'description': description,
      'images': images,
      'price': price,
      'quantity': quantity,
      'category': category,
      'id': id,
      'rating': rating,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      threeName: map['threeName'] as String,
      name: map['name'] as String,
      description: map['description'] as String,
      images: List<String>.from(map['images'] as List<dynamic>),
      price: (map['price'] as num)
          .toDouble(), // Handle conversion from int to double
      quantity: (map['quantity'] as num)
          .toDouble(), // Handle conversion from int to double
      category: map['category'] as String,
      id: map['_id'] as String?,
      rating: map['rating'] != null
          ? List<Rating>.from(
              map['rating']?.map(
                (x) => Rating.fromMap(x),
              ),
            )
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Product.fromJson(String source) =>
      Product.fromMap(json.decode(source) as Map<String, dynamic>);
}
