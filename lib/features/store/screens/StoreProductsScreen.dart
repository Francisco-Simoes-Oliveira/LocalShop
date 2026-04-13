import 'package:flutter/material.dart';
import 'package:shoplocal/core/widgets/BottomNavBar.dart';
import 'package:shoplocal/core/widgets/custom_appBar.dart';
import 'package:shoplocal/core/widgets/sectionHeaderAction.dart';
import 'package:shoplocal/features/product/models/product_model.dart';
import 'package:shoplocal/features/store/widgets/productItemTile.dart';
import 'package:shoplocal/routes/app_routes.dart';

class StoreProductsScreen extends StatelessWidget {
  const StoreProductsScreen({super.key});

  static const _tabs = ['Pizzas', 'Bebidas', 'Sobremesas'];

  static const _products = [
    ProductMocks.pizza,
    Product(
      id: 'food-pizza-calabresa',
      name: 'Pizza Calabresa',
      description: 'Calabresa fatiada, cebola roxa e oregano.',
      price: 44.90,
      image: 'assets/img/temp/roupas.png',
      category: 'Comida',
      rating: 4.7,
      deliveryInfo: 'Entrega estimada: 25-40 min',
      attributes: [
        ProductAttribute(
          title: 'Tamanho',
          value: 'Grande',
          icon: Icons.local_pizza_outlined,
        ),
        ProductAttribute(
          title: 'Destaque',
          value: 'Mais vendida',
          icon: Icons.local_fire_department_outlined,
        ),
      ],
    ),
    Product(
      id: 'food-pizza-quatro-queijos',
      name: 'Pizza Quatro Queijos',
      description: 'Mussarela, provolone, parmesao e gorgonzola.',
      price: 49.90,
      oldPrice: 54.90,
      image: 'assets/img/temp/padaria.png',
      category: 'Comida',
      rating: 4.9,
      deliveryInfo: 'Entrega estimada: 30-45 min',
      attributes: [
        ProductAttribute(
          title: 'Massa',
          value: 'Pan',
          icon: Icons.bakery_dining_outlined,
        ),
        ProductAttribute(
          title: 'Queijos',
          value: '4 tipos',
          icon: Icons.egg_alt_outlined,
        ),
      ],
    ),
  ];

  static String _currency(double value) {
    final formatted = value.toStringAsFixed(2).replaceAll('.', ',');
    return 'R\$ $formatted';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomHeader(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF2563EB)),
          onPressed: () => Navigator.pop(context),
        ),
        title: 'LocalShop',
        actions: [
          IconButton(
            onPressed: () => Navigator.pushNamed(context, AppRoutes.cart),
            icon: const Icon(
              Icons.shopping_cart_outlined,
              color: Color(0xFF2563EB),
            ),
          ),
        ],
      ),
      backgroundColor: const Color(0xFFF8FAFC),
      bottomNavigationBar: const BottomNavBar(
        currentRoute: AppRoutes.partnerStores,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: const Color(0xFFE2E8F0)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(16),
                      ),
                      child: Image.asset(
                        'assets/img/temp/padaria.png',
                        width: double.infinity,
                        height: 170,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(14),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            'Pizzaria Napoli',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w800,
                              color: Color(0xFF0F172A),
                            ),
                          ),
                          SizedBox(height: 8),
                          Row(
                            children: [
                              Icon(
                                Icons.star,
                                color: Color(0xFFF59E0B),
                                size: 18,
                              ),
                              SizedBox(width: 4),
                              Text('4.8'),
                              SizedBox(width: 8),
                              Text('•'),
                              SizedBox(width: 8),
                              Text('Pizza'),
                              SizedBox(width: 8),
                              Text('•'),
                              SizedBox(width: 8),
                              Text('25-35 min'),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                height: 40,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: _tabs.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 8),
                  itemBuilder: (context, index) {
                    final tab = _tabs[index];
                    final selected = index == 0;
                    return ChoiceChip(
                      label: Text(tab),
                      selected: selected,
                      onSelected: (_) {},
                      selectedColor: const Color(0xFFDBEAFE),
                      labelStyle: TextStyle(
                        color: selected
                            ? const Color(0xFF1D4ED8)
                            : const Color(0xFF334155),
                        fontWeight: FontWeight.w600,
                      ),
                      side: BorderSide(
                        color: selected
                            ? const Color(0xFF93C5FD)
                            : const Color(0xFFE2E8F0),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 16),
              const SectionHeaderAction(title: 'Pizzas Mais Pedidas'),
              const SizedBox(height: 10),
              ..._products.map(
                (product) => ProductItemTile(
                  name: product.name,
                  description: product.description,
                  price: _currency(product.price),
                  imagePath: product.image,
                  onTap: () => Navigator.pushNamed(
                    context,
                    AppRoutes.productDetail,
                    arguments: product,
                  ),
                  onAdd: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('${product.name} adicionado ao carrinho'),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
