import 'package:flutter/material.dart';
import 'package:shoplocal/core/widgets/BottomNavBar.dart';
import 'package:shoplocal/core/widgets/custom_appBar.dart';
import 'package:shoplocal/routes/app_routes.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomHeader(title: 'LocalShop'),
      bottomNavigationBar: const BottomNavBar(currentRoute: AppRoutes.profile),
      body: const Center(
        child: Text(
          'Perfil do usuário',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
