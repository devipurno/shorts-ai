import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:screenshot/screenshot.dart';
import 'package:video_player/video_player.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_radius.dart';
import '../../core/utils/logger.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_typography.dart';
import '../../shared/models/project.dart';
import '../../shared/widgets/buttons/icon_button.dart';
import '../auth/models/user.dart';
import '../auth/providers/current_user_provider.dart';
import 'providers/editor_provider.dart';
import 'tabs/export_tab.dart';
import 'tabs/filter_tab.dart';
import 'tabs/music_tab.dart';
import 'tabs/speed_tab.dart';
import 'tabs/split_tab.dart';
import 'tabs/trim_tab.dart';
import 'tabs/watermark_tab.dart';
import 'widgets/export_progress_dialog.dart';
import 'widgets/timeline/timeline_widget.dart';

class MiniEditorScreen extends ConsumerStatefulWidget {
  const MiniEditorScreen({
    super.key,
    required this.videoId,
  });

  final String videoId;

  @override
  ConsumerState<MiniEditorScreen> createState() => _MiniEditorScreenState();
}

class _MiniEditorScreenState extends ConsumerState<MiniEditorScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  final _screenshotController = ScreenshotController();
  EditorToolTab _selectedTab = EditorToolTab.trim;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: EditorToolTab.values.length,
      vsync: this,
    )..addListener(() {
        if (_tabController.indexIsChanging) {
          setState(
              () => _selectedTab = EditorToolTab.values[_tabController.index]);
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
    final project = ref.watch(editorProjectProvider(widget.videoId));
    final state = ref.watch(editorProvider(widget.videoId));
    final notifier = ref.read(editorProvider(widget.videoId).notifier);
    final user = ref.watch(currentUserProvider);
    final previewHeight = MediaQuery.sizeOf(context).height * 0.34;

    return Scaffold(
      key: const Key('mini-editor-screen'),
      backgroundColor: AppColors.obsidian,
      appBar: AppBar(
        backgroundColor: AppColors.obsidian,
        surfaceTintColor: Colors.transparent,
        leading: AppIconButton(
          tooltip: 'Back',
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () => context.pop(),
        ),
        title: project.when(
          data: (value) {
            _syncVideoUrl(value, state, notifier);
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  value?.title ?? 'Mini Editor',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTypography.headlineSmall,
                ),
                Text(
                  'Saved',
                  style: AppTypography.labelSmall.copyWith(
                    color: AppColors.success,
                  ),
                ),
              ],
            );
          },
          loading: () => const Text('Mini Editor'),
          error: (error, stackTrace) => const Text('Mini Editor'),
        ),
        actions: [
          TextButton.icon(
            key: const Key('editor-export-action'),
            icon: const Icon(Icons.upload_rounded),
            label: const Text('Export'),
            onPressed: () => _showExportDialog(),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.lg,
                AppSpacing.sm,
                AppSpacing.lg,
                AppSpacing.md,
              ),
              child: Screenshot(
                controller: _screenshotController,
                child: SizedBox(
                  height: previewHeight.clamp(220, 360).toDouble(),
                  child: _VideoPreview(videoUrl: state.videoUrl),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
              child: TimelineWidget(
                state: state,
                onTrimChanged: (start, end) {
                  notifier.setTrim(startMs: start, endMs: end);
                },
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            DecoratedBox(
              decoration: const BoxDecoration(
                color: AppColors.surface1,
                border: Border(
                  top: BorderSide(color: AppColors.surface3),
                  bottom: BorderSide(color: AppColors.surface3),
                ),
              ),
              child: TabBar(
                key: const Key('editor-toolbar-tabs'),
                controller: _tabController,
                isScrollable: true,
                tabAlignment: TabAlignment.start,
                labelColor: AppColors.gold,
                unselectedLabelColor: AppColors.textSecondary,
                indicatorColor: AppColors.gold,
                tabs: [
                  for (final tab in EditorToolTab.values)
                    Tab(
                      key: Key('editor-tab-button-${tab.name}'),
                      text: tab.label,
                    ),
                ],
              ),
            ),
            Expanded(
              child: _EditorTabBody(
                selectedTab: _selectedTab,
                state: state,
                notifier: notifier,
                tier: user?.tier ?? SubscriptionTier.free,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _syncVideoUrl(
    Project? project,
    EditorState state,
    EditorNotifier notifier,
  ) {
    final url = project?.processedVideoUrl ?? project?.originalVideoUrl ?? '';
    if (url.isNotEmpty && state.videoUrl.isEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          notifier.setVideoUrl(url);
        }
      });
    }
  }

  void _showExportDialog() {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        fullscreenDialog: true,
        builder: (context) => ExportProgressDialog(videoId: widget.videoId),
      ),
    );
  }
}

class _EditorTabBody extends StatelessWidget {
  const _EditorTabBody({
    required this.selectedTab,
    required this.state,
    required this.notifier,
    required this.tier,
  });

  final EditorToolTab selectedTab;
  final EditorState state;
  final EditorNotifier notifier;
  final SubscriptionTier tier;

  @override
  Widget build(BuildContext context) {
    return switch (selectedTab) {
      EditorToolTab.trim => TrimTab(state: state, notifier: notifier),
      EditorToolTab.split => SplitTab(state: state, notifier: notifier),
      EditorToolTab.speed => SpeedTab(state: state, notifier: notifier),
      EditorToolTab.music => MusicTab(state: state, notifier: notifier),
      EditorToolTab.watermark => WatermarkTab(state: state, notifier: notifier),
      EditorToolTab.filter => FilterTab(state: state, notifier: notifier),
      EditorToolTab.export => ExportTab(
          state: state,
          notifier: notifier,
          tier: tier,
        ),
    };
  }
}

class _VideoPreview extends StatefulWidget {
  const _VideoPreview({required this.videoUrl});

  final String videoUrl;

  @override
  State<_VideoPreview> createState() => _VideoPreviewState();
}

class _VideoPreviewState extends State<_VideoPreview> {
  VideoPlayerController? _videoController;
  ChewieController? _chewieController;
  bool _ready = false;

  @override
  void didUpdateWidget(covariant _VideoPreview oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.videoUrl != widget.videoUrl) {
      _initialize();
    }
  }

  @override
  void initState() {
    super.initState();
    _initialize();
  }

  @override
  void dispose() {
    _chewieController?.dispose();
    _videoController?.dispose();
    super.dispose();
  }

  Future<void> _initialize() async {
    _chewieController?.dispose();
    await _videoController?.dispose();
    _ready = false;

    if (widget.videoUrl.isEmpty) {
      if (mounted) {
        setState(() {});
      }
      return;
    }

    final uri = Uri.tryParse(widget.videoUrl);
    if (uri == null || !uri.hasScheme) {
      if (mounted) {
        setState(() {});
      }
      return;
    }

    final controller = VideoPlayerController.networkUrl(uri);
    try {
      await controller.initialize();
      _videoController = controller;
      _chewieController = ChewieController(
        videoPlayerController: controller,
        autoPlay: false,
        looping: true,
        showControls: true,
        materialProgressColors: ChewieProgressColors(
          playedColor: AppColors.gold,
          handleColor: AppColors.goldLight,
        ),
      );
      if (mounted) {
        setState(() => _ready = true);
      }
    } catch (error, stackTrace) {
      AppLogger.w(
        'Video player initialization failed',
        tag: 'MiniEditor',
        error: error,
        stackTrace: stackTrace,
      );
      await controller.dispose();
      if (mounted) {
        setState(() => _ready = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      key: const Key('editor-video-preview'),
      aspectRatio: 9 / 16,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: AppColors.surface1,
          borderRadius: BorderRadius.circular(AppRadius.lg),
          border: Border.all(color: AppColors.surface3),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(AppRadius.lg),
          child: _ready && _chewieController != null
              ? Chewie(controller: _chewieController!)
              : const _PreviewFallback(),
        ),
      ),
    );
  }
}

class _PreviewFallback extends StatelessWidget {
  const _PreviewFallback();

  @override
  Widget build(BuildContext context) {
    return const DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.surface2, AppColors.obsidianDark],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Center(
        child: Icon(
          Icons.play_circle_fill_rounded,
          color: AppColors.gold,
          size: 64,
        ),
      ),
    );
  }
}
