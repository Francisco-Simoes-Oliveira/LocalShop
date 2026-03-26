import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onPressed;

  final String? text;
  final Widget? child;
  final Color? color;
  final Color? textColor;

  final EdgeInsetsGeometry? padding;

  final double borderRadius;

  const CustomButton({
    super.key,
    required this.onPressed,
    this.text,
    this.child,
    this.color,
    this.textColor,
    this.padding,
    this.borderRadius = 12,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final backgroundColor = color ?? theme.colorScheme.primary;
    final foregroundColor = textColor ?? Colors.white;

    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        foregroundColor: foregroundColor,
        padding:
            padding ?? const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        elevation: 2,
      ),
      child: child ?? Text(text ?? 'Botão'),
    );
  }
}
