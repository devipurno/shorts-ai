import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared/models/subtitle.dart';
import '../../../shared/widgets/buttons/app_button.dart';
import '../../../shared/widgets/cards/app_card.dart';
import '../providers/subtitle_provider.dart';
import '../widgets/word_timing_editor.dart';

class SegmentsTab extends StatelessWidget {
  const SegmentsTab({
    super.key,
    required this.state,
    required this.notifier,
  });

  final SubtitleState state;
  final SubtitleNotifier notifier;

  @override
  Widget build(BuildContext context) {
    return Column(
      key: const Key('subtitle-tab-segments'),
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.lg,
            AppSpacing.lg,
            AppSpacing.lg,
            AppSpacing.sm,
          ),
          child: Row(
            children: [
              Expanded(
                child: Text('Segments', style: AppTypography.headlineSmall),
              ),
              AppButton(
                key: const Key('subtitle-add-segment'),
                label: 'Add',
                size: AppButtonSize.sm,
                icon: const Icon(Icons.add_rounded),
                onPressed: () => notifier.addSegment(_newSegment(state)),
              ),
            ],
          ),
        ),
        Expanded(
          child: ReorderableListView.builder(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.lg,
              AppSpacing.sm,
              AppSpacing.lg,
              AppSpacing.xl,
            ),
            itemCount: state.segments.length,
            onReorder: notifier.reorderSegments,
            itemBuilder: (context, index) {
              final segment = state.segments[index];
              return Padding(
                key: ValueKey('subtitle-segment-$index-${segment.startMs}'),
                padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                child: AppCard(
                  variant: index == state.selectedSegmentIndex
                      ? AppCardVariant.premiumGold
                      : AppCardVariant.flat,
                  onTap: () {
                    notifier.selectSegment(index);
                    _showEditModal(context, index, segment);
                  },
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${segment.startMs} - ${segment.endMs} ms',
                              style: AppTypography.labelSmall.copyWith(
                                color: AppColors.gold,
                              ),
                            ),
                            const SizedBox(height: AppSpacing.xs),
                            Text(
                              segment.text,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: AppTypography.bodyMedium,
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        tooltip: 'Delete segment',
                        onPressed: () => notifier.deleteSegment(index),
                        icon: const Icon(
                          Icons.delete_outline_rounded,
                          color: AppColors.error,
                        ),
                      ),
                      const Icon(
                        Icons.drag_handle_rounded,
                        color: AppColors.textTertiary,
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  SubtitleSegment _newSegment(SubtitleState state) {
    final start = state.segments.isEmpty ? 0 : state.segments.last.endMs + 160;
    const text = 'New subtitle segment';
    return SubtitleSegment(
      startMs: start,
      endMs: start + 1800,
      text: text,
      words: const [
        Word(text: 'New', startMs: 0, endMs: 420),
        Word(text: 'subtitle', startMs: 420, endMs: 840),
        Word(text: 'segment', startMs: 840, endMs: 1260),
      ],
    );
  }

  void _showEditModal(
    BuildContext context,
    int index,
    SubtitleSegment segment,
  ) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.surface2,
      builder: (context) => _SegmentEditSheet(
        segment: segment,
        onSave: (updated) {
          notifier.updateSegment(index, updated);
          Navigator.of(context).pop();
        },
        onWordTiming: (wordIndex, startMs, endMs) {
          notifier.setWordTiming(
            segmentIndex: index,
            wordIndex: wordIndex,
            startMs: startMs,
            endMs: endMs,
          );
        },
      ),
    );
  }
}

class _SegmentEditSheet extends StatefulWidget {
  const _SegmentEditSheet({
    required this.segment,
    required this.onSave,
    required this.onWordTiming,
  });

  final SubtitleSegment segment;
  final ValueChanged<SubtitleSegment> onSave;
  final void Function(int wordIndex, int startMs, int endMs) onWordTiming;

  @override
  State<_SegmentEditSheet> createState() => _SegmentEditSheetState();
}

class _SegmentEditSheetState extends State<_SegmentEditSheet> {
  late final TextEditingController _textController;
  late final TextEditingController _startController;
  late final TextEditingController _endController;

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController(text: widget.segment.text);
    _startController =
        TextEditingController(text: widget.segment.startMs.toString());
    _endController =
        TextEditingController(text: widget.segment.endMs.toString());
  }

  @override
  void dispose() {
    _textController.dispose();
    _startController.dispose();
    _endController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.82,
      builder: (context, controller) {
        return ListView(
          controller: controller,
          padding: const EdgeInsets.all(AppSpacing.lg),
          children: [
            Text('Edit segment', style: AppTypography.headlineSmall),
            const SizedBox(height: AppSpacing.lg),
            TextField(
              controller: _textController,
              maxLines: 3,
              decoration: const InputDecoration(labelText: 'Subtitle text'),
            ),
            const SizedBox(height: AppSpacing.md),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _startController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(labelText: 'Start ms'),
                  ),
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: TextField(
                    controller: _endController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(labelText: 'End ms'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.lg),
            Text('Word timing', style: AppTypography.labelLarge),
            const SizedBox(height: AppSpacing.sm),
            WordTimingEditor(
              segment: widget.segment,
              onChanged: widget.onWordTiming,
            ),
            const SizedBox(height: AppSpacing.xl),
            AppButton(
              label: 'Save segment',
              onPressed: () {
                widget.onSave(
                  widget.segment.copyWith(
                    text: _textController.text.trim(),
                    startMs: int.tryParse(_startController.text) ??
                        widget.segment.startMs,
                    endMs: int.tryParse(_endController.text) ??
                        widget.segment.endMs,
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }
}
