import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared/widgets/cards/app_card.dart';
import '../providers/profile_provider.dart';

class StatsRow extends StatelessWidget {
  const StatsRow({
    super.key,
    required this.stats,
  });

  final ProfileStats stats;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      key: const Key('profile-stats-row'),
      height: 116,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          _StatCard(
            value: _compact(stats.videosCreated),
            label: 'Videos Created',
            icon: Icons.movie_creation_outlined,
          ),
          const SizedBox(width: AppSpacing.md),
          _StatCard(
            value: _compact(stats.totalViews),
            label: 'Total Views',
            icon: Icons.visibility_outlined,
          ),
          const SizedBox(width: AppSpacing.md),
          _StatCard(
            value: _compact(stats.followersGained),
            label: 'Followers Gained',
            icon: Icons.trending_up_rounded,
          ),
        ],
      ),
    );
  }

  String _compact(int value) {
    if (value >= 1000000) {
      return '${(value / 1000000).toStringAsFixed(1)}M';
    }
    if (value >= 1000) {
      return '${(value / 1000).toStringAsFixed(1)}K';
    }
    return value.toString();
  }
}

class _StatCard extends StatelessWidget {
  const _StatCard({
    required this.value,
    required this.label,
    required this.icon,
  });

  final String value;
  final String label;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 152,
      child: AppCard(
        variant: AppCardVariant.elevated,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: AppColors.gold, size: 20),
            const Spacer(),
            Text(
              value,
              style: AppTypography.headlineLarge.copyWith(
                color: AppColors.gold,
              ),
            ),
            const SizedBox(height: AppSpacing.xs),
            Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppTypography.bodySmall.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
