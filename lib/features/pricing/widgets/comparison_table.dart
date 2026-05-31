import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_radius.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared/widgets/cards/app_card.dart';
import '../../auth/models/user.dart';
import '../providers/pricing_provider.dart';

class ComparisonTable extends StatelessWidget {
  const ComparisonTable({
    super.key,
    required this.features,
  });

  final List<TierFeature> features;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      key: const Key('pricing-comparison-table'),
      padding: EdgeInsets.zero,
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: AppColors.surface3),
        child: ExpansionTile(
          key: const Key('pricing-comparison-expansion'),
          initiallyExpanded: true,
          collapsedIconColor: AppColors.gold,
          iconColor: AppColors.gold,
          tilePadding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.lg,
            vertical: AppSpacing.sm,
          ),
          title: Text(
            'Tier comparison',
            style: AppTypography.headlineSmall,
          ),
          subtitle: Text(
            '${features.length} fitur dibandingkan',
            style: AppTypography.bodySmall,
          ),
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(
                bottom: Radius.circular(AppRadius.md),
              ),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  headingRowColor:
                      const WidgetStatePropertyAll(AppColors.surface2),
                  dataRowMinHeight: 52,
                  dataRowMaxHeight: 68,
                  columnSpacing: AppSpacing.lg,
                  horizontalMargin: AppSpacing.lg,
                  columns: const [
                    DataColumn(label: Text('Feature')),
                    DataColumn(label: Text('Free')),
                    DataColumn(label: Text('Standard')),
                    DataColumn(label: Text('Premium')),
                    DataColumn(label: Text('Lifetime')),
                  ],
                  rows: [
                    for (final feature in features)
                      DataRow(
                        cells: [
                          DataCell(
                            SizedBox(
                              width: 190,
                              child: Text(
                                feature.name,
                                style: AppTypography.bodySmall.copyWith(
                                  color: AppColors.textPrimary,
                                ),
                              ),
                            ),
                          ),
                          DataCell(
                              _FeatureCell(feature, SubscriptionTier.free)),
                          DataCell(
                            _FeatureCell(feature, SubscriptionTier.standard),
                          ),
                          DataCell(
                            _FeatureCell(feature, SubscriptionTier.premium),
                          ),
                          DataCell(
                            _FeatureCell(feature, SubscriptionTier.lifetime),
                          ),
                        ],
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FeatureCell extends StatelessWidget {
  const _FeatureCell(this.feature, this.tier);

  final TierFeature feature;
  final SubscriptionTier tier;

  @override
  Widget build(BuildContext context) {
    final label = feature.labelFor(tier);
    final enabled = feature.enabledFor(tier);

    if (label != null) {
      return Text(
        label,
        style: AppTypography.labelMedium.copyWith(
          color: enabled ? AppColors.goldLight : AppColors.textTertiary,
        ),
      );
    }

    return Icon(
      enabled ? Icons.check_rounded : Icons.close_rounded,
      color: enabled ? AppColors.success : AppColors.textTertiary,
      size: 20,
    );
  }
}
