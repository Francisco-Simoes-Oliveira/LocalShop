import 'package:flutter/material.dart';
import 'package:shoplocal/core/widgets/BottomNavBar.dart';
import 'package:shoplocal/core/widgets/section_header_action.dart';
import 'package:shoplocal/features/home/widgets/category_masonry_card.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  static const _categories = [
    _CategoryData('Alimentacao', 'assets/img/temp/padaria.png', 160),
    _CategoryData('Roupas', 'assets/img/temp/roupas.png', 120),
    _CategoryData('Eletronicos', 'assets/img/temp/roupas.png', 180),
    _CategoryData('Farmacia', 'assets/img/temp/padaria.png', 120),
    _CategoryData('Pet Shop', 'assets/img/temp/roupas.png', 140),
    _CategoryData('Decoracao', 'assets/img/temp/padaria.png', 160),
  ];

  static const _nearbyStores = [
    _StoreData(
      name: 'Padaria Pao Quente',
      category: 'Alimentacao',
      eta: '20-30 min',
      imagePath: 'assets/img/temp/padaria.png',
    ),
    _StoreData(
      name: 'Urban Chic Boutique',
      category: 'Moda',
      eta: '35-45 min',
      imagePath: 'assets/img/temp/roupas.png',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
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
              TextField(
                decoration: InputDecoration(
                  hintText: 'Buscar loja ou categoria',
                  prefixIcon: const Icon(
                    Icons.search,
                    color: Color(0xFF64748B),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 18),
              const Text(
                'Explorar',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF0F172A),
                ),
              ),
              const SizedBox(height: 12),
              SectionHeaderAction(
                title: 'Categorias',
                actionLabel: 'Ver todas',
                onActionTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Listando todas as categorias...'),
                    ),
                  );
                },
              ),
              const SizedBox(height: 8),
              LayoutBuilder(
                builder: (context, constraints) {
                  final spacing = 10.0;
                  final cardWidth = (constraints.maxWidth - spacing) / 2;
                  return Wrap(
                    spacing: spacing,
                    runSpacing: spacing,
                    children: _categories
                        .map(
                          (category) => SizedBox(
                            width: cardWidth,
                            child: CategoryMasonryCard(
                              label: category.label,
                              imagePath: category.imagePath,
                              height: category.height,
                            ),
                          ),
                        )
                        .toList(),
                  );
                },
              ),
              const SizedBox(height: 20),
              const SectionHeaderAction(title: 'Proximo a voce'),
              const SizedBox(height: 8),
              SizedBox(
                height: 180,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: _nearbyStores.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 10),
                  itemBuilder: (context, index) {
                    final store = _nearbyStores[index];
                    return InkWell(
                      onTap: () =>
                          Navigator.pushNamed(context, '/store-products'),
                      borderRadius: BorderRadius.circular(14),
                      child: Container(
                        width: 220,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(color: const Color(0xFFE2E8F0)),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: const BorderRadius.vertical(
                                top: Radius.circular(14),
                              ),
                              child: Image.asset(
                                store.imagePath,
                                width: 220,
                                height: 100,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    store.name,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    '${store.category} • ${store.eta}',
                                    style: const TextStyle(
                                      color: Color(0xFF64748B),
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
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

class _CategoryData {
  const _CategoryData(this.label, this.imagePath, this.height);

  final String label;
  final String imagePath;
  final double height;
}

class _StoreData {
  const _StoreData({
    required this.name,
    required this.category,
    required this.eta,
    required this.imagePath,
  });

  final String name;
  final String category;
  final String eta;
  final String imagePath;
}
