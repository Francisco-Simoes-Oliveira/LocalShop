import 'package:flutter/material.dart';
import 'package:shoplocal/core/widgets/BottomNavBar.dart';
import 'package:shoplocal/core/widgets/section_header_action.dart';
import 'package:shoplocal/features/store/widgets/product_item_tile.dart';

class StoreProductsScreen extends StatelessWidget {
  const StoreProductsScreen({super.key});

  static const _tabs = ['Pizzas', 'Bebidas', 'Sobremesas'];

  static const _products = [
    _ProductData(
      name: 'Pizza Margherita',
      description: 'Molho de tomate, mussarela e manjericao fresco.',
      price: 'R\$ 39,90',
      imagePath: 'assets/img/temp/padaria.png',
    ),
    _ProductData(
      name: 'Pizza Calabresa',
      description: 'Calabresa fatiada, cebola roxa e oregano.',
      price: 'R\$ 44,90',
      imagePath: 'assets/img/temp/roupas.png',
    ),
    _ProductData(
      name: 'Pizza Quatro Queijos',
      description: 'Mussarela, provolone, parmesao e gorgonzola.',
      price: 'R\$ 49,90',
      imagePath: 'assets/img/temp/padaria.png',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF0F172A)),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'LocalShop',
          style: TextStyle(
            color: Color(0xFF0F172A),
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      backgroundColor: const Color(0xFFF8FAFC),
      bottomNavigationBar: const BottomNavBar(),
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
                  price: product.price,
                  imagePath: product.imagePath,
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

class _ProductData {
  const _ProductData({
    required this.name,
    required this.description,
    required this.price,
    required this.imagePath,
  });

  final String name;
  final String description;
  final String price;
  final String imagePath;
}
