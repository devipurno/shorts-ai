import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_subtitle/flutter_subtitle.dart' as flutter_subtitle;
import 'package:go_router/go_router.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_radius.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_typography.dart';
import '../../shared/models/subtitle.dart';
import 'providers/subtitle_provider.dart';
import 'services/vtt_exporter.dart';
import 'tabs/animation_tab.dart';
import 'tabs/export_tab.dart';
import 'tabs/segments_tab.dart';
import 'tabs/style_tab.dart';
import 'widgets/style_preview.dart';
import 'widgets/subtitle_timeline.dart';

class SubtitleStudioScreen extends ConsumerStatefulWidget {
  const SubtitleStudioScreen({
    super.key,
    required this.videoId,
  });

  final String videoId;

  @override
  ConsumerState<SubtitleStudioScreen> createState() =>
      _SubtitleStudioScreenState();
}

class _SubtitleStudioScreenState extends ConsumerState<SubtitleStudioScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  SubtitleStudioTab _selectedTab = SubtitleStudioTab.segments;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: SubtitleStudioTab.values.length,
      vsync: this,
    )..addListener(() {
        if (_tabController.indexIsChanging) {
          setState(
            () => _selectedTab = SubtitleStudioTab.values[_tabController.index],
          );
        }
      });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(subtitleStudioProvider(widget.videoId));
    final notifier = ref.read(subtitleStudioProvider(widget.videoId).notifier);

    return Scaffold(
      key: const Key('subtitle-studio-screen'),
      backgroundColor: AppColors.obsidian,
      appBar: AppBar(
        backgroundColor: AppColors.obsidian,
        leading: IconButton(
          tooltip: 'Back',
          onPressed: () => context.pop(),
          icon: const Icon(Icons.arrow_back_rounded),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Subtitle Studio Pro', style: AppTypography.headlineSmall),
            Text(
              'Project ${widget.videoId}',
              style: AppTypography.labelSmall.copyWith(
                color: AppColors.textTertiary,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            tooltip: 'Auto split',
            onPressed: () {
              notifier.autoSplitFromTranscript(_demoTranscript);
            },
            icon: const Icon(Icons.auto_awesome_rounded),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            _SubtitleVideoPreview(state: state, notifier: notifier),
            SubtitleTimeline(
              segments: state.segments,
              currentIndex: state.selectedSegmentIndex,
              onSelect: notifier.selectSegment,
            ),
            const SizedBox(height: AppSpacing.sm),
            DecoratedBox(
              decoration: const BoxDecoration(
                color: AppColors.surface1,
                border: Border(
                  top: BorderSide(color: AppColors.surface3),
                  bottom: BorderSide(color: AppColors.surface3),
                ),
              ),
              child: TabBar(
                key: const Key('subtitle-studio-tabs'),
                controller: _tabController,
                labelColor: AppColors.gold,
                unselectedLabelColor: AppColors.textSecondary,
                indicatorColor: AppColors.gold,
                tabs: [
                  for (final tab in SubtitleStudioTab.values)
                    Tab(
                      key: Key('subtitle-tab-button-${tab.name}'),
                      text: tab.label,
                    ),
                ],
              ),
            ),
            Expanded(
              child: switch (_selectedTab) {
                SubtitleStudioTab.segments => SegmentsTab(
                    state: state,
                    notifier: notifier,
                  ),
                SubtitleStudioTab.style => StyleTab(
                    state: state,
                    notifier: notifier,
                  ),
                SubtitleStudioTab.animation => AnimationTab(
                    state: state,
                    notifier: notifier,
                  ),
                SubtitleStudioTab.export => SubtitleExportTab(
                    state: state,
                    notifier: notifier,
                  ),
              },
            ),
          ],
        ),
      ),
    );
  }
}

enum SubtitleStudioTab {
  segments('Segments'),
  style('Style'),
  animation('Animation'),
  export('Export');

  const SubtitleStudioTab(this.label);

  final String label;
}

class _SubtitleVideoPreview extends StatelessWidget {
  const _SubtitleVideoPreview({
    required this.state,
    required this.notifier,
  });

  final SubtitleState state;
  final SubtitleNotifier notifier;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height * 0.42;
    final segment = state.segments.isEmpty
        ? null
        : state.segments[state.selectedSegmentIndex];
    final controller = flutter_subtitle.SubtitleController.string(
      VttExporter.export(state.segments),
      format: flutter_subtitle.SubtitleFormat.webvtt,
    );
    final activeText = controller.textFromMilliseconds(
      state.currentPositionMs,
      controller.subtitles,
    );
    final previewSegment = activeText.isEmpty || segment == null
        ? segment
        : segment.copyWith(text: activeText);

    return Padding(
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Container(
        key: const Key('subtitle-video-preview'),
        height: height.clamp(260, 430).toDouble(),
        padding: const EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(
          color: AppColors.surface1,
          borderRadius: BorderRadius.circular(AppRadius.lg),
          border: Border.all(color: AppColors.surface3),
        ),
        child: Column(
          children: [
            Expanded(
              child: StylePreview(
                segment: previewSegment,
                style: state.style,
                animation: state.animation,
                backgroundStyle: state.backgroundStyle,
                strokeWidth: state.strokeWidth,
                karaokeColor: state.karaokeColor,
                currentPositionMs: state.currentPositionMs,
              ),
            ),
            const SizedBox(height: AppSpacing.sm),
            Row(
              children: [
                const Icon(
                  Icons.play_circle_fill_rounded,
                  color: AppColors.gold,
                ),
                Expanded(
                  child: Slider(
                    min: 0,
                    max: _maxTimeline(state.segments).toDouble(),
                    value: state.currentPositionMs
                        .clamp(0, _maxTimeline(state.segments))
                        .toDouble(),
                    onChanged: (value) {
                      notifier.setCurrentPosition(value.round());
                    },
                  ),
                ),
                Text(
                  '${state.currentPositionMs}ms',
                  style: AppTypography.labelSmall,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  int _maxTimeline(List<SubtitleSegment> segments) {
    if (segments.isEmpty) {
      return 1;
    }
    return segments.last.endMs.clamp(1, 3600000);
  }
}

const _demoTranscript =
    'AutoShort bikin subtitle karaoke terlihat premium dan gampang diedit. '
    'Pilih style, timing kata, lalu export SRT VTT atau ASS.';
