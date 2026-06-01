import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_typography.dart';
import '../../shared/widgets/buttons/app_button.dart';
import '../../shared/widgets/display/app_chip.dart';
import '../../shared/widgets/feedback/empty_state.dart';
import '../../shared/widgets/feedback/error_state.dart';
import '../../shared/widgets/navigation/app_appbar.dart';
import 'models/template_model.dart';
import 'providers/template_provider.dart';
import 'widgets/premium_tease_button.dart';
import 'widgets/template_video_player.dart';

class TemplateDetailScreen extends ConsumerWidget {
  const TemplateDetailScreen({
    super.key,
    required this.templateId,
  });

  final String templateId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final template = ref.watch(templateModelByIdProvider(templateId));

    return Scaffold(
      key: const Key('template-detail-screen'),
      backgroundColor: AppColors.obsidian,
      appBar: AppAppBar(
        title: 'Template Preview',
        showBackButton: true,
        onBack: () => context.pop(),
      ),
      body: template.when(
        loading: () => const Center(
          child: CircularProgressIndicator(color: AppColors.gold),
        ),
        error: (error, stackTrace) => ErrorState(
          title: 'Template tidak bisa dibuka.',
          message: 'Coba kembali ke gallery template.',
          onRetry: () => ref.invalidate(templateModelByIdProvider(templateId)),
        ),
        data: (item) {
          if (item == null) {
            return const EmptyState(
              title: 'Template tidak ditemukan',
              message: 'Template ini mungkin belum tersedia di gallery.',
            );
          }

          return _TemplateDetailContent(template: item);
        },
      ),
    );
  }
}

class _TemplateDetailContent extends StatelessWidget {
  const _TemplateDetailContent({required this.template});

  final TemplateModel template;

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        TemplateVideoPlayer(template: template),
        const DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xCC050608),
                Colors.transparent,
                Color(0xE6050608)
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [0, 0.42, 1],
            ),
          ),
        ),
        Positioned(
          left: AppSpacing.lg,
          right: AppSpacing.lg,
          top: AppSpacing.lg,
          child: _TemplateHeading(template: template),
        ),
        Positioned(
          left: AppSpacing.lg,
          right: AppSpacing.lg,
          bottom: AppSpacing.lg,
          child: _ActionBar(template: template),
        ),
      ],
    );
  }
}

class _TemplateHeading extends StatelessWidget {
  const _TemplateHeading({required this.template});

  final TemplateModel template;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(template.name, style: AppTypography.headlineLarge),
        const SizedBox(height: AppSpacing.sm),
        Text(
          template.description,
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
          style: AppTypography.bodyMedium.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        Wrap(
          spacing: AppSpacing.sm,
          runSpacing: AppSpacing.sm,
          children: [
            AppChip(label: template.category),
            AppChip(label: '${template.duration.inSeconds}s'),
            for (final tag in template.tags) AppChip(label: tag),
          ],
        ),
      ],
    );
  }
}

class _ActionBar extends StatelessWidget {
  const _ActionBar({required this.template});

  final TemplateModel template;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.glassBlack,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.glassWhite),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AppButton(
              key: const Key('template-use-button'),
              label: 'Pakai Template',
              fullWidth: true,
              icon: const Icon(Icons.auto_awesome_rounded),
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Coming soon')),
                );
              },
            ),
            const SizedBox(height: AppSpacing.sm),
            const PremiumTeaseButton(
              key: Key('template-customize-button'),
              label: 'Customize',
              teaseText: 'Coming v0.2.x',
              icon: Icons.tune_rounded,
            ),
            const SizedBox(height: AppSpacing.sm),
            const PremiumTeaseButton(
              key: Key('template-share-button'),
              label: 'Share preview',
              teaseText: 'Coming v0.2.x',
              icon: Icons.ios_share_rounded,
            ),
          ],
        ),
      ),
    );
  }
}
