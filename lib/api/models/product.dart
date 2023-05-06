import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'product.g.dart';

@JsonSerializable()
class Product extends Equatable {
  final int id;
  final String title;
  final double price;
  final String category;
  final String description;
  final String image;

  const Product(
      {required this.category,
      required this.title,
      required this.price,
      required this.description,
      required this.image,
      required this.id});

  Product copyWith(
      {int? id,
      String? title,
      double? price,
      String? category,
      String? description,
      String? image}) {
    return Product(
        category: category ?? this.category,
        title: title ?? this.title,
        price: price ?? this.price,
        description: description ?? this.description,
        image: image ?? this.image,
        id: id ?? this.id);
  }

  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);

  Map<String, dynamic> toJson() => _$ProductToJson(this);

  @override
  List<Object?> get props => [id, title, price, category, description, image];
}
