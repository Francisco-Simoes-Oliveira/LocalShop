import 'package:flutter/material.dart';
import 'package:shoplocal/core/widgets/BottomNavBar.dart';
import 'package:shoplocal/core/widgets/custom_appBar.dart';
import 'package:shoplocal/features/home/widgets/cards/PromoCard.dart';
import 'package:shoplocal/features/home/widgets/cards/StoreCard.dart';
import 'package:shoplocal/routes/app_routes.dart';
import '../widgets/SearchBar.dart';
import '../widgets/CategoryCarousel.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomHeader(
        actions: [Icon(Icons.shopping_cart_outlined, color: Color(0xFF2563EB))],
      ),
      bottomNavigationBar: const BottomNavBar(
        currentRoute: AppRoutes.dashboard,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            const CustomSearchBar(),
            const SizedBox(height: 20),

            const SizedBox(height: 20),
            const PromoCard(),
            PromoCard(
              subtitle: const Icon(Icons.local_offer, color: Colors.white),
              textoPrincipal: 'Cupons de até 30% OFF!',
            ),

            CategoryCarousel(
              onCategoryTap: (category) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Categoria: ${category.name}')),
                );
              },
              onViewAllTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Ver todas as categorias')),
                );
                Navigator.pushNamed(context, AppRoutes.categories);
              },
            ),
            const SizedBox(height: 16),
            const StoreCard(),
            const StoreCard(
              imagePath: 'assets/img/temp/roupas.png',
              title: 'Urban Chic Boutique',
              category: 'moda',
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}
