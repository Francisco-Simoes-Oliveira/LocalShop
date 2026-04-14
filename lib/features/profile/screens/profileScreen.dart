import 'package:flutter/material.dart';
import 'package:shoplocal/core/widgets/BottomNavBar.dart';
import 'package:shoplocal/core/widgets/custom_appBar.dart';
import 'package:shoplocal/features/profile/widgets/profile_header.dart';
import 'package:shoplocal/features/profile/widgets/profile_menu_item.dart';
import 'package:shoplocal/features/profile/widgets/profile_section.dart';
import 'package:shoplocal/features/profile/widgets/profile_stats_row.dart';
import 'package:shoplocal/routes/app_routes.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      appBar: CustomHeader(
        title: 'Meu Perfil',
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.settings_outlined, color: Color(0xFF2563EB)),
            tooltip: 'Configurações',
          ),
        ],
      ),
      bottomNavigationBar: const BottomNavBar(currentRoute: AppRoutes.profile),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 20, 16, 24),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 560),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Center(
                    child: ProfileHeader(
                      name: 'Francisco Simões',
                      email: 'francisco.simoes@email.com',
                    ),
                  ),
                  const SizedBox(height: 24),
                  const ProfileStatsRow(
                    stats: [
                      ProfileStatData(label: 'Pedidos', value: '12'),
                      ProfileStatData(label: 'Favoritos', value: '3'),
                      ProfileStatData(label: 'Status', value: 'Nível Ouro'),
                    ],
                  ),
                  const SizedBox(height: 24),
                  ProfileSection(
                    title: 'Ações Rápidas',
                    children: const [
                      ProfileMenuItem(
                        icon: Icons.receipt_long_rounded,
                        title: 'Meus pedidos',
                      ),
                      ProfileMenuItem(
                        icon: Icons.location_on_outlined,
                        title: 'Endereços salvos',
                      ),
                      ProfileMenuItem(
                        icon: Icons.credit_card_outlined,
                        title: 'Formas de pagamento',
                      ),
                      ProfileMenuItem(
                        icon: Icons.favorite_border_rounded,
                        title: 'Favoritos',
                        showDivider: false,
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  ProfileSection(
                    title: 'Configurações',
                    children: const [
                      ProfileMenuItem(
                        icon: Icons.notifications_none_rounded,
                        title: 'Notificações',
                      ),
                      ProfileMenuItem(
                        icon: Icons.security_rounded,
                        title: 'Segurança',
                      ),
                      ProfileMenuItem(
                        icon: Icons.lock_outline_rounded,
                        title: 'Privacidade',
                      ),
                      ProfileMenuItem(
                        icon: Icons.tune_rounded,
                        title: 'Preferências',
                        showDivider: false,
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  ProfileSection(
                    title: 'Suporte',
                    children: const [
                      ProfileMenuItem(
                        icon: Icons.help_outline_rounded,
                        title: 'Ajuda / FAQ',
                      ),
                      ProfileMenuItem(
                        icon: Icons.support_agent_rounded,
                        title: 'Fale conosco',
                      ),
                      ProfileMenuItem(
                        icon: Icons.description_outlined,
                        title: 'Termos e políticas',
                        showDivider: false,
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  FilledButton.tonalIcon(
                    onPressed: () {},
                    icon: const Icon(Icons.logout_rounded),
                    label: const Text('Sair da conta'),
                    style: FilledButton.styleFrom(
                      minimumSize: const Size.fromHeight(52),
                      backgroundColor: const Color(0xFFE5E7EB),
                      foregroundColor: const Color(0xFF374151),
                      textStyle: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 15,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Center(
                    child: Text(
                      'LocalShop v2.4.0 - Made with ❤️',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12,
                        color: Theme.of(
                          context,
                        ).colorScheme.onSurface.withValues(alpha: 0.55),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
