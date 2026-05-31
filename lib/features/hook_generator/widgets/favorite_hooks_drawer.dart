import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared/models/script.dart';
import '../../../shared/widgets/buttons/app_button.dart';
import '../../../shared/widgets/feedback/empty_state.dart';
import '../providers/hook_provider.dart';

class FavoriteHooksDrawer extends StatelessWidget {
  const FavoriteHooksDrawer({
    super.key,
    required this.hooks,
    required this.onDelete,
    required this.onUse,
  });

  final List<HookOption> hooks;
  final ValueChanged<String> onDelete;
  final ValueChanged<HookOption> onUse;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppColors.surface1,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Favorite Hooks', style: AppTypography.headlineMedium),
              const SizedBox(height: AppSpacing.sm),
              Text(
                'Swipe hook ke kiri untuk hapus dari favorit.',
                style: AppTypography.bodySmall.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: AppSpacing.lg),
              Expanded(
                child: hooks.isEmpty
                    ? const EmptyState(
                        title: 'Belum ada favorit',
                        message: 'Simpan hook terbaik untuk dipakai nanti.',
                      )
                    : ListView.separated(
                        itemCount: hooks.length,
                        separatorBuilder: (_, __) =>
                            const SizedBox(height: AppSpacing.md),
                        itemBuilder: (context, index) {
                          final hook = hooks[index];
                          return Dismissible(
                            key: ValueKey('favorite-hook-${hook.id}'),
                            direction: DismissDirection.endToStart,
                            background: const ColoredBox(
                              color: AppColors.error,
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Padding(
                                  padding:
                                      EdgeInsets.only(right: AppSpacing.lg),
                                  child: Icon(
                                    Icons.delete_rounded,
                                    color: AppColors.textPrimary,
                                  ),
                                ),
                              ),
                            ),
                            onDismissed: (_) => onDelete(hook.id),
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                color: AppColors.surface2,
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(color: AppColors.surface3),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(AppSpacing.md),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      hookStyleLabel(hook.style),
                                      style: AppTypography.labelSmall.copyWith(
                                        color: AppColors.gold,
                                      ),
                                    ),
                                    const SizedBox(height: AppSpacing.sm),
                                    Text(
                                      hook.text,
                                      style: AppTypography.bodyMedium,
                                    ),
                                    const SizedBox(height: AppSpacing.md),
                                    AppButton(
                                      label: 'Use this',
                                      size: AppButtonSize.sm,
                                      fullWidth: true,
                                      onPressed: () => onUse(hook),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
