import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared/widgets/inputs/text_input.dart';
import '../providers/editor_provider.dart';
import '../widgets/timeline/timeline_widget.dart';

class TrimTab extends StatefulWidget {
  const TrimTab({
    super.key,
    required this.state,
    required this.notifier,
  });

  final EditorState state;
  final EditorNotifier notifier;

  @override
  State<TrimTab> createState() => _TrimTabState();
}

class _TrimTabState extends State<TrimTab> {
  late final TextEditingController _startController;
  late final TextEditingController _endController;

  @override
  void initState() {
    super.initState();
    _startController = TextEditingController(
      text: _formatTime(widget.state.trimStartMs),
    );
    _endController = TextEditingController(
      text: _formatTime(widget.state.trimEndMs),
    );
  }

  @override
  void didUpdateWidget(covariant TrimTab oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.state.trimStartMs != widget.state.trimStartMs) {
      _startController.text = _formatTime(widget.state.trimStartMs);
    }
    if (oldWidget.state.trimEndMs != widget.state.trimEndMs) {
      _endController.text = _formatTime(widget.state.trimEndMs);
    }
  }

  @override
  void dispose() {
    _startController.dispose();
    _endController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      key: const Key('editor-tab-trim'),
      padding: const EdgeInsets.all(AppSpacing.lg),
      children: [
        Text('Trim clip', style: AppTypography.headlineSmall),
        const SizedBox(height: AppSpacing.sm),
        Text(
          'Geser handle atau isi waktu presisi mm:ss.ms.',
          style: AppTypography.bodyMedium.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
        const SizedBox(height: AppSpacing.lg),
        TimelineWidget(
          state: widget.state,
          onTrimChanged: (start, end) {
            widget.notifier.setTrim(startMs: start, endMs: end);
          },
        ),
        const SizedBox(height: AppSpacing.lg),
        Row(
          children: [
            Expanded(
              child: AppTextInput(
                key: const Key('trim-start-input'),
                controller: _startController,
                label: 'Start',
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  final parsed = _parseTime(value);
                  if (parsed != null) {
                    widget.notifier.setTrim(startMs: parsed);
                  }
                },
              ),
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: AppTextInput(
                key: const Key('trim-end-input'),
                controller: _endController,
                label: 'End',
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  final parsed = _parseTime(value);
                  if (parsed != null) {
                    widget.notifier.setTrim(endMs: parsed);
                  }
                },
              ),
            ),
          ],
        ),
        if (widget.state.errorMessage != null) ...[
          const SizedBox(height: AppSpacing.md),
          Text(
            widget.state.errorMessage!,
            style: AppTypography.bodySmall.copyWith(color: AppColors.error),
          ),
        ],
      ],
    );
  }

  String _formatTime(int ms) {
    final minutes = ms ~/ 60000;
    final seconds = (ms % 60000) ~/ 1000;
    final millis = ms % 1000;
    return '${minutes.toString().padLeft(2, '0')}:'
        '${seconds.toString().padLeft(2, '0')}.'
        '${millis.toString().padLeft(3, '0')}';
  }

  int? _parseTime(String value) {
    final match =
        RegExp(r'^(\d+):(\d{1,2})(?:\.(\d{1,3}))?$').firstMatch(value.trim());
    if (match == null) {
      return null;
    }
    final minutes = int.parse(match.group(1)!);
    final seconds = int.parse(match.group(2)!);
    final millis = int.parse((match.group(3) ?? '0').padRight(3, '0'));
    return minutes * 60000 + seconds * 1000 + millis;
  }
}
