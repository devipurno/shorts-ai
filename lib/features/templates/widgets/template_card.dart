import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_radius.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared/models/template.dart';
import '../../../shared/widgets/cards/app_card.dart';
import '../providers/template_provider.dart';

class TemplateCard extends StatelessWidget {
  const TemplateCard({
    super.key,
    required this.template,
    this.onTap,
    this.onLongPress,
  });

  final Template template;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;

  @override
  Widget build(BuildContext context) {
    final premium = template.tier == TemplateTier.premium;
    final trending = template.timesUsed > templateTrendingThreshold;

    return GestureDetector(
      key: Key('template-card-${template.id}'),
      onTap: onTap,
      onLongPress: onLongPress,
      child: AppCard(
        padding: EdgeInsets.zero,
        variant: premium ? AppCardVariant.premiumGold : AppCardVariant.flat,
        child: AspectRatio(
          aspectRatio: 9 / 16,
          child: Stack(
            fit: StackFit.expand,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(AppRadius.md),
                child: _TemplateImage(url: template.thumbnailUrl),
              ),
              const DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.transparent, Color(0xE6050608)],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
              ),
              if (trending)
                Positioned(
                  left: AppSpacing.sm,
                  top: AppSpacing.sm,
                  child: _Badge(
                    label: 'Trending',
                    icon: Icons.local_fire_department_rounded,
                    color: AppColors.warning,
                  ),
                ),
              if (premium)
                Positioned(
                  right: AppSpacing.sm,
                  top: AppSpacing.sm,
                  child: _Badge(
                    label: 'Premium',
                    icon: Icons.lock_rounded,
                    color: AppColors.gold,
                  ),
                ),
              Positioned(
                left: AppSpacing.md,
                right: AppSpacing.md,
                bottom: AppSpacing.md,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      template.name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: AppTypography.labelLarge.copyWith(
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            '${template.structure.duration}s',
                            style: AppTypography.bodySmall.copyWith(
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ),
                        const Icon(
                          Icons.star_rounded,
                          color: AppColors.gold,
                          size: 14,
                        ),
                        const SizedBox(width: AppSpacing.xs),
                        Text(
                          template.rating.toStringAsFixed(1),
                          style: AppTypography.labelSmall.copyWith(
                            color: AppColors.gold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TemplateImage extends StatelessWidget {
  const _TemplateImage({required this.url});

  final String? url;

  @override
  Widget build(BuildContext context) {
    if (url == null || url!.isEmpty) {
      return const _TemplateFallback();
    }

    return CachedNetworkImage(
      imageUrl: url!,
      fit: BoxFit.cover,
      placeholder: (context, url) => const _TemplateFallback(),
      errorWidget: (context, url, error) => const _TemplateFallback(),
    );
  }
}

class _TemplateFallback extends StatelessWidget {
  const _TemplateFallback();

  @override
  Widget build(BuildContext context) {
    return const DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.surface2, AppColors.goldDark],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Center(
        child: Icon(
          Icons.auto_awesome_rounded,
          color: AppColors.goldLight,
          size: 38,
        ),
      ),
    );
  }
}

class _Badge extends StatelessWidget {
  const _Badge({
    required this.label,
    required this.icon,
    required this.color,
  });

  final String label;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.glassBlack,
        borderRadius: BorderRadius.circular(AppRadius.pill),
        border: Border.all(color: color),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.sm,
          vertical: AppSpacing.xs,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: color, size: 12),
            const SizedBox(width: AppSpacing.xs),
            Text(
              label,
              style: AppTypography.labelSmall.copyWith(color: color),
            ),
          ],
        ),
      ),
    );
  }
}
