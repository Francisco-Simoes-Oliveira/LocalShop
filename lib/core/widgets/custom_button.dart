import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onPressed;

  /// Texto exibido no botão.
  /// Será ignorado se [child] for informado.
  final String? text;

  /// Widget customizado para o conteúdo do botão.
  final Widget? child;

  /// Cor de fundo do botão.
  /// Se não for informada, usa a cor primária do tema.
  final Color? color;

  /// Cor do texto/conteúdo.
  final Color? textColor;

  /// Espaçamento interno do botão.
  final EdgeInsetsGeometry? padding;

  /// Raio das bordas.
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
