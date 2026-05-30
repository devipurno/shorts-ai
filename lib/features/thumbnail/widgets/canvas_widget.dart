import 'package:flutter/material.dart';
import 'package:screenshot/screenshot.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_radius.dart';
import '../../../core/theme/app_spacing.dart';
import '../providers/thumbnail_provider.dart';
import 'sticker_layer.dart';
import 'text_layer.dart';

class ThumbnailCanvasWidget extends StatefulWidget {
  const ThumbnailCanvasWidget({
    super.key,
    required this.canvas,
    required this.screenshotController,
    required this.onLayerChanged,
    required this.onTextEditRequested,
  });

  final ThumbnailCanvasData canvas;
  final ScreenshotController screenshotController;
  final ValueChanged<ThumbnailLayer> onLayerChanged;
  final ValueChanged<ThumbnailLayer> onTextEditRequested;

  @override
  State<ThumbnailCanvasWidget> createState() => _ThumbnailCanvasWidgetState();
}

class _ThumbnailCanvasWidgetState extends State<ThumbnailCanvasWidget> {
  @override
  Widget build(BuildContext context) {
    return InteractiveViewer(
      key: const Key('thumbnail-canvas-interactive'),
      minScale: 0.75,
      maxScale: 3,
      child: Center(
        child: AspectRatio(
          aspectRatio: widget.canvas.aspect.ratio,
          child: Screenshot(
            controller: widget.screenshotController,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(AppRadius.lg),
              child: _CanvasBackground(
                canvas: widget.canvas,
                onLayerChanged: widget.onLayerChanged,
                onTextEditRequested: widget.onTextEditRequested,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _CanvasBackground extends StatelessWidget {
  const _CanvasBackground({
    required this.canvas,
    required this.onLayerChanged,
    required this.onTextEditRequested,
  });

  final ThumbnailCanvasData canvas;
  final ValueChanged<ThumbnailLayer> onLayerChanged;
  final ValueChanged<ThumbnailLayer> onTextEditRequested;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.surface1,
        border: Border.all(color: AppColors.surface3),
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          _BaseFrame(canvas: canvas),
          if (canvas.aiImageBytes != null)
            Image.memory(canvas.aiImageBytes!, fit: BoxFit.cover),
          DecoratedBox(
            decoration: BoxDecoration(
              gradient: _gradient(canvas.gradientIndex.round()),
            ),
          ),
          if (canvas.overlayOpacity > 0)
            ColoredBox(
              color:
                  canvas.colorOverlay.withValues(alpha: canvas.overlayOpacity),
            ),
          for (final layer in canvas.layers)
            if (layer.type == ThumbnailLayerType.text)
              TextLayerWidget(
                key: Key('thumbnail-layer-${layer.id}'),
                layer: layer,
                onChanged: onLayerChanged,
                onEditRequested: () => onTextEditRequested(layer),
              )
            else
              StickerLayerWidget(
                key: Key('thumbnail-layer-${layer.id}'),
                layer: layer,
                onChanged: onLayerChanged,
              ),
        ],
      ),
    );
  }

  LinearGradient _gradient(int index) {
    final gradients = [
      const LinearGradient(
        colors: [Color(0x22000000), Color(0xAA000000)],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      const LinearGradient(
        colors: [Color(0x33D4AF37), Color(0xAA0B0C10)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      const LinearGradient(
        colors: [Color(0x6626262D), Color(0x661A1B22)],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      ),
    ];
    return gradients[index.clamp(0, gradients.length - 1)];
  }
}

class _BaseFrame extends StatelessWidget {
  const _BaseFrame({required this.canvas});

  final ThumbnailCanvasData canvas;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: _frameColors(canvas.baseFrameId),
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Align(
          alignment: Alignment.topLeft,
          child: Text(
            canvas.aiImageLabel ?? canvas.baseFrameLabel,
            style: const TextStyle(
              color: AppColors.textTertiary,
              fontSize: 13,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }

  List<Color> _frameColors(String id) {
    final seed = id.hashCode.abs() % 5;
    return switch (seed) {
      0 => const [Color(0xFF12131A), Color(0xFFD4AF37)],
      1 => const [Color(0xFF050608), Color(0xFF60A5FA)],
      2 => const [Color(0xFF26272D), Color(0xFFEF4444)],
      3 => const [Color(0xFF1A1B22), Color(0xFF4ADE80)],
      _ => const [Color(0xFF0B0C10), Color(0xFFAA8826)],
    };
  }
}
