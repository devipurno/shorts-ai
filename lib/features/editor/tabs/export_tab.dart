import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared/widgets/display/app_chip.dart';
import '../../auth/models/user.dart';
import '../providers/editor_provider.dart';

class ExportTab extends StatelessWidget {
  const ExportTab({
    super.key,
    required this.state,
    required this.notifier,
    required this.tier,
  });

  final EditorState state;
  final EditorNotifier notifier;
  final SubscriptionTier tier;

  @override
  Widget build(BuildContext context) {
    return ListView(
      key: const Key('editor-tab-export'),
      padding: const EdgeInsets.all(AppSpacing.lg),
      children: [
        Text('Export settings', style: AppTypography.headlineSmall),
        const SizedBox(height: AppSpacing.lg),
        Text('Resolution', style: AppTypography.labelLarge),
        const SizedBox(height: AppSpacing.sm),
        Wrap(
          spacing: AppSpacing.sm,
          runSpacing: AppSpacing.sm,
          children: [
            for (final resolution in ExportResolution.values)
              AppChip(
                key: Key('export-resolution-${resolution.name}'),
                label: resolution.premiumLocked
                    ? '${resolution.label} LOCKED'
                    : resolution.label,
                variant: AppChipVariant.selectable,
                selected: state.exportConfig.resolution == resolution,
                onSelected: (_) {
                  final ok = notifier.setExportResolution(resolution, tier);
                  if (!ok) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('4K LOCKED Premium tier.'),
                      ),
                    );
                  }
                },
              ),
          ],
        ),
        const SizedBox(height: AppSpacing.lg),
        Text(
          'Bitrate: ${state.exportConfig.bitrateMbps} Mbps',
          style: AppTypography.labelLarge,
        ),
        Slider(
          min: 4,
          max: 80,
          divisions: 19,
          value: state.exportConfig.bitrateMbps.toDouble(),
          onChanged: (value) => notifier.setExportBitrate(value.round()),
        ),
        const SizedBox(height: AppSpacing.lg),
        Text('Format', style: AppTypography.labelLarge),
        const SizedBox(height: AppSpacing.sm),
        Wrap(
          spacing: AppSpacing.sm,
          children: [
            for (final format in ExportFormat.values)
              AppChip(
                label: format.label,
                variant: AppChipVariant.selectable,
                selected: state.exportConfig.format == format,
                onSelected: (_) => notifier.setExportFormat(format),
              ),
          ],
        ),
        if (state.errorMessage != null) ...[
          const SizedBox(height: AppSpacing.md),
          Text(
            state.errorMessage!,
            style: AppTypography.bodySmall.copyWith(color: AppColors.error),
          ),
        ],
      ],
    );
  }
}
