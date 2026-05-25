import 'package:shoplocal/features/product/models/tag.dart';

class Product {
  Product({
    this.id,
    required name,
    description,
    required this.price,
    this.categoryId,
  }) : name = name.trim().toUpperCase(),
       description = description?.trim() {
    if (this.name.isEmpty) {
      throw ArgumentError('O nome e Obrigatorio');
    }
    if (price <= 0) {
      throw ArgumentError('O preço deve ser maior que zero');
    }
  }

  final int? id;
  final String name;
  final String? description;
  final double price;
  final int? categoryId;

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'] as int,
      name: map['name'] as String,
      description: map['description'] as String?,
      price: map['price'] as double,
      categoryId: map['categoryId'] as int?,
    );
  }

  Map<String, dynamic> toMap({incluirID = false}) {
    return {
      if (incluirID && id != null) 'id': id,
      'name': name,
      'description': description,
      'price': price,
      'categoryId': categoryId,
    };
  }
}
