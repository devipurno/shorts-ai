import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:share_plus/share_plus.dart';

import '../../../core/constants/asset_paths.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../routing/routes.dart';
import '../../../shared/widgets/buttons/app_button.dart';
import '../providers/editor_provider.dart';
import '../services/ffmpeg_service.dart';

class ExportProgressDialog extends ConsumerStatefulWidget {
  const ExportProgressDialog({
    super.key,
    required this.videoId,
  });

  final String videoId;

  @override
  ConsumerState<ExportProgressDialog> createState() =>
      _ExportProgressDialogState();
}

class _ExportProgressDialogState extends ConsumerState<ExportProgressDialog> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(editorProvider(widget.videoId).notifier).export();
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(editorProvider(widget.videoId));
    final done = state.outputPath != null && !state.isExporting;

    return Scaffold(
      key: const Key('export-progress-dialog'),
      backgroundColor: AppColors.obsidian,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.xl),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Spacer(),
              SizedBox.square(
                dimension: 180,
                child: Lottie.asset(
                  done ? AssetPaths.successAnim : AssetPaths.splashLoader,
                  repeat: !done,
                ),
              ),
              const SizedBox(height: AppSpacing.xl),
              Text(
                done ? 'Export selesai' : 'Rendering shorts...',
                textAlign: TextAlign.center,
                style: AppTypography.headlineMedium,
              ),
              const SizedBox(height: AppSpacing.md),
              LinearProgressIndicator(
                value: state.exportProgress / 100,
                color: AppColors.gold,
                backgroundColor: AppColors.surface3,
              ),
              const SizedBox(height: AppSpacing.sm),
              Text(
                '${state.exportProgress}%',
                textAlign: TextAlign.center,
                style: AppTypography.labelLarge.copyWith(
                  color: AppColors.gold,
                ),
              ),
              if (done) ...[
                const SizedBox(height: AppSpacing.lg),
                Container(
                  height: 144,
                  decoration: BoxDecoration(
                    color: AppColors.surface1,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: AppColors.surface3),
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.movie_filter_rounded,
                      color: AppColors.gold,
                      size: 44,
                    ),
                  ),
                ),
              ],
              const Spacer(),
              if (done)
                Row(
                  children: [
                    Expanded(
                      child: AppButton(
                        label: 'Lihat di Library',
                        onPressed: () {
                          Navigator.of(context).pop();
                          context.go(AppRoutes.library);
                        },
                      ),
                    ),
                    const SizedBox(width: AppSpacing.md),
                    Expanded(
                      child: AppButton(
                        label: 'Bagikan',
                        variant: AppButtonVariant.secondary,
                        onPressed: () => SharePlus.instance.share(
                          ShareParams(text: state.outputPath!),
                        ),
                      ),
                    ),
                  ],
                )
              else
                AppButton(
                  label: 'Cancel',
                  variant: AppButtonVariant.secondary,
                  onPressed: () {
                    ref.read(ffmpegServiceProvider).cancel();
                    Navigator.of(context).pop();
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }
}
