import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_typography.dart';
import '../../shared/widgets/buttons/app_button.dart';
import 'models/feedback_category.dart';
import 'services/device_context_service.dart';
import 'services/whatsapp_feedback_service.dart';

class FeedbackCategorySheet extends ConsumerWidget {
  const FeedbackCategorySheet({super.key, this.currentRoute});

  final String? currentRoute;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xl),
        child: Column(
          key: const Key('feedback-category-sheet'),
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('Kirim Feedback', style: AppTypography.headlineSmall),
            const SizedBox(height: AppSpacing.sm),
            Text(
              'Bug, saran, atau apresiasi? Kita open semua input.',
              style: AppTypography.bodyMedium.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            for (final category in FeedbackCategory.values) ...[
              _CategoryButton(
                category: category,
                onTap: () => _launchFeedback(context, ref, category),
              ),
              const SizedBox(height: AppSpacing.sm),
            ],
            const SizedBox(height: AppSpacing.sm),
            Text(
              'Yang dikirim otomatis: versi app, model device, OS, screen aktif. Lo edit pesannya sebelum kirim.',
              style: AppTypography.bodySmall.copyWith(
                color: AppColors.textTertiary,
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            AppButton(
              label: 'Batal',
              variant: AppButtonVariant.ghost,
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _launchFeedback(
    BuildContext context,
    WidgetRef ref,
    FeedbackCategory category,
  ) async {
    Navigator.of(context).pop();
    final messenger = ScaffoldMessenger.of(context);
    final deviceContext =
        await ref.read(deviceContextServiceProvider).collect();
    final launched = await ref.read(whatsappFeedbackServiceProvider).launch(
          category: category,
          deviceContext: deviceContext,
          currentRoute: currentRoute,
        );

    if (!launched) {
      messenger.showSnackBar(
        const SnackBar(
          key: Key('feedback-whatsapp-fallback-snackbar'),
          content: Text(
            'WhatsApp gak terinstall di device. Hubungi: support@autoshort.id',
          ),
        ),
      );
    }
  }
}

class _CategoryButton extends StatelessWidget {
  const _CategoryButton({required this.category, required this.onTap});

  final FeedbackCategory category;
  final VoidCallback onTap;

  String get _label {
    return switch (category) {
      FeedbackCategory.bug => 'Lapor Bug',
      FeedbackCategory.feature => 'Saran Fitur',
      FeedbackCategory.praise => 'Apresiasi',
    };
  }

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      key: Key('feedback-category-${category.name}'),
      onPressed: onTap,
      icon: Text(category.emoji, style: const TextStyle(fontSize: 18)),
      label: Text(_label),
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.textPrimary,
        side: const BorderSide(color: AppColors.surface3),
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.lg,
          vertical: AppSpacing.md,
        ),
        alignment: Alignment.centerLeft,
      ),
    );
  }
}
