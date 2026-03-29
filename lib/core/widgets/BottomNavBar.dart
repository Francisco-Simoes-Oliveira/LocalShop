import 'package:flutter/material.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 10),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: const Icon(Icons.home, color: Color(0xFF2563EB)),
                onPressed: () {
                  Navigator.pushNamed(context, '/dashboard');
                },
              ),
              const Text(
                'Início',
                style: TextStyle(fontSize: 12, color: Color(0xFF2563EB)),
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: const Icon(Icons.category, color: Color(0xFF2563EB)),
                onPressed: () {
                  Navigator.pushNamed(context, '/categories');
                },
              ),
              const Text(
                'Categorias',
                style: TextStyle(fontSize: 12, color: Color(0xFF2563EB)),
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: const Icon(
                  Icons.shopping_cart_outlined,
                  color: Color(0xFF2563EB),
                ),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Carrinho de compras')),
                  );
                },
              ),
              const Text(
                'Carrinho',
                style: TextStyle(fontSize: 12, color: Color(0xFF2563EB)),
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: const Icon(
                  Icons.person_outline,
                  color: Color(0xFF2563EB),
                ),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Perfil do usuário')),
                  );
                },
              ),
              const Text(
                'Perfil',
                style: TextStyle(fontSize: 12, color: Color(0xFF2563EB)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
