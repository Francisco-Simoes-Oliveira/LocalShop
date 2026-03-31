import 'package:flutter/material.dart';
import 'package:shoplocal/core/widgets/custom_appBar.dart';
import 'package:shoplocal/features/auth/widgets/UserRoleSelectionCard.dart';
import 'package:shoplocal/routes/routes.dart';

class Collaboratotypescreen extends StatelessWidget {
  const Collaboratotypescreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomHeader(
        actions: [
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Form(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 24),
              Text(
                'Escolha seu perfil profissional',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              Text(
                'Selecione como você deseja colaborar com a rede de lojistas locais da sua região.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 32),
              Userroleselectioncard(
                title: 'Administrador de Loja',
                description:
                    'Gerencie inventário, processe pedidos e acompanhe o crescimento do seu negócio local.',
                icon: Icons.store,
                routeName: Routes.login,
              ),
              const SizedBox(height: 16),
              Userroleselectioncard(
                title: 'MotoBoy (Em BREVE)',
                description:
                    'Faça entregas rápidas na sua região e tenha flexibilidade de horários.',
                icon: Icons.sports_motorsports,
                routeName: Routes.collaboratorType,
                cor: Colors.grey,
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
