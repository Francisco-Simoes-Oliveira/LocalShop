import 'package:flutter/material.dart';
import 'package:shoplocal/core/widgets/custom_appBar.dart';
import 'package:shoplocal/features/product/widgets/product_info_badge.dart';
import 'package:shoplocal/features/product/widgets/quantity_selector.dart';
import 'package:shoplocal/routes/app_routes.dart';

class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen({super.key});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  int quantity = 1;

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
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(18),
                    child: Image.asset(
                      'assets/img/temp/padaria.png',
                      width: double.infinity,
                      height: 260,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    top: 12,
                    right: 12,
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.favorite_border,
                          color: Color(0xFFEF4444),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFEAF2FF),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  'Decoração',
                  style: TextStyle(
                    color: Color(0xFF1D4ED8),
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Luminaria Arco Moderna',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF0F172A),
                ),
              ),
              const SizedBox(height: 6),
              const Row(
                children: [
                  Icon(Icons.star, color: Color(0xFFF59E0B), size: 18),
                  SizedBox(width: 4),
                  Text('4.9', style: TextStyle(fontWeight: FontWeight.w700)),
                ],
              ),
              const SizedBox(height: 8),
              const Row(
                children: [
                  Text(
                    'R\$ 289,90',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF0F172A),
                    ),
                  ),
                  SizedBox(width: 10),
                  Text(
                    'R\$ 349,90',
                    style: TextStyle(
                      decoration: TextDecoration.lineThrough,
                      color: Color(0xFF94A3B8),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              const Text(
                'Luminária premium em metal escovado com cúpula de tecido. Ideal para sala de estar e ambientes de leitura.',
                style: TextStyle(color: Color(0xFF475569), height: 1.4),
              ),
              const SizedBox(height: 14),
              const Row(
                children: [
                  ProductInfoBadge(
                    title: 'Resistência',
                    value: 'Alto impacto',
                    icon: Icons.shield_outlined,
                  ),
                  SizedBox(width: 10),
                  ProductInfoBadge(
                    title: 'Garantia',
                    value: '12 meses',
                    icon: Icons.verified_outlined,
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  QuantitySelector(
                    quantity: quantity,
                    onDecrease: () {
                      if (quantity == 1) return;
                      setState(() => quantity--);
                    },
                    onIncrease: () => setState(() => quantity++),
                  ),
                  const Flexible(
                    child: Text(
                      'Entrega estimada: 30-45 min',
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        color: Color(0xFF475569),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: () => Navigator.pushNamed(context, AppRoutes.cart),
                  style: FilledButton.styleFrom(
                    backgroundColor: const Color(0xFF2563EB),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text('Adicionar ao carrinho'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
