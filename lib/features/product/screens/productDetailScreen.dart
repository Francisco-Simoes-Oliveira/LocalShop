import 'package:flutter/material.dart';
import 'package:shoplocal/core/services/cart_service.dart';
import 'package:shoplocal/core/widgets/custom_appBar.dart';
import 'package:shoplocal/features/product/models/product_model.dart';
import 'package:shoplocal/features/product/widgets/product_info_badge.dart';
import 'package:shoplocal/features/product/widgets/quantity_selector.dart';
import 'package:shoplocal/routes/app_routes.dart';

class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen({super.key, required this.product});

  final Product product;

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  int quantity = 1;

  bool get _hasOldPrice =>
      widget.product.oldPrice != null &&
      widget.product.oldPrice! > widget.product.price;

  String _currency(double value) {
    final formatted = value.toStringAsFixed(2).replaceAll('.', ',');
    return 'R\$ $formatted';
  }

  bool _isNetworkImage(String image) {
    return image.startsWith('http://') || image.startsWith('https://');
  }

  void _addToCart(BuildContext context) {
    CartService.add(widget.product, quantity);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          '${widget.product.name} (x$quantity) adicionado ao carrinho',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final product = widget.product;

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
                    child: _isNetworkImage(product.image)
                        ? Image.network(
                            product.image,
                            width: double.infinity,
                            height: 260,
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) => _ImageFallback(),
                          )
                        : Image.asset(
                            product.image,
                            width: double.infinity,
                            height: 260,
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) => _ImageFallback(),
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
                child: Text(
                  product.category,
                  style: TextStyle(
                    color: Color(0xFF1D4ED8),
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                product.name,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF0F172A),
                ),
              ),
              const SizedBox(height: 6),
              Row(
                children: [
                  const Icon(Icons.star, color: Color(0xFFF59E0B), size: 18),
                  const SizedBox(width: 4),
                  Text(
                    product.rating.toStringAsFixed(1),
                    style: const TextStyle(fontWeight: FontWeight.w700),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Text(
                    _currency(product.price),
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF0F172A),
                    ),
                  ),
                  if (_hasOldPrice) ...[
                    const SizedBox(width: 10),
                    Text(
                      _currency(product.oldPrice!),
                      style: const TextStyle(
                        decoration: TextDecoration.lineThrough,
                        color: Color(0xFF94A3B8),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ],
              ),
              const SizedBox(height: 12),
              Text(
                product.description,
                style: TextStyle(color: Color(0xFF475569), height: 1.4),
              ),
              const SizedBox(height: 14),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: product.attributes
                    .map(
                      (attribute) => SizedBox(
                        width: (MediaQuery.of(context).size.width - 42) / 2,
                        child: ProductInfoBadge(
                          title: attribute.title,
                          value: attribute.value,
                          icon: attribute.icon,
                        ),
                      ),
                    )
                    .toList(),
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
                  Flexible(
                    child: Text(
                      product.deliveryInfo,
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
                  onPressed: () => _addToCart(context),
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

class _ImageFallback extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 260,
      color: const Color(0xFFE2E8F0),
      alignment: Alignment.center,
      child: const Icon(Icons.broken_image_outlined, color: Color(0xFF64748B)),
    );
  }
}
