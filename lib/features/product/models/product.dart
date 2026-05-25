class Product {
  Product({
    this.id,
    required String name,
    required String description,
    required this.price,
    this.categoryId,
    this.storeId,
  }) : name = name.trim().toUpperCase(),
       description = description.trim() {
    if (this.name.isEmpty) {
      throw ArgumentError('O nome e Obrigatorio');
    }
    if (price <= 0) {
      throw ArgumentError('O preço deve ser maior que zero');
    }
  }

  final int? id;
  final String name;
  final String description;
  final double price;
  final int? categoryId;
  final int? storeId;

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'] as int,
      name: map['name'] as String,
      description: map['description'] as String? ?? '',
      price: (map['price'] as num).toDouble(),
      categoryId: map['categoryId'] as int?,
      storeId: map['storeId'] as int?,
    );
  }

  Map<String, dynamic> toMap({incluirID = false}) {
    return {
      if (incluirID && id != null) 'id': id,
      'name': name,
      'description': description,
      'price': price,
      'categoryId': categoryId,
      'storeId': storeId,
    };
  }
}
