import 'package:flutter/material.dart';
import 'package:shoplocal/core/widgets/BottomNavBar.dart';
import 'package:shoplocal/core/widgets/custom_appBar.dart';
import 'package:shoplocal/features/cart/widgets/cart_item_card.dart';
import 'package:shoplocal/features/cart/widgets/cart_summary_section.dart';
import 'package:shoplocal/routes/app_routes.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  static const _items = [
    _CartItem(
      imagePath: 'assets/img/temp/padaria.png',
      name: 'Pizza Margherita',
      origin: 'Pizzaria Napoli',
      quantity: 1,
      price: 'R\$ 39,90',
    ),
    _CartItem(
      imagePath: 'assets/img/temp/roupas.png',
      name: 'Suco Natural Laranja',
      origin: 'Mercado Central Fresh',
      quantity: 2,
      price: 'R\$ 13,80',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomHeader(
        title: 'Meu Carrinho',
        actions: [
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.close, color: Color(0xFF2563EB)),
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
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: const Color(0xFFE2E8F0)),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.location_on_outlined,
                      color: Color(0xFF2563EB),
                    ),
                    const SizedBox(width: 8),
                    const Expanded(
                      child: Text(
                        'Rua das Palmeiras, 180 - Centro',
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ),
                    TextButton(onPressed: () {}, child: const Text('Alterar')),
                  ],
                ),
              ),
              const SizedBox(height: 14),
              ..._items.map(
                (item) => CartItemCard(
                  imagePath: item.imagePath,
                  name: item.name,
                  origin: item.origin,
                  price: item.price,
                  quantity: item.quantity,
                  onIncrease: () {},
                  onDecrease: () {},
                  onRemove: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('${item.name} removido do carrinho'),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 6),
              OutlinedButton.icon(
                onPressed: () =>
                    Navigator.pushNamed(context, AppRoutes.partnerStores),
                icon: const Icon(Icons.add_shopping_cart),
                label: const Text('Adicionar mais itens'),
                style: OutlinedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 44),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(height: 14),
              CartSummarySection(
                subtotal: 'R\$ 53,70',
                delivery: 'R\$ 7,99',
                total: 'R\$ 61,69',
                onCheckout: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Compra finalizada com sucesso!'),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CartItem {
  const _CartItem({
    required this.imagePath,
    required this.name,
    required this.origin,
    required this.quantity,
    required this.price,
  });

  final String imagePath;
  final String name;
  final String origin;
  final int quantity;
  final String price;
}
