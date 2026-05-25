import 'package:flutter/material.dart';

class ProductAttribute {
  const ProductAttribute({
    required this.title,
    required this.value,
    required this.icon,
  });

  final String title;
  final String value;
  final IconData icon;
}

class Product {
  const Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    this.oldPrice,
    required this.image,
    required this.category,
    required this.rating,
    required this.deliveryInfo,
    required this.attributes,
  });

  final String id;
  final String name;
  final String description;
  final double price;
  final double? oldPrice;
  final String image;
  final String category;
  final double rating;
  final String deliveryInfo;
  final List<ProductAttribute> attributes;
}

class ProductMocks {
  static const Product pizza = Product(
    id: 'food-pizza-margherita',
    name: 'Pizza Margherita',
    description: 'Molho de tomate, mussarela e manjericao fresco.',
    price: 39.90,
    oldPrice: 44.90,
    image: 'assets/img/temp/padaria.png',
    category: 'Comida',
    rating: 4.8,
    deliveryInfo: 'Entrega estimada: 25-35 min',
    attributes: [
      ProductAttribute(
        title: 'Tamanho',
        value: 'Grande',
        icon: Icons.local_pizza_outlined,
      ),
      ProductAttribute(
        title: 'Massa',
        value: 'Tradicional',
        icon: Icons.bakery_dining_outlined,
      ),
    ],
  );

  static const Product Luminaria = Product(
    id: 'decor-lamp-arc-modern',
    name: 'Luminaria Arco Moderna',
    description:
        'Luminaria premium em metal escovado com cupula de tecido. Ideal para sala de estar e ambientes de leitura.',
    price: 289.90,
    oldPrice: 349.90,
    image: 'assets/img/temp/padaria.png',
    category: 'Decoracao',
    rating: 4.9,
    deliveryInfo: 'Entrega estimada: 30-45 min',
    attributes: [
      ProductAttribute(
        title: 'Resistencia',
        value: 'Alto impacto',
        icon: Icons.shield_outlined,
      ),
      ProductAttribute(
        title: 'Garantia',
        value: '12 meses',
        icon: Icons.verified_outlined,
      ),
    ],
  );

  static const Product headphone = Product(
    id: 'electronics-headphone-anc',
    name: 'Headphone ANC Pro',
    description:
        'Cancelamento de ruido ativo, bateria de longa duracao e conectividade Bluetooth 5.3.',
    price: 599.90,
    image: 'https://images.unsplash.com/photo-1505740420928-5e560c06d30e?w=900',
    category: 'Eletronicos',
    rating: 4.7,
    deliveryInfo: 'Entrega estimada: 1-2 dias',
    attributes: [
      ProductAttribute(
        title: 'Bateria',
        value: '40h',
        icon: Icons.battery_full_outlined,
      ),
      ProductAttribute(
        title: 'Conexao',
        value: 'Bluetooth 5.3',
        icon: Icons.bluetooth,
      ),
      ProductAttribute(
        title: 'Peso',
        value: '240g',
        icon: Icons.scale_outlined,
      ),
    ],
  );

  static get decorLamp => null;
}
