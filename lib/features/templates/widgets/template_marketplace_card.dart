import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_radius.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared/models/template.dart';
import '../../../shared/widgets/cards/app_card.dart';
import '../../../shared/widgets/display/app_tag.dart';

class TemplateMarketplaceCard extends StatelessWidget {
  const TemplateMarketplaceCard({
    super.key,
    required this.template,
    this.onTap,
  });

  final Template template;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final premium = template.tier == TemplateTier.premium;

    return AppCard(
      key: Key('template-library-card-${template.id}'),
      padding: EdgeInsets.zero,
      variant: premium ? AppCardVariant.premiumGold : AppCardVariant.flat,
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Stack(
              fit: StackFit.expand,
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(AppRadius.md),
                  ),
                  child: _TemplateImage(url: template.thumbnailUrl),
                ),
                const DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.transparent, Color(0xCC050608)],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                ),
                Positioned(
                  left: AppSpacing.sm,
                  top: AppSpacing.sm,
                  child: AppTag(
                    label: premium ? 'Premium' : 'Free',
                    color: premium ? AppColors.gold : AppColors.info,
                  ),
                ),
                Positioned(
                  right: AppSpacing.sm,
                  top: AppSpacing.sm,
                  child: _MetricPill(
                    icon: Icons.star_rounded,
                    label: template.rating.toStringAsFixed(1),
                    highlighted: premium,
                  ),
                ),
                Positioned(
                  left: AppSpacing.sm,
                  right: AppSpacing.sm,
                  bottom: AppSpacing.sm,
                  child: Text(
                    template.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: AppTypography.labelLarge.copyWith(
                      color: AppColors.textPrimary,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  template.category,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTypography.labelSmall.copyWith(
                    color: AppColors.gold,
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
                    _MetricPill(
                      icon: Icons.bolt_rounded,
                      label: _compactNumber(template.timesUsed),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
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
          size: 36,
        ),
      ),
    );
  }
}

class _MetricPill extends StatelessWidget {
  const _MetricPill({
    required this.icon,
    required this.label,
    this.highlighted = false,
  });

  final IconData icon;
  final String label;
  final bool highlighted;

  @override
  Widget build(BuildContext context) {
    final color = highlighted ? AppColors.gold : AppColors.textSecondary;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.glassBlack,
        borderRadius: BorderRadius.circular(AppRadius.pill),
        border: Border.all(
          color: highlighted ? AppColors.gold : AppColors.glassWhite,
        ),
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

String _compactNumber(int value) {
  if (value >= 1000000) {
    return '${(value / 1000000).toStringAsFixed(1)}M';
  }
  if (value >= 1000) {
    return '${(value / 1000).toStringAsFixed(1)}K';
  }
  return value.toString();
}
