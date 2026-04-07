import 'package:flutter/material.dart';

class CustomHeader extends StatelessWidget implements PreferredSizeWidget {
  final Widget? leading;
  final String? title;
  final List<Widget>? actions;

  const CustomHeader({super.key, this.leading, this.title, this.actions});

  @override
  Size get preferredSize => const Size.fromHeight(64);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 64,
      padding: const EdgeInsets.symmetric(horizontal: 16),

      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: const [
          BoxShadow(
            color: Color(0x0C000000),
            blurRadius: 2,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Row(
        children: [
          /// 🔹 LEFT (leading)
          leading ??
              Image.asset(
                'assets/img/Logo_localShop_icon.png',
                errorBuilder: (context, error, stackTrace) {
                  return Text('ERRO: $error');
                },

                width: 40,
                height: 40,
              ),

          /// 🔹 CENTER (title)
          Expanded(
            child: Center(
              child: Text(
                title ?? 'LocalShop',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF2563EB),
                ),
              ),
            ),
          ),

          /// 🔹 RIGHT (actions)
          Row(mainAxisSize: MainAxisSize.min, children: actions ?? []),
        ],
      ),
    );
  }
}
