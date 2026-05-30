import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared/widgets/buttons/app_button.dart';
import '../../../shared/widgets/display/app_chip.dart';
import '../../../shared/widgets/modals/app_bottom_sheet.dart';
import '../providers/library_provider.dart';

Future<LibraryFilterState?> showLibraryFilterBottomSheet(
  BuildContext context, {
  required LibraryFilterState initialFilter,
}) {
  return AppBottomSheet.show<LibraryFilterState>(
    context,
    child: FilterBottomSheet(initialFilter: initialFilter),
  );
}

class FilterBottomSheet extends StatefulWidget {
  const FilterBottomSheet({
    super.key,
    required this.initialFilter,
  });

  final LibraryFilterState initialFilter;

  @override
  State<FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  late LibraryFilterState _filter = widget.initialFilter;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      key: const Key('library-filter-sheet'),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Filter Library', style: AppTypography.headlineSmall),
          const SizedBox(height: AppSpacing.lg),
          _SectionTitle('Sort by'),
          const SizedBox(height: AppSpacing.sm),
          Wrap(
            spacing: AppSpacing.sm,
            runSpacing: AppSpacing.sm,
            children: [
              for (final sort in LibrarySortOrder.values)
                AppChip(
                  key: Key('library-sort-${sort.name}'),
                  label: sort.label,
                  variant: AppChipVariant.selectable,
                  selected: _filter.sortOrder == sort,
                  onSelected: (_) => setState(
                    () => _filter = _filter.copyWith(sortOrder: sort),
                  ),
                ),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),
          _SectionTitle('Date range'),
          const SizedBox(height: AppSpacing.sm),
          Wrap(
            spacing: AppSpacing.sm,
            runSpacing: AppSpacing.sm,
            children: [
              for (final range in LibraryDateRangeFilter.values)
                AppChip(
                  key: Key('library-date-${range.name}'),
                  label: range.label,
                  variant: AppChipVariant.selectable,
                  selected: _filter.dateRange == range,
                  onSelected: (_) => setState(
                    () => _filter = _filter.copyWith(dateRange: range),
                  ),
                ),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),
          _SectionTitle('Template used'),
          const SizedBox(height: AppSpacing.sm),
          DropdownButtonFormField<String?>(
            key: const Key('library-template-filter'),
            initialValue: _filter.templateId,
            dropdownColor: AppColors.surface2,
            decoration: const InputDecoration(hintText: 'All templates'),
            items: const [
              DropdownMenuItem<String?>(
                value: null,
                child: Text('All templates'),
              ),
              DropdownMenuItem(value: 'template_1', child: Text('Template 1')),
              DropdownMenuItem(value: 'template_2', child: Text('Template 2')),
              DropdownMenuItem(value: 'template_3', child: Text('Template 3')),
              DropdownMenuItem(value: 'template_4', child: Text('Template 4')),
              DropdownMenuItem(value: 'template_5', child: Text('Template 5')),
            ],
            onChanged: (value) => setState(
              () => _filter = _filter.copyWith(templateId: value),
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          _SectionTitle('Tier required'),
          const SizedBox(height: AppSpacing.sm),
          Wrap(
            spacing: AppSpacing.sm,
            runSpacing: AppSpacing.sm,
            children: [
              for (final tier in LibraryTierFilter.values)
                AppChip(
                  key: Key('library-tier-${tier.name}'),
                  label: tier.label,
                  variant: AppChipVariant.selectable,
                  selected: _filter.tier == tier,
                  onSelected: (_) => setState(
                    () => _filter = _filter.copyWith(tier: tier),
                  ),
                ),
            ],
          ),
          const SizedBox(height: AppSpacing.xl),
          Row(
            children: [
              Expanded(
                child: AppButton(
                  label: 'Reset',
                  variant: AppButtonVariant.secondary,
                  onPressed: () =>
                      Navigator.of(context).pop(const LibraryFilterState()),
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: AppButton(
                  label: 'Terapkan',
                  onPressed: () => Navigator.of(context).pop(_filter),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle(this.label);

  final String label;

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: AppTypography.labelLarge.copyWith(color: AppColors.textPrimary),
    );
  }
}
