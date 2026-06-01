import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_radius.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../models/template_model.dart';

class TemplateVideoPlayer extends StatefulWidget {
  const TemplateVideoPlayer({super.key, required this.template});

  final TemplateModel template;

  @override
  State<TemplateVideoPlayer> createState() => _TemplateVideoPlayerState();
}

class _TemplateVideoPlayerState extends State<TemplateVideoPlayer> {
  VideoPlayerController? _controller;
  Object? _error;

  bool get _hasVideo => widget.template.previewVideoUrl.trim().isNotEmpty;

  @override
  void initState() {
    super.initState();
    _initialize();
  }

  Future<void> _initialize() async {
    if (!_hasVideo) {
      return;
    }

    final uri = Uri.tryParse(widget.template.previewVideoUrl);
    if (uri == null || !uri.hasScheme) {
      return;
    }

    final controller = VideoPlayerController.networkUrl(uri);
    _controller = controller;
    try {
      await controller.initialize();
      await controller.setVolume(0);
      await controller.setLooping(true);
      await controller.play();
      if (mounted) {
        setState(() {});
      }
    } catch (error) {
      if (mounted) {
        setState(() => _error = error);
      }
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = _controller;

    return GestureDetector(
      key: const Key('template-video-player'),
      onTap: () {
        if (controller == null || !controller.value.isInitialized) {
          return;
        }
        setState(() {
          controller.value.isPlaying ? controller.pause() : controller.play();
        });
      },
      child: Stack(
        fit: StackFit.expand,
        children: [
          if (controller != null && controller.value.isInitialized)
            FittedBox(
              fit: BoxFit.cover,
              child: SizedBox(
                width: controller.value.size.width,
                height: controller.value.size.height,
                child: VideoPlayer(controller),
              ),
            )
          else
            _PlaceholderPreview(
              thumbnailUrl: widget.template.thumbnailUrl,
              error: _error,
            ),
          const Positioned(
            right: AppSpacing.md,
            bottom: AppSpacing.md,
            child: _PreviewBadge(),
          ),
          if (!_hasVideo)
            const Center(
              child: _ComingSoonOverlay(),
            ),
        ],
      ),
    );
  }
}

class _PlaceholderPreview extends StatelessWidget {
  const _PlaceholderPreview({required this.thumbnailUrl, this.error});

  final String thumbnailUrl;
  final Object? error;

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        CachedNetworkImage(
          imageUrl: thumbnailUrl,
          fit: BoxFit.cover,
          placeholder: (context, url) => const _GradientFallback(),
          errorWidget: (context, url, error) => const _GradientFallback(),
        ),
        const DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0x66000000), Color(0xCC050608)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
        if (error != null)
          Positioned(
            left: AppSpacing.md,
            right: AppSpacing.md,
            bottom: 76,
            child: Text(
              'Preview video belum tersedia.',
              textAlign: TextAlign.center,
              style: AppTypography.bodySmall.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
          ),
      ],
    );
  }
}

class _GradientFallback extends StatelessWidget {
  const _GradientFallback();

  @override
  Widget build(BuildContext context) {
    return const DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.surface2, AppColors.obsidianDark],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Center(
        child: Icon(Icons.play_circle_fill_rounded,
            color: AppColors.gold, size: 72),
      ),
    );
  }
}

class _PreviewBadge extends StatelessWidget {
  const _PreviewBadge();

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.glassBlack,
        borderRadius: BorderRadius.circular(AppRadius.pill),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.sm,
          vertical: AppSpacing.xs,
        ),
        child: Text(
          'Preview only',
          style:
              AppTypography.labelSmall.copyWith(color: AppColors.textPrimary),
        ),
      ),
    );
  }
}

class _ComingSoonOverlay extends StatelessWidget {
  const _ComingSoonOverlay();

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      key: const Key('template-preview-coming-soon'),
      decoration: BoxDecoration(
        color: AppColors.glassBlack,
        borderRadius: BorderRadius.circular(AppRadius.lg),
        border: Border.all(color: AppColors.gold),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Text(
          'Coming soon',
          style: AppTypography.headlineSmall.copyWith(color: AppColors.gold),
        ),
      ),
    );
  }
}
