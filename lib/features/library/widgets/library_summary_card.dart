import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared/widgets/cards/app_card.dart';
import '../providers/library_provider.dart';

class LibrarySummaryCard extends StatelessWidget {
  const LibrarySummaryCard({
    super.key,
    required this.data,
  });

  final LibraryData data;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      key: const Key('library-summary-card'),
      variant: AppCardVariant.premiumGold,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Library Project', style: AppTypography.headlineSmall),
          const SizedBox(height: AppSpacing.xs),
          Text(
            '${data.totalCount} project tersimpan untuk batch shorts kamu.',
            style: AppTypography.bodySmall.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          Row(
            children: [
              Expanded(child: _Metric(label: 'Draft', value: data.draftCount)),
              Expanded(
                child: _Metric(label: 'Proses', value: data.processingCount),
              ),
              Expanded(child: _Metric(label: 'Siap', value: data.readyCount)),
              Expanded(
                child: _Metric(label: 'Live', value: data.publishedCount),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _Metric extends StatelessWidget {
  const _Metric({
    required this.label,
    required this.value,
  });

  final String label;
  final int value;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$value',
          style: AppTypography.headlineMedium.copyWith(color: AppColors.gold),
        ),
        const SizedBox(height: AppSpacing.xs),
        Text(label, style: AppTypography.bodySmall),
      ],
    );
  }
}
