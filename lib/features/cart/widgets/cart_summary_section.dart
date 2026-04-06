import 'package:flutter/material.dart';

class CartSummarySection extends StatelessWidget {
  const CartSummarySection({
    super.key,
    required this.subtotal,
    required this.delivery,
    required this.total,
    required this.onCheckout,
  });

  final String subtotal;
  final String delivery;
  final String total;
  final VoidCallback onCheckout;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        children: [
          _line('Subtotal', subtotal),
          const SizedBox(height: 8),
          _line('Entrega', delivery),
          const Divider(height: 24),
          _line('Total', total, emphasize: true),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: FilledButton(
              onPressed: onCheckout,
              style: FilledButton.styleFrom(
                backgroundColor: const Color(0xFF2563EB),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text('Finalizar compra'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _line(String label, String value, {bool emphasize = false}) {
    final style = TextStyle(
      fontWeight: emphasize ? FontWeight.w800 : FontWeight.w600,
      color: emphasize ? const Color(0xFF0F172A) : const Color(0xFF334155),
      fontSize: emphasize ? 17 : 14,
    );

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: style),
        Text(value, style: style),
      ],
    );
  }
}
