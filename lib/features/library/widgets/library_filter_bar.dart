import 'package:flutter/material.dart';

import '../../../core/theme/app_spacing.dart';
import '../../../shared/widgets/display/app_chip.dart';
import '../providers/library_provider.dart';

class LibraryFilterBar extends StatelessWidget {
  const LibraryFilterBar({
    super.key,
    required this.selected,
    required this.onSelected,
  });

  final LibraryStatusFilter selected;
  final ValueChanged<LibraryStatusFilter> onSelected;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 44,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final status = LibraryStatusFilter.values[index];
          return AppChip(
            key: Key('library-filter-${status.name}'),
            label: status.label,
            variant: AppChipVariant.filter,
            selected: selected == status,
            onSelected: (_) => onSelected(status),
          );
        },
        separatorBuilder: (context, index) =>
            const SizedBox(width: AppSpacing.sm),
        itemCount: LibraryStatusFilter.values.length,
      ),
    );
  }
}
