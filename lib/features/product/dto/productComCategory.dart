class ProductWithCategory {
  final int id;
  final String name;
  final String description;
  final double price;
  final String imageUrl;
  final int categoryId;
  final String categoryName;

  ProductWithCategory({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.categoryId,
    required this.categoryName,
  });

  factory ProductWithCategory.fromMap(Map<String, dynamic> map) {
    return ProductWithCategory(
      id: map['id'] as int,
      name: map['name'] as String,
      description: map['description'] as String,
      price: map['price'].toDouble(),
      imageUrl: map['imageUrl'] as String,
      categoryId: map['categoryId'] as int,
      categoryName: map['categoryName'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'imageUrl': imageUrl,
      'categoryId': categoryId,
      'categoryName': categoryName,
    };
  }
}
