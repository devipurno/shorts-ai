import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_radius.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../providers/editor_provider.dart';

class FilterTab extends StatelessWidget {
  const FilterTab({
    super.key,
    required this.state,
    required this.notifier,
  });

  final EditorState state;
  final EditorNotifier notifier;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      key: const Key('editor-tab-filter'),
      padding: const EdgeInsets.all(AppSpacing.lg),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1.05,
        crossAxisSpacing: AppSpacing.md,
        mainAxisSpacing: AppSpacing.md,
      ),
      itemCount: FilterPreset.values.length,
      itemBuilder: (context, index) {
        final preset = FilterPreset.values[index];
        final selected = state.filter == preset;
        return InkWell(
          key: Key('filter-${preset.name}'),
          onTap: () => notifier.setFilter(preset),
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: AppColors.surface1,
              borderRadius: BorderRadius.circular(AppRadius.md),
              border: Border.all(
                color: selected ? AppColors.gold : AppColors.surface3,
                width: selected ? 2 : 1,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.sm),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(child: _FilterPreview(preset: preset)),
                  const SizedBox(height: AppSpacing.sm),
                  Text(
                    preset.label,
                    textAlign: TextAlign.center,
                    style: AppTypography.labelMedium.copyWith(
                      color: selected ? AppColors.goldLight : null,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _FilterPreview extends StatelessWidget {
  const _FilterPreview({required this.preset});

  final FilterPreset preset;

  @override
  Widget build(BuildContext context) {
    final colors = switch (preset) {
      FilterPreset.none => const [AppColors.surface2, AppColors.surface3],
      FilterPreset.cinematic => const [Color(0xFF111827), Color(0xFFD4AF37)],
      FilterPreset.vibrant => const [Color(0xFFEC4899), Color(0xFF22C55E)],
      FilterPreset.pastel => const [Color(0xFFF9A8D4), Color(0xFFBFDBFE)],
      FilterPreset.mono => const [Color(0xFF111111), Color(0xFFE5E5E5)],
      FilterPreset.vintage => const [Color(0xFF7C2D12), Color(0xFFFBBF24)],
      FilterPreset.cool => const [Color(0xFF0EA5E9), Color(0xFF1E293B)],
      FilterPreset.warm => const [Color(0xFFF97316), Color(0xFF450A0A)],
    };

    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppRadius.sm),
        gradient: LinearGradient(colors: colors),
      ),
    );
  }
}
