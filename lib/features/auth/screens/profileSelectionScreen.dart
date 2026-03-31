import 'package:flutter/material.dart';
import 'package:shoplocal/core/widgets/custom_appBar.dart';
import 'package:shoplocal/features/auth/widgets/UserRoleSelectionCard.dart';
import 'package:shoplocal/routes/routes.dart';

class Profileselectionscreen extends StatelessWidget {
  const Profileselectionscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomHeader(actions: [Icon(Icons.info_outline)]),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Form(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 24),
              Text(
                'Como você quer usar o app?',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              Text(
                'Escolha seu perfil para personalizarmos sua experiência no comércio local.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 32),
              Userroleselectioncard(
                title: 'Sou Consumidor',
                description:
                    'Quero descobrir lojas próximas,aproveitar promoções e comprar produtos exclusivos na minha região.',
                icon: Icons.shopping_cart,
                routeName: Routes.login,
              ),
              const SizedBox(height: 16),
              Userroleselectioncard(
                title: 'Sou Colaborador',
                description:
                    'Quero gerenciar meu catálogo, atender pedidos de clientes locais e expandir o alcance da minha loja física.',
                icon: Icons.store_outlined,
                routeName: Routes.collaboratorType,
              ),

              const SizedBox(height: 50),
              Text(
                '© 2026 Trojan. Todos os direitos reservados.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, color: Colors.grey[600]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
