import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:video_player/video_player.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_radius.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_typography.dart';
import '../../routing/routes.dart';
import '../../shared/models/template.dart';
import '../../shared/widgets/buttons/app_button.dart';
import '../../shared/widgets/cards/app_card.dart';
import '../../shared/widgets/display/app_chip.dart';
import '../../shared/widgets/feedback/empty_state.dart';
import '../../shared/widgets/feedback/error_state.dart';
import '../../shared/widgets/navigation/app_appbar.dart';
import '../auth/providers/current_user_provider.dart';
import 'providers/template_provider.dart';

class TemplateDetailScreen extends ConsumerWidget {
  const TemplateDetailScreen({
    super.key,
    required this.templateId,
  });

  final String templateId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final template = ref.watch(templateDetailProvider(templateId));

    return Scaffold(
      key: const Key('template-detail-screen'),
      backgroundColor: AppColors.obsidian,
      appBar: AppAppBar(
        title: 'Template Detail',
        showBackButton: true,
        onBack: () => context.pop(),
      ),
      body: template.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => ErrorState(
          title: 'Template tidak bisa dibuka.',
          message: 'Coba kembali ke marketplace.',
          onRetry: () => ref.invalidate(templateDetailProvider(templateId)),
        ),
        data: (item) {
          if (item == null) {
            return const EmptyState(
              title: 'Template tidak ditemukan',
              message: 'Template ini mungkin sudah tidak tersedia.',
            );
          }

          return _TemplateDetailContent(template: item);
        },
      ),
    );
  }
}

class _TemplateDetailContent extends ConsumerWidget {
  const _TemplateDetailContent({required this.template});

  final Template template;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(currentUserProvider);
    final hasAccess = hasTemplateAccess(user, template);

    return ListView(
      padding: const EdgeInsets.all(AppSpacing.lg),
      children: [
        _VideoPreview(template: template),
        const SizedBox(height: AppSpacing.lg),
        Text(template.name, style: AppTypography.headlineLarge),
        const SizedBox(height: AppSpacing.sm),
        Text(
          template.description,
          style: AppTypography.bodyMedium.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
        const SizedBox(height: AppSpacing.lg),
        Wrap(
          spacing: AppSpacing.sm,
          runSpacing: AppSpacing.sm,
          children: [
            AppChip(label: templateCategoryLabel(template.category)),
            AppChip(label: template.difficulty.name),
            AppChip(label: '${template.structure.duration}s'),
            AppChip(
                label:
                    template.tier == TemplateTier.premium ? 'Premium' : 'Free'),
          ],
        ),
        const SizedBox(height: AppSpacing.lg),
        _RatingRow(rating: template.rating, timesUsed: template.timesUsed),
        const SizedBox(height: AppSpacing.lg),
        _StructurePreview(template: template),
        const SizedBox(height: AppSpacing.lg),
        AppButton(
          key: hasAccess
              ? const Key('template-use-button')
              : const Key('template-upgrade-button'),
          label: hasAccess ? 'Use this template' : 'Upgrade untuk Akses',
          fullWidth: true,
          icon: Icon(
            hasAccess ? Icons.auto_awesome_rounded : Icons.lock_open_rounded,
          ),
          onPressed: () async {
            if (!hasAccess) {
              context.go(AppRoutes.pricing);
              return;
            }

            final projectId =
                await ref.read(useTemplateMutationProvider)(template.id);
            if (context.mounted) {
              context.go(AppRoutes.miniEditorPath(projectId));
            }
          },
        ),
      ],
    );
  }
}

class _VideoPreview extends StatefulWidget {
  const _VideoPreview({required this.template});

  final Template template;

  @override
  State<_VideoPreview> createState() => _VideoPreviewState();
}

class _VideoPreviewState extends State<_VideoPreview> {
  VideoPlayerController? _videoController;
  ChewieController? _chewieController;
  Object? _previewError;

  bool get _canUseChewiePreview {
    final url = widget.template.previewVideoUrl;
    if (url == null || url.trim().isEmpty) {
      return false;
    }

    final uri = Uri.tryParse(url);
    if (uri == null || !uri.hasScheme || uri.host.isEmpty) {
      return false;
    }

    final isHttp = uri.scheme == 'http' || uri.scheme == 'https';
    final isMockHost = uri.host.endsWith('.test');
    return isHttp && !isMockHost;
  }

  @override
  void initState() {
    super.initState();
    _initializePreview();
  }

  Future<void> _initializePreview() async {
    if (!_canUseChewiePreview) {
      return;
    }

    final uri = Uri.parse(widget.template.previewVideoUrl!);
    final videoController = VideoPlayerController.networkUrl(uri);
    _videoController = videoController;

    try {
      await videoController.initialize();
      if (!mounted) {
        return;
      }

      setState(() {
        _chewieController = ChewieController(
          videoPlayerController: videoController,
          autoPlay: true,
          looping: true,
          showControls: false,
          allowFullScreen: true,
          aspectRatio: 9 / 16,
          errorBuilder: (context, errorMessage) {
            return _PreviewFallback(
              message: 'Preview video belum tersedia.',
              detail: errorMessage,
            );
          },
        );
      });
    } catch (error) {
      if (!mounted) {
        return;
      }

      setState(() {
        _previewError = error;
      });
    }
  }

  @override
  void dispose() {
    _chewieController?.dispose();
    _videoController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 320),
        child: AspectRatio(
          aspectRatio: 9 / 16,
          child: DecoratedBox(
            key: const Key('template-video-preview'),
            decoration: BoxDecoration(
              color: AppColors.surface1,
              borderRadius: BorderRadius.circular(AppRadius.lg),
              border: Border.all(color: AppColors.surface3),
              gradient: const LinearGradient(
                colors: [AppColors.surface2, AppColors.obsidianDark],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(AppRadius.lg),
              child: _buildPreview(),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPreview() {
    final chewieController = _chewieController;
    if (chewieController != null) {
      return Chewie(
        key: const Key('template-chewie-preview'),
        controller: chewieController,
      );
    }

    if (_canUseChewiePreview && _previewError == null) {
      return const Center(
        child: CircularProgressIndicator(color: AppColors.gold),
      );
    }

    return _PreviewFallback(
      message: _canUseChewiePreview
          ? 'Preview video belum tersedia.'
          : 'Chewie autoplay siap untuk URL video nyata.',
      detail: widget.template.previewVideoUrl ?? 'Mock preview template',
    );
  }
}

class _PreviewFallback extends StatelessWidget {
  const _PreviewFallback({
    required this.message,
    required this.detail,
  });

  final String message;
  final String detail;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        const Icon(
          Icons.play_circle_fill_rounded,
          color: AppColors.gold,
          size: 68,
        ),
        Positioned(
          left: AppSpacing.md,
          right: AppSpacing.md,
          bottom: AppSpacing.md,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                message,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: AppTypography.labelMedium.copyWith(
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: AppSpacing.xs),
              Text(
                detail,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: AppTypography.bodySmall.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _RatingRow extends StatelessWidget {
  const _RatingRow({
    required this.rating,
    required this.timesUsed,
  });

  final double rating;
  final int timesUsed;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        for (var index = 0; index < 5; index++)
          Icon(
            index < rating.floor()
                ? Icons.star_rounded
                : Icons.star_border_rounded,
            color: AppColors.gold,
            size: 22,
          ),
        const SizedBox(width: AppSpacing.sm),
        Text(
          rating.toStringAsFixed(1),
          style: AppTypography.labelLarge,
        ),
        const Spacer(),
        Text(
          '$timesUsed uses',
          style: AppTypography.bodySmall.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }
}

class _StructurePreview extends StatelessWidget {
  const _StructurePreview({required this.template});

  final Template template;

  @override
  Widget build(BuildContext context) {
    final duration = template.structure.duration;
    final hook = (duration * 0.15).round().clamp(3, 8);
    final cta = (duration * 0.15).round().clamp(4, 10);
    final body = (duration - hook - cta).clamp(1, duration);

    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Structure preview', style: AppTypography.headlineSmall),
          const SizedBox(height: AppSpacing.md),
          _StructureBar(hook: hook, body: body, cta: cta),
          const SizedBox(height: AppSpacing.lg),
          _InfoLine(
            label: 'Transitions',
            value: template.structure.transitions.join(', '),
          ),
          _InfoLine(
            label: 'Music',
            value: template.structure.music.join(', '),
          ),
          _InfoLine(
            label: 'Hooks',
            value: template.structure.hooks.join(', '),
          ),
        ],
      ),
    );
  }
}

class _StructureBar extends StatelessWidget {
  const _StructureBar({
    required this.hook,
    required this.body,
    required this.cta,
  });

  final int hook;
  final int body;
  final int cta;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(AppRadius.pill),
          child: Row(
            children: [
              Expanded(
                flex: hook,
                child: const ColoredBox(
                  color: AppColors.gold,
                  child: SizedBox(height: 12),
                ),
              ),
              Expanded(
                flex: body,
                child: const ColoredBox(
                  color: AppColors.info,
                  child: SizedBox(height: 12),
                ),
              ),
              Expanded(
                flex: cta,
                child: const ColoredBox(
                  color: AppColors.success,
                  child: SizedBox(height: 12),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        Row(
          children: [
            Expanded(
                child: Text('Hook ${hook}s', style: AppTypography.labelSmall)),
            Expanded(
              child: Text(
                'Body ${body}s',
                textAlign: TextAlign.center,
                style: AppTypography.labelSmall,
              ),
            ),
            Expanded(
              child: Text(
                'CTA ${cta}s',
                textAlign: TextAlign.end,
                style: AppTypography.labelSmall,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _InfoLine extends StatelessWidget {
  const _InfoLine({
    required this.label,
    required this.value,
  });

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.sm),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 96,
            child: Text(
              label,
              style: AppTypography.labelMedium.copyWith(
                color: AppColors.gold,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value.isEmpty ? '-' : value,
              style: AppTypography.bodySmall.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
