import 'package:flutter/material.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({
    super.key,
    required this.name,
    required this.email,
    this.onEditAvatar,
    this.onEditProfile,
  });

  final String name;
  final String email;
  final VoidCallback? onEditAvatar;
  final VoidCallback? onEditProfile;

  @override
  Widget build(BuildContext context) {
    const Color primaryBlue = Color(0xFF2563EB);
    final Color onSurface = Theme.of(context).colorScheme.onSurface;

    return Column(
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              width: 108,
              height: 108,
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: primaryBlue, width: 2),
              ),
              child: const CircleAvatar(
                backgroundColor: Color(0xFFDBEAFE),
                child: Icon(Icons.person_rounded, size: 52, color: primaryBlue),
              ),
            ),
            Positioned(
              right: -2,
              bottom: -2,
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: onEditAvatar,
                  borderRadius: BorderRadius.circular(14),
                  child: Ink(
                    width: 28,
                    height: 28,
                    decoration: BoxDecoration(
                      color: primaryBlue,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                    child: const Icon(
                      Icons.edit_rounded,
                      size: 15,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Text(
          name,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w800,
            color: onSurface,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          email,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 14,
            color: onSurface.withValues(alpha: 0.65),
          ),
        ),
        const SizedBox(height: 16),
        FilledButton.tonalIcon(
          onPressed: onEditProfile,
          icon: const Icon(Icons.manage_accounts_rounded),
          label: const Text('Editar Perfil'),
          style: FilledButton.styleFrom(
            foregroundColor: primaryBlue,
            backgroundColor: const Color(0xFFEAF2FF),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
          ),
        ),
      ],
    );
  }
}
