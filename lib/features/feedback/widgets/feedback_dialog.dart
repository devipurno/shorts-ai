import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_radius.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared/widgets/buttons/app_button.dart';
import '../models/feedback_category.dart';
import '../services/sentry_feedback_service.dart';

class FeedbackDialog extends ConsumerStatefulWidget {
  const FeedbackDialog({super.key});

  @override
  ConsumerState<FeedbackDialog> createState() => _FeedbackDialogState();
}

class _FeedbackDialogState extends ConsumerState<FeedbackDialog> {
  final _messageController = TextEditingController();
  final _emailController = TextEditingController();
  FeedbackCategory? _category;
  bool _isSubmitting = false;

  bool get _canSubmit =>
      _category != null && _messageController.text.trim().isNotEmpty;

  @override
  void dispose() {
    _messageController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = math.min(400.0, MediaQuery.sizeOf(context).width - 32);

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.all(AppSpacing.lg),
      child: ConstrainedBox(
        key: const Key('feedback-dialog'),
        constraints: BoxConstraints(maxWidth: width),
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: AppColors.surface1,
            border: Border.all(color: AppColors.gold),
            borderRadius: BorderRadius.circular(AppRadius.md),
          ),
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.xl),
            child: SingleChildScrollView(
              child: Column(
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
                  Wrap(
                    spacing: AppSpacing.sm,
                    runSpacing: AppSpacing.sm,
                    children: [
                      for (final category in FeedbackCategory.values)
                        ChoiceChip(
                          key: Key('feedback-category-${category.name}'),
                          label: Text('${category.emoji} ${category.label}'),
                          selected: _category == category,
                          selectedColor: AppColors.gold,
                          backgroundColor: AppColors.surface2,
                          labelStyle: AppTypography.labelMedium.copyWith(
                            color: _category == category
                                ? AppColors.textInverse
                                : AppColors.textPrimary,
                          ),
                          side: BorderSide(
                            color: _category == category
                                ? AppColors.gold
                                : AppColors.surface3,
                          ),
                          onSelected: (_) => setState(() {
                            _category = category;
                          }),
                        ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  TextField(
                    key: const Key('feedback-message-field'),
                    controller: _messageController,
                    minLines: 4,
                    maxLines: 6,
                    onChanged: (_) => setState(() {}),
                    decoration: const InputDecoration(
                      hintText: 'Ceritakan pengalaman Anda...',
                    ),
                  ),
                  const SizedBox(height: AppSpacing.md),
                  TextField(
                    key: const Key('feedback-email-field'),
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      hintText: 'Email (opsional, untuk balasan)',
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xl),
                  Row(
                    children: [
                      Expanded(
                        child: TextButton(
                          key: const Key('feedback-cancel-button'),
                          onPressed: _isSubmitting
                              ? null
                              : () => Navigator.of(context).pop(),
                          child: const Text('Batal'),
                        ),
                      ),
                      const SizedBox(width: AppSpacing.md),
                      Expanded(
                        child: AppButton(
                          key: const Key('feedback-submit-button'),
                          label: 'Kirim',
                          isLoading: _isSubmitting,
                          onPressed: _canSubmit && !_isSubmitting
                              ? _submitFeedback
                              : null,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _submitFeedback() async {
    final category = _category;
    if (category == null || !_canSubmit) {
      return;
    }

    setState(() => _isSubmitting = true);
    final messenger = ScaffoldMessenger.of(context);
    final navigator = Navigator.of(context);
    await ref.read(sentryFeedbackServiceProvider).submit(
          category: category,
          message: _messageController.text,
          userEmail: _emailController.text,
        );

    if (!mounted) {
      return;
    }
    navigator.pop();
    messenger.showSnackBar(
      const SnackBar(
        key: Key('feedback-success-snackbar'),
        duration: Duration(seconds: 3),
        content: Text('Feedback terkirim, terima kasih! 💙'),
      ),
    );
  }
}
