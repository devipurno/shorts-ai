import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../providers/editor_provider.dart';
import '../widgets/timeline/timeline_widget.dart';

class SplitTab extends StatelessWidget {
  const SplitTab({
    super.key,
    required this.state,
    required this.notifier,
  });

  final EditorState state;
  final EditorNotifier notifier;

  @override
  Widget build(BuildContext context) {
    return ListView(
      key: const Key('editor-tab-split'),
      padding: const EdgeInsets.all(AppSpacing.lg),
      children: [
        Text('Split markers', style: AppTypography.headlineSmall),
        const SizedBox(height: AppSpacing.sm),
        Text(
          'Tap timeline untuk menambah marker split.',
          style: AppTypography.bodyMedium.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
        const SizedBox(height: AppSpacing.lg),
        TimelineWidget(
          state: state,
          showTrimHandles: false,
          onTapPosition: notifier.addSplit,
        ),
        const SizedBox(height: AppSpacing.lg),
        if (state.splits.isEmpty)
          Text(
            'Belum ada marker split.',
            style: AppTypography.bodyMedium.copyWith(
              color: AppColors.textSecondary,
            ),
          )
        else
          for (final split in state.splits)
            Dismissible(
              key: ValueKey('split-$split'),
              direction: DismissDirection.endToStart,
              onDismissed: (_) => notifier.removeSplit(split),
              background: Container(
                alignment: Alignment.centerRight,
                padding: const EdgeInsets.only(right: AppSpacing.lg),
                color: AppColors.error,
                child: const Icon(Icons.delete_outline_rounded),
              ),
              child: ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const Icon(Icons.call_split_rounded),
                title: Text(_formatTime(split)),
                trailing: IconButton(
                  icon: const Icon(Icons.close_rounded),
                  onPressed: () => notifier.removeSplit(split),
                ),
              ),
            ),
      ],
    );
  }

  String _formatTime(int ms) {
    final minutes = ms ~/ 60000;
    final seconds = (ms % 60000) ~/ 1000;
    return '${minutes.toString().padLeft(2, '0')}:'
        '${seconds.toString().padLeft(2, '0')}';
  }
}
