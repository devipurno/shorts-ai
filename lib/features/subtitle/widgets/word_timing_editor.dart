import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_radius.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared/models/subtitle.dart';

class WordTimingEditor extends StatelessWidget {
  const WordTimingEditor({
    super.key,
    required this.segment,
    required this.onChanged,
  });

  final SubtitleSegment segment;
  final void Function(int wordIndex, int startMs, int endMs) onChanged;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      key: const Key('word-timing-editor'),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: segment.words.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 2.7,
        crossAxisSpacing: AppSpacing.sm,
        mainAxisSpacing: AppSpacing.sm,
      ),
      itemBuilder: (context, index) {
        final word = segment.words[index];
        return DecoratedBox(
          decoration: BoxDecoration(
            color: AppColors.surface1,
            borderRadius: BorderRadius.circular(AppRadius.md),
            border: Border.all(color: AppColors.surface3),
          ),
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.sm),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    word.text,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTypography.labelMedium,
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
                _TinyTimingField(
                  label: 'S',
                  value: word.startMs,
                  onSubmitted: (value) => onChanged(index, value, word.endMs),
                ),
                const SizedBox(width: AppSpacing.xs),
                _TinyTimingField(
                  label: 'E',
                  value: word.endMs,
                  onSubmitted: (value) => onChanged(index, word.startMs, value),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _TinyTimingField extends StatelessWidget {
  const _TinyTimingField({
    required this.label,
    required this.value,
    required this.onSubmitted,
  });

  final String label;
  final int value;
  final ValueChanged<int> onSubmitted;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 54,
      child: TextFormField(
        initialValue: value.toString(),
        keyboardType: TextInputType.number,
        style: AppTypography.labelSmall,
        decoration: InputDecoration(
          labelText: label,
          isDense: true,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.xs,
            vertical: AppSpacing.xs,
          ),
        ),
        onFieldSubmitted: (value) {
          final parsed = int.tryParse(value);
          if (parsed != null) {
            onSubmitted(parsed);
          }
        },
      ),
    );
  }
}
