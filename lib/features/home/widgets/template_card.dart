import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_radius.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared/models/template.dart';
import '../../../shared/widgets/cards/app_card.dart';

class TemplateCard extends StatelessWidget {
  const TemplateCard({
    super.key,
    required this.template,
    this.onTap,
  });

  final Template template;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final locked = template.tier == TemplateTier.premium;

    return SizedBox(
      width: 156,
      child: AppCard(
        key: Key('template-card-${template.id}'),
        padding: EdgeInsets.zero,
        variant: locked ? AppCardVariant.premiumGold : AppCardVariant.flat,
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: 9 / 16,
              child: Stack(
                children: [
                  Positioned.fill(
                    child: ClipRRect(
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(AppRadius.md),
                      ),
                      child: _TemplatePreview(url: template.thumbnailUrl),
                    ),
                  ),
                  if (locked)
                    Positioned(
                      top: AppSpacing.sm,
                      right: AppSpacing.sm,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          color: AppColors.glassBlack,
                          borderRadius: BorderRadius.circular(AppRadius.pill),
                          border: Border.all(color: AppColors.gold),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppSpacing.sm,
                            vertical: AppSpacing.xs,
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(
                                Icons.lock_rounded,
                                color: AppColors.gold,
                                size: 12,
                              ),
                              const SizedBox(width: AppSpacing.xs),
                              Text(
                                'Premium',
                                style: AppTypography.labelSmall.copyWith(
                                  color: AppColors.gold,
                                ),
                              ),
                            ],
                          ),
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
                    template.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTypography.labelLarge,
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  Text(
                    template.category,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTypography.bodySmall.copyWith(
                      color: AppColors.gold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TemplatePreview extends StatelessWidget {
  const _TemplatePreview({required this.url});

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
    return DecoratedBox(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.surface3, AppColors.goldDark],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: const Center(
        child: Icon(
          Icons.auto_awesome_rounded,
          color: AppColors.goldLight,
          size: 34,
        ),
      ),
    );
  }
}
