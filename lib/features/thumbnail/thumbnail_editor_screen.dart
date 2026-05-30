import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:screenshot/screenshot.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_typography.dart';
import '../../shared/models/thumbnail.dart';
import 'providers/thumbnail_provider.dart';
import 'tabs/ai_generate_tab.dart';
import 'tabs/color_tab.dart';
import 'tabs/ctr_predict_tab.dart';
import 'tabs/frame_picker_tab.dart';
import 'tabs/save_tab.dart';
import 'tabs/sticker_tab.dart';
import 'tabs/text_tab.dart';
import 'widgets/canvas_widget.dart';

class ThumbnailEditorScreen extends ConsumerStatefulWidget {
  const ThumbnailEditorScreen({
    super.key,
    required this.videoId,
  });

  final String videoId;

  @override
  ConsumerState<ThumbnailEditorScreen> createState() =>
      _ThumbnailEditorScreenState();
}

class _ThumbnailEditorScreenState extends ConsumerState<ThumbnailEditorScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  final _screenshotController = ScreenshotController();
  ThumbnailEditorTool _selectedTool = ThumbnailEditorTool.frame;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: ThumbnailEditorTool.values.length,
      vsync: this,
    )..addListener(() {
        if (_tabController.indexIsChanging) {
          setState(
            () => _selectedTool =
                ThumbnailEditorTool.values[_tabController.index],
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
    final state = ref.watch(thumbnailEditorProvider(widget.videoId));
    final notifier = ref.read(thumbnailEditorProvider(widget.videoId).notifier);
    final canvas = notifier.selectedCanvas;

    return Scaffold(
      key: const Key('thumbnail-editor-screen'),
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
            Text('Thumbnail Editor', style: AppTypography.headlineSmall),
            Text(
              state.isSaved ? 'Saved' : 'Unsaved changes',
              style: AppTypography.labelSmall.copyWith(
                color: state.isSaved ? AppColors.success : AppColors.gold,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            tooltip: 'Capture canvas',
            onPressed: () => _screenshotController.capture(),
            icon: const Icon(Icons.camera_alt_rounded),
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
              child: Row(
                children: [
                  Expanded(
                      child: _VariantToggle(state: state, notifier: notifier)),
                  const SizedBox(width: AppSpacing.md),
                  SegmentedButton<ThumbnailCanvasAspect>(
                    segments: [
                      for (final aspect in ThumbnailCanvasAspect.values)
                        ButtonSegment(value: aspect, label: Text(aspect.label)),
                    ],
                    selected: {canvas.aspect},
                    onSelectionChanged: (value) =>
                        notifier.setAspect(value.first),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 7,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
                child: ThumbnailCanvasWidget(
                  canvas: canvas,
                  screenshotController: _screenshotController,
                  onLayerChanged: notifier.updateLayer,
                  onTextEditRequested: (layer) {
                    _showTextEditDialog(context, layer, notifier);
                  },
                ),
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
                key: const Key('thumbnail-toolbar-tabs'),
                controller: _tabController,
                isScrollable: true,
                tabAlignment: TabAlignment.start,
                labelColor: AppColors.gold,
                unselectedLabelColor: AppColors.textSecondary,
                indicatorColor: AppColors.gold,
                tabs: [
                  for (final tool in ThumbnailEditorTool.values)
                    Tab(
                      key: Key('thumbnail-tab-button-${tool.name}'),
                      text: tool.label,
                    ),
                ],
              ),
            ),
            Expanded(
              flex: 5,
              child: switch (_selectedTool) {
                ThumbnailEditorTool.frame =>
                  FramePickerTab(state: state, notifier: notifier),
                ThumbnailEditorTool.text =>
                  TextTab(state: state, notifier: notifier),
                ThumbnailEditorTool.sticker =>
                  StickerTab(state: state, notifier: notifier),
                ThumbnailEditorTool.color =>
                  ColorTab(state: state, notifier: notifier),
                ThumbnailEditorTool.aiGenerate =>
                  AiGenerateTab(state: state, notifier: notifier),
                ThumbnailEditorTool.ctrPredict =>
                  CtrPredictTab(state: state, notifier: notifier),
                ThumbnailEditorTool.save =>
                  SaveTab(state: state, notifier: notifier),
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _showTextEditDialog(
    BuildContext context,
    ThumbnailLayer layer,
    ThumbnailNotifier notifier,
  ) {
    final controller = TextEditingController(text: layer.text);
    return showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit text'),
        content: TextField(
          controller: controller,
          autofocus: true,
          decoration: const InputDecoration(labelText: 'Layer text'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              notifier
                  .updateLayer(layer.copyWith(text: controller.text.trim()));
              Navigator.of(context).pop();
            },
            child: const Text('Save'),
          ),
        ],
      ),
    ).whenComplete(controller.dispose);
  }
}

class _VariantToggle extends StatelessWidget {
  const _VariantToggle({
    required this.state,
    required this.notifier,
  });

  final ThumbnailState state;
  final ThumbnailNotifier notifier;

  @override
  Widget build(BuildContext context) {
    return SegmentedButton<ThumbnailVariant>(
      key: const Key('thumbnail-ab-toggle'),
      segments: const [
        ButtonSegment(value: ThumbnailVariant.a, label: Text('Variant A')),
        ButtonSegment(value: ThumbnailVariant.b, label: Text('Variant B')),
      ],
      selected: {state.selectedVariant},
      onSelectionChanged: (value) => notifier.switchVariant(value.first),
      style: ButtonStyle(
        foregroundColor: WidgetStateProperty.resolveWith(
          (states) => states.contains(WidgetState.selected)
              ? AppColors.textInverse
              : AppColors.gold,
        ),
        backgroundColor: WidgetStateProperty.resolveWith(
          (states) =>
              states.contains(WidgetState.selected) ? AppColors.gold : null,
        ),
      ),
    );
  }
}
