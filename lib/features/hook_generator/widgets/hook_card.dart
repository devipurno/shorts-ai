import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_radius.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared/models/script.dart';
import '../../../shared/widgets/buttons/app_button.dart';
import '../../../shared/widgets/cards/app_card.dart';
import '../../../shared/widgets/display/app_chip.dart';
import '../providers/hook_provider.dart';

class HookCard extends StatelessWidget {
  const HookCard({
    super.key,
    required this.hook,
    required this.isFavorite,
    required this.onCopy,
    required this.onUse,
    required this.onFavorite,
  });

  final HookOption hook;
  final bool isFavorite;
  final VoidCallback onCopy;
  final VoidCallback onUse;
  final VoidCallback onFavorite;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      variant: AppCardVariant.elevated,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              AppChip(label: hookStyleLabel(hook.style)),
              const Spacer(),
              _ScoreBadge(score: hook.score),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),
          Text(
            hook.text,
            style: AppTypography.displaySmall.copyWith(
              color: AppColors.textPrimary,
              height: 1.12,
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          Row(
            children: [
              Expanded(
                child: AppButton(
                  label: 'Copy',
                  variant: AppButtonVariant.secondary,
                  size: AppButtonSize.sm,
                  icon: const Icon(Icons.copy_rounded),
                  onPressed: () async {
                    await Clipboard.setData(ClipboardData(text: hook.text));
                    onCopy();
                  },
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: AppButton(
                  label: 'Use this',
                  size: AppButtonSize.sm,
                  icon: const Icon(Icons.bolt_rounded),
                  onPressed: onUse,
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              IconButton(
                tooltip: isFavorite ? 'Unfavorite' : 'Favorite',
                onPressed: onFavorite,
                color: isFavorite ? AppColors.gold : AppColors.textSecondary,
                icon: Icon(
                  isFavorite
                      ? Icons.favorite_rounded
                      : Icons.favorite_border_rounded,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ScoreBadge extends StatelessWidget {
  const _ScoreBadge({required this.score});

  final double score;

  @override
  Widget build(BuildContext context) {
    final color = _scoreColor(score);
    return DecoratedBox(
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.16),
        borderRadius: BorderRadius.circular(AppRadius.pill),
        border: Border.all(color: color),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.sm,
          vertical: AppSpacing.xs,
        ),
        child: Text(
          '${score.round()} viral',
          style: AppTypography.labelSmall.copyWith(color: color),
        ),
      ),
    );
  }
}

Color _scoreColor(double score) {
  if (score > 80) {
    return AppColors.gold;
  }
  if (score >= 60) {
    return AppColors.success;
  }
  if (score >= 40) {
    return AppColors.warning;
  }
  return AppColors.textTertiary;
}
