import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_radius.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared/models/template.dart';
import '../../../shared/widgets/buttons/app_button.dart';
import '../../../shared/widgets/cards/app_card.dart';

class PodcastSplitCard extends StatelessWidget {
  const PodcastSplitCard({
    super.key,
    this.template,
    this.onTap,
  });

  final Template? template;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      key: const Key('podcast-split-card'),
      variant: AppCardVariant.premiumGold,
      onTap: onTap,
      child: Row(
        children: [
          DecoratedBox(
            decoration: BoxDecoration(
              color: AppColors.goldGlow,
              borderRadius: BorderRadius.circular(AppRadius.lg),
            ),
            child: const Padding(
              padding: EdgeInsets.all(AppSpacing.md),
              child: Icon(
                Icons.mic_external_on_rounded,
                color: AppColors.gold,
                size: 34,
              ),
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Podcast Split', style: AppTypography.headlineSmall),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  'Convert episode podcast jadi 5-10 shorts otomatis',
                  style: AppTypography.bodySmall.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: AppSpacing.sm),
                Text(
                  'Mock flow: upload audio -> detect highlights -> pilih kandidat',
                  style: AppTypography.labelSmall.copyWith(
                    color: AppColors.gold,
                  ),
                ),
              ],
            ),
          ),
          const Icon(Icons.chevron_right_rounded, color: AppColors.gold),
        ],
      ),
    );
  }
}

class PodcastSplitMockScreen extends StatefulWidget {
  const PodcastSplitMockScreen({
    super.key,
    required this.template,
  });

  final Template template;

  @override
  State<PodcastSplitMockScreen> createState() => _PodcastSplitMockScreenState();
}

class _PodcastSplitMockScreenState extends State<PodcastSplitMockScreen> {
  bool _generated = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: const Key('podcast-split-mock-screen'),
      backgroundColor: AppColors.obsidian,
      appBar: AppBar(
        title: const Text('Podcast Split'),
        backgroundColor: AppColors.obsidian,
      ),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        children: [
          PodcastSplitCard(template: widget.template),
          const SizedBox(height: AppSpacing.lg),
          AppButton(
            key: const Key('podcast-upload-audio'),
            label: _generated ? 'Regenerate highlights' : 'Upload audio',
            icon: const Icon(Icons.upload_file_rounded),
            onPressed: () => setState(() => _generated = true),
          ),
          if (_generated) ...[
            const SizedBox(height: AppSpacing.lg),
            Text('Short candidates', style: AppTypography.headlineSmall),
            const SizedBox(height: AppSpacing.md),
            for (var index = 0; index < 6; index++)
              Padding(
                padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                child: AppCard(
                  child: Row(
                    children: [
                      Text(
                        '#${index + 1}',
                        style: AppTypography.headlineSmall.copyWith(
                          color: AppColors.gold,
                        ),
                      ),
                      const SizedBox(width: AppSpacing.md),
                      Expanded(
                        child: Text(
                          'Highlight ${(index + 1) * 12}s - strong dialog turn',
                          style: AppTypography.bodySmall,
                        ),
                      ),
                      const Icon(
                        Icons.check_circle_outline_rounded,
                        color: AppColors.gold,
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ],
      ),
    );
  }
}
