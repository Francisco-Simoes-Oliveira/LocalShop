import 'package:flutter/material.dart';
import 'package:shoplocal/core/widgets/BottomNavBar.dart';
import 'package:shoplocal/core/widgets/custom_appBar.dart';
import 'package:shoplocal/features/store/widgets/storeCard.dart';
import 'package:shoplocal/features/store/widgets/storeFilterChip.dart';
import 'package:shoplocal/routes/app_routes.dart';

class PartnerStoresScreen extends StatefulWidget {
  const PartnerStoresScreen({super.key});

  @override
  State<PartnerStoresScreen> createState() => _PartnerStoresScreenState();
}

class _PartnerStoresScreenState extends State<PartnerStoresScreen> {
  int selectedFilter = 0;

  static const _filters = [
    'Mais proximas',
    'Melhores avaliadas',
    'Entrega gratis',
  ];

  static const stores = [
    StoreData(
      imagePath: 'assets/img/temp/padaria.png',
      name: 'Padaria Artesanal Villa',
      category: 'Padaria • Cafes',
      deliveryTime: '18-28 min',
      deliveryFee: 'Frete R\$ 4,99',
      rating: '4.9',
    ),
    StoreData(
      imagePath: 'assets/img/temp/padaria.png',
      name: 'Mercado Central Fresh',
      category: 'Mercado',
      deliveryTime: '22-35 min',
      deliveryFee: 'Entrega gratis',
      rating: '4.8',
    ),
    StoreData(
      imagePath: 'assets/img/temp/roupas.png',
      name: 'Floricultura Aroma & Cor',
      category: 'Presentes • Decoracao',
      deliveryTime: '30-45 min',
      deliveryFee: 'Frete R\$ 7,99',
      rating: '4.7',
    ),
    StoreData(
      imagePath: 'assets/img/temp/padaria.png',
      name: 'Cafe do Ponto Local',
      category: 'Cafe e Lanches',
      deliveryTime: '15-25 min',
      deliveryFee: 'Frete R\$ 3,99',
      rating: '4.9',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomHeader(
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
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Descubra Lojas Locais',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF0F172A),
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                height: 36,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: _filters.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 8),
                  itemBuilder: (context, index) {
                    return StoreFilterChip(
                      label: _filters[index],
                      selected: selectedFilter == index,
                      onTap: () => setState(() => selectedFilter = index),
                    );
                  },
                ),
              ),
              const SizedBox(height: 14),
              Expanded(
                child: ListView.separated(
                  itemCount: stores.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 10),
                  itemBuilder: (context, index) {
                    final store = stores[index];
                    return StoreCard(
                      imagePath: store.imagePath,
                      name: store.name,
                      category: store.category,
                      deliveryTime: store.deliveryTime,
                      deliveryFee: store.deliveryFee,
                      rating: store.rating,
                      onTap: () =>
                          Navigator.pushNamed(context, AppRoutes.storeProducts),
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

class StoreData {
  const StoreData({
    required this.imagePath,
    required this.name,
    required this.category,
    required this.deliveryTime,
    required this.deliveryFee,
    required this.rating,
  });

  final String imagePath;
  final String name;
  final String category;
  final String deliveryTime;
  final String deliveryFee;
  final String rating;
}
