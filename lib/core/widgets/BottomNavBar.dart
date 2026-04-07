import 'package:flutter/material.dart';
import 'package:shoplocal/routes/app_routes.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key, required this.currentRoute});

  final String currentRoute;

  int resolveIndex() {
    switch (currentRoute) {
      case AppRoutes.dashboard:
        return 0;
      case AppRoutes.categories:
        return 1;
      case AppRoutes.partnerStores:
      case AppRoutes.storeProducts:
        return 2;
      case AppRoutes.profile:
        return 3;
      default:
        return 0;
    }
  }

  void handleTap(BuildContext context, int index) {
    final destinations = [
      AppRoutes.dashboard,
      AppRoutes.categories,
      AppRoutes.partnerStores,
      AppRoutes.profile,
    ];

    final selectedRoute = destinations[index];
    if (selectedRoute == currentRoute) {
      return;
    }

    Navigator.pushReplacementNamed(context, selectedRoute);
  }

  BottomNavigationBarItem buildItem({
    required IconData icon,
    required String label,
  }) {
    return BottomNavigationBarItem(
      label: label,
      icon: Icon(icon),
      activeIcon: Container(
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: const Color(0xFFEAF2FF),
          border: Border.all(color: const Color(0xFF2563EB), width: 1.2),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(icon),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Color(0x1A000000),
            blurRadius: 10,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: resolveIndex(),
        onTap: (index) => handleTap(context, index),
        selectedItemColor: const Color(0xFF2563EB),
        unselectedItemColor: const Color(0xFF94A3B8),
        selectedFontSize: 11,
        unselectedFontSize: 10,
        showUnselectedLabels: true,
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w700),
        unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.w500),
        items: [
          buildItem(icon: Icons.home_rounded, label: 'Início'),
          buildItem(icon: Icons.category_rounded, label: 'Categorias'),
          buildItem(icon: Icons.storefront_rounded, label: 'Lojas'),
          buildItem(icon: Icons.person_outline_rounded, label: 'Perfil'),
        ],
      ),
    );
  }
}
