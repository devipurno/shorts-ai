import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared/models/subtitle.dart';
import '../../../shared/widgets/buttons/app_button.dart';
import '../../../shared/widgets/cards/app_card.dart';
import '../../../shared/widgets/display/app_chip.dart';
import '../providers/subtitle_provider.dart';

class SubtitleExportTab extends StatelessWidget {
  const SubtitleExportTab({
    super.key,
    required this.state,
    required this.notifier,
  });

  final SubtitleState state;
  final SubtitleNotifier notifier;

  @override
  Widget build(BuildContext context) {
    return ListView(
      key: const Key('subtitle-tab-export'),
      padding: const EdgeInsets.all(AppSpacing.lg),
      children: [
        Text('Export subtitle', style: AppTypography.headlineSmall),
        const SizedBox(height: AppSpacing.md),
        Wrap(
          spacing: AppSpacing.sm,
          runSpacing: AppSpacing.sm,
          children: [
            for (final format in SubtitleFormat.values)
              AppChip(
                key: Key('subtitle-format-${format.name}'),
                label: format.name.toUpperCase(),
                variant: AppChipVariant.selectable,
                selected: state.format == format,
                onSelected: (_) => notifier.setFormat(format),
              ),
          ],
        ),
        const SizedBox(height: AppSpacing.lg),
        AppButton(
          key: const Key('subtitle-burn-video'),
          label: 'Burn ke Video',
          icon: const Icon(Icons.local_fire_department_rounded),
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Burn ke video akan diproses di worker stage.'),
              ),
            );
          },
        ),
        const SizedBox(height: AppSpacing.md),
        AppButton(
          key: const Key('subtitle-download-file'),
          label: 'Download File',
          variant: AppButtonVariant.secondary,
          icon: const Icon(Icons.download_rounded),
          onPressed: () {
            final content = notifier.exportFile();
            SharePlus.instance.share(
              ShareParams(
                text: content,
                subject:
                    'AutoShort subtitles.${state.format.name.toLowerCase()}',
              ),
            );
          },
        ),
        if (state.exportedContent != null) ...[
          const SizedBox(height: AppSpacing.lg),
          Text('Preview', style: AppTypography.labelLarge),
          const SizedBox(height: AppSpacing.sm),
          AppCard(
            variant: AppCardVariant.glass,
            child: Text(
              state.exportedContent!,
              maxLines: 12,
              overflow: TextOverflow.ellipsis,
              style: AppTypography.mono.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
          ),
        ],
      ],
    );
  }
}
