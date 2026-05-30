import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_radius.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared/models/project.dart';
import '../../../shared/widgets/cards/app_card.dart';
import '../../../shared/widgets/display/app_chip.dart';

class LibraryProjectCard extends StatelessWidget {
  const LibraryProjectCard({
    super.key,
    required this.project,
    this.onTap,
  });

  final Project project;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      key: Key('library-project-card-${project.id}'),
      padding: EdgeInsets.zero,
      onTap: onTap,
      child: Row(
        children: [
          SizedBox(
            width: 118,
            child: AspectRatio(
              aspectRatio: 16 / 9,
              child: ClipRRect(
                borderRadius: const BorderRadius.horizontal(
                  left: Radius.circular(AppRadius.md),
                ),
                child: _Thumbnail(url: project.thumbnailUrl),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          project.title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppTypography.labelLarge,
                        ),
                      ),
                      const SizedBox(width: AppSpacing.sm),
                      AppChip(
                        label: _statusLabel(project.status),
                        variant: AppChipVariant.tag,
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Text(
                    project.description.isEmpty
                        ? 'Belum ada deskripsi project.'
                        : project.description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: AppTypography.bodySmall.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Wrap(
                    spacing: AppSpacing.md,
                    runSpacing: AppSpacing.xs,
                    children: [
                      _Meta(
                        icon: Icons.schedule_rounded,
                        label: _durationLabel(project.duration),
                      ),
                      _Meta(
                        icon: Icons.stay_current_portrait_rounded,
                        label: project.aspectRatio,
                      ),
                      _Meta(
                        icon: Icons.update_rounded,
                        label: _dateLabel(project.updatedAt),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _statusLabel(ProjectStatus status) {
    return switch (status) {
      ProjectStatus.draft => 'Draft',
      ProjectStatus.processing => 'Proses',
      ProjectStatus.ready => 'Siap',
      ProjectStatus.published => 'Live',
    };
  }

  String _durationLabel(int seconds) {
    final minutes = seconds ~/ 60;
    final remainingSeconds = seconds % 60;
    return '$minutes:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  String _dateLabel(DateTime value) {
    return '${value.day.toString().padLeft(2, '0')}/'
        '${value.month.toString().padLeft(2, '0')}';
  }
}

class _Thumbnail extends StatelessWidget {
  const _Thumbnail({required this.url});

  final String? url;

  @override
  Widget build(BuildContext context) {
    if (url == null || url!.isEmpty) {
      return const _ThumbnailFallback();
    }

    return CachedNetworkImage(
      imageUrl: url!,
      fit: BoxFit.cover,
      placeholder: (context, url) => const _ThumbnailFallback(),
      errorWidget: (context, url, error) => const _ThumbnailFallback(),
    );
  }
}

class _ThumbnailFallback extends StatelessWidget {
  const _ThumbnailFallback();

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.goldDark, AppColors.surface2],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: const Center(
        child: Icon(
          Icons.movie_filter_rounded,
          color: AppColors.goldLight,
          size: 28,
        ),
      ),
    );
  }
}

class _Meta extends StatelessWidget {
  const _Meta({
    required this.icon,
    required this.label,
  });

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 14, color: AppColors.textTertiary),
        const SizedBox(width: AppSpacing.xs),
        Text(label, style: AppTypography.bodySmall),
      ],
    );
  }
}
