import 'package:flutter/material.dart';

class ProfileStatData {
  const ProfileStatData({required this.label, required this.value});

  final String label;
  final String value;
}

class ProfileStatsRow extends StatelessWidget {
  const ProfileStatsRow({super.key, required this.stats});

  final List<ProfileStatData> stats;

  @override
  Widget build(BuildContext context) {
    final Color onSurface = Theme.of(context).colorScheme.onSurface;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFFF1F5F9),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: List.generate(stats.length * 2 - 1, (index) {
          if (index.isOdd) {
            return Container(
              width: 1,
              height: 42,
              color: onSurface.withValues(alpha: 0.1),
            );
          }

          final item = stats[index ~/ 2];
          return Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
              child: Column(
                children: [
                  Text(
                    item.value,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w800,
                      color: onSurface,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    item.label,
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 12,
                      color: onSurface.withValues(alpha: 0.65),
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
