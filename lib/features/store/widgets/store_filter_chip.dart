import 'package:flutter/material.dart';

class StoreFilterChip extends StatelessWidget {
  const StoreFilterChip({
    super.key,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ChoiceChip(
      label: Text(label),
      selected: selected,
      onSelected: (_) => onTap(),
      selectedColor: const Color(0xFFEAF2FF),
      backgroundColor: Colors.white,
      side: BorderSide(
        color: selected ? const Color(0xFF2563EB) : const Color(0xFFE2E8F0),
      ),
      labelStyle: TextStyle(
        color: selected ? const Color(0xFF1D4ED8) : const Color(0xFF64748B),
        fontWeight: FontWeight.w600,
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
    );
  }
}
