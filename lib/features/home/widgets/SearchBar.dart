import 'package:flutter/material.dart';

class CustomSearchBar extends StatelessWidget {
  const CustomSearchBar({
    super.key,
    this.controller,
    this.onChanged,
    this.hintText = 'Pesquisar...',
  });

  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final inputTheme = theme.inputDecorationTheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: SizedBox(
        height: 42,
        child: TextField(
          controller: controller,
          onChanged: onChanged,
          style: theme.textTheme.bodySmall?.copyWith(fontSize: 14),
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: theme.textTheme.bodySmall?.copyWith(
              color: theme.hintColor,
              fontSize: 14,
            ),
            prefixIcon: Icon(
              Icons.search,
              size: 20,
              color: theme.iconTheme.color,
            ),
            filled: true,
            fillColor: theme.colorScheme.surfaceVariant.withOpacity(0.2),
            contentPadding: const EdgeInsets.symmetric(
              vertical: 8,
              horizontal: 12,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: theme.dividerColor, width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: theme.colorScheme.primary,
                width: 2,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
