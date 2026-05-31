import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_radius.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../services/palette_service.dart';

class PalettePresetStrip extends StatelessWidget {
  const PalettePresetStrip({
    super.key,
    required this.palettes,
    required this.selectedName,
    required this.onSelected,
  });

  final List<BrandPalette> palettes;
  final String? selectedName;
  final ValueChanged<BrandPalette> onSelected;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 92,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: palettes.length,
        separatorBuilder: (_, __) => const SizedBox(width: AppSpacing.sm),
        itemBuilder: (context, index) {
          final palette = palettes[index];
          final selected = palette.name == selectedName;
          return InkWell(
            key: Key('brand-palette-${palette.name}'),
            onTap: () => onSelected(palette),
            borderRadius: BorderRadius.circular(AppRadius.md),
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: AppColors.surface1,
                borderRadius: BorderRadius.circular(AppRadius.md),
                border: Border.all(
                  color: selected ? AppColors.gold : AppColors.surface3,
                ),
              ),
              child: SizedBox(
                width: 132,
                child: Padding(
                  padding: const EdgeInsets.all(AppSpacing.sm),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          _Swatch(color: palette.primary),
                          _Swatch(color: palette.secondary),
                          _Swatch(color: palette.accent),
                        ],
                      ),
                      const Spacer(),
                      Text(
                        palette.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppTypography.labelMedium.copyWith(
                          color: selected
                              ? AppColors.goldLight
                              : AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _Swatch extends StatelessWidget {
  const _Swatch({required this.color});

  final Color color;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(6),
        ),
        child: const SizedBox(height: 28),
      ),
    );
  }
}
