import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_radius.dart';
import '../../core/theme/app_shadows.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_typography.dart';
import '../../routing/routes.dart';
import '../../shared/models/user.dart' as shared_user;
import '../../shared/repositories/providers.dart';
import '../../shared/widgets/buttons/app_button.dart';
import '../../shared/widgets/cards/app_card.dart';
import '../../shared/widgets/feedback/error_state.dart';
import '../../shared/widgets/layout/app_divider.dart';
import '../../shared/widgets/modals/app_bottom_sheet.dart';
import '../../shared/widgets/modals/app_dialog.dart';
import '../auth/models/user.dart';
import '../auth/providers/auth_provider.dart';
import '../auth/providers/current_user_provider.dart';
import 'providers/profile_provider.dart';
import 'widgets/edit_profile_modal.dart';
import 'widgets/menu_item.dart';
import 'widgets/profile_header.dart';
import 'widgets/stats_row.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(currentUserProvider);
    if (user == null) {
      return const Scaffold(
        key: Key('profile-screen'),
        backgroundColor: AppColors.obsidian,
        body: Center(child: CircularProgressIndicator(color: AppColors.gold)),
      );
    }

    final stats = ref.watch(profileStatsProvider);
    final subscription = ref.watch(profileSubscriptionProvider).when(
          data: (value) => value,
          error: (error, stackTrace) => null,
          loading: () => null,
        );

    return Scaffold(
      key: const Key('profile-screen'),
      backgroundColor: AppColors.obsidian,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            ProfileHeader(
              user: user,
              onEditProfile: () => _openEditProfile(context, ref, user),
              onUpgrade: () => context.go(AppRoutes.pricing),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.lg,
                ),
                child: stats.when(
                  loading: () => const SizedBox(
                    height: 116,
                    child: Center(
                      child: CircularProgressIndicator(color: AppColors.gold),
                    ),
                  ),
                  error: (error, stackTrace) => const ErrorState(
                    title: 'Stats belum bisa dimuat.',
                    message: 'Coba buka ulang profile beberapa saat lagi.',
                  ),
                  data: (value) => StatsRow(stats: value),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(
                  AppSpacing.lg,
                  AppSpacing.xl,
                  AppSpacing.lg,
                  0,
                ),
                child: _QuickActions(),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(
                  AppSpacing.lg,
                  AppSpacing.xl,
                  AppSpacing.lg,
                  0,
                ),
                child: _MenuSection(
                  user: user,
                  billingBadge: subscription?.tier.name.toUpperCase(),
                  onLifetimeTap: () => _showLifetimeDeal(context),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(
                  AppSpacing.lg,
                  AppSpacing.xl,
                  AppSpacing.lg,
                  32,
                ),
                child: AppButton(
                  key: const Key('profile-logout-button'),
                  label: 'Logout',
                  fullWidth: true,
                  variant: AppButtonVariant.danger,
                  icon: const Icon(Icons.logout_rounded),
                  onPressed: () => _confirmLogout(context, ref),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _openEditProfile(
    BuildContext context,
    WidgetRef ref,
    User user,
  ) async {
    final result = await showEditProfileModal(context, user: user);
    if (result == null || !context.mounted) {
      return;
    }

    await ref.read(userRepositoryProvider).updateProfile(
          result.toSharedUser(
            id: user.id,
            email: user.email,
            tier: _toSharedTier(user.tier),
          ),
        );

    if (!context.mounted) {
      return;
    }
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Profile tersimpan.')),
    );
  }

  Future<void> _confirmLogout(BuildContext context, WidgetRef ref) async {
    final confirmed = await AppDialog.showConfirm(
      context,
      title: 'Yakin keluar?',
      message: 'Kamu bisa masuk lagi kapan saja.',
      confirmLabel: 'Keluar',
      cancelLabel: 'Batal',
    );
    if (confirmed != true || !context.mounted) {
      return;
    }

    await ref.read(authProvider.notifier).logout();
    if (!context.mounted) {
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        key: Key('profile-logout-snackbar'),
        content: Text('Sampai jumpa!'),
      ),
    );
    context.go(AppRoutes.login);
  }

  void _showLifetimeDeal(BuildContext context) {
    AppBottomSheet.show<void>(
      context,
      child: Column(
        key: const Key('profile-lifetime-sheet'),
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Lifetime Deal', style: AppTypography.headlineSmall),
          const SizedBox(height: AppSpacing.sm),
          Text(
            'Akses AutoShort Premium selamanya untuk 100 kreator pertama.',
            style: AppTypography.bodyMedium.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          AppButton(
            label: 'Lihat Penawaran',
            onPressed: () {
              Navigator.of(context).pop();
              context.go(AppRoutes.pricing);
            },
          ),
        ],
      ),
    );
  }

  shared_user.SubscriptionTier _toSharedTier(SubscriptionTier tier) {
    return switch (tier) {
      SubscriptionTier.free => shared_user.SubscriptionTier.free,
      SubscriptionTier.standard => shared_user.SubscriptionTier.standard,
      SubscriptionTier.premium => shared_user.SubscriptionTier.premium,
      SubscriptionTier.lifetime => shared_user.SubscriptionTier.lifetime,
    };
  }
}

class _QuickActions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      key: const Key('profile-quick-actions'),
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Quick Actions', style: AppTypography.headlineSmall),
        const SizedBox(height: AppSpacing.md),
        Row(
          children: [
            Expanded(
              child: _QuickActionCard(
                icon: Icons.query_stats_rounded,
                label: 'Lihat Analytics Detail',
                onTap: () => context.go(AppRoutes.analytics),
              ),
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: _QuickActionCard(
                icon: Icons.palette_outlined,
                label: 'Brand Kit',
                onTap: () => context.go(AppRoutes.brandKit),
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.md),
        _QuickActionCard(
          icon: Icons.calendar_month_rounded,
          label: 'Content Calendar',
          onTap: () => context.go(AppRoutes.contentCalendar),
        ),
      ],
    );
  }
}

class _QuickActionCard extends StatelessWidget {
  const _QuickActionCard({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: AppColors.gold),
          const SizedBox(height: AppSpacing.md),
          Text(label, style: AppTypography.labelLarge),
        ],
      ),
    );
  }
}

class _MenuSection extends StatelessWidget {
  const _MenuSection({
    required this.user,
    required this.billingBadge,
    required this.onLifetimeTap,
  });

  final User user;
  final String? billingBadge;
  final VoidCallback onLifetimeTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (user.tier == SubscriptionTier.free) ...[
          _UpgradeBanner(onUpgrade: () => context.go(AppRoutes.pricing)),
          const SizedBox(height: AppSpacing.lg),
        ],
        AppCard(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.lg,
            vertical: AppSpacing.sm,
          ),
          child: Column(
            children: [
              ProfileMenuItem(
                icon: Icons.credit_card_rounded,
                label: 'Subscription & Billing',
                trailingBadge: billingBadge,
                onTap: () => context.go(AppRoutes.pricing),
              ),
              const AppDivider(),
              ProfileMenuItem(
                icon: Icons.card_giftcard_rounded,
                label: 'Referral Program',
                onTap: () => context.go(AppRoutes.referral),
              ),
              const AppDivider(),
              ProfileMenuItem(
                icon: Icons.settings_rounded,
                label: 'Settings',
                onTap: () => context.go(AppRoutes.settings),
              ),
              const AppDivider(),
              ProfileMenuItem(
                icon: Icons.diamond_rounded,
                label: 'Lifetime Deal',
                trailingBadge: '100 slots',
                onTap: onLifetimeTap,
              ),
              const AppDivider(),
              ProfileMenuItem(
                icon: Icons.notifications_none_rounded,
                label: 'Notifications',
                onTap: () => context.go(AppRoutes.notificationSettings),
              ),
              const AppDivider(),
              ProfileMenuItem(
                icon: Icons.lock_outline_rounded,
                label: 'Privacy',
                onTap: () => context.go(AppRoutes.privacySettings),
              ),
              const AppDivider(),
              ProfileMenuItem(
                icon: Icons.help_outline_rounded,
                label: 'Help & Support',
                onTap: () => context.go(AppRoutes.help),
              ),
              const AppDivider(),
              ProfileMenuItem(
                icon: Icons.info_outline_rounded,
                label: 'About',
                onTap: () => context.go(AppRoutes.about),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _UpgradeBanner extends StatelessWidget {
  const _UpgradeBanner({required this.onUpgrade});

  final VoidCallback onUpgrade;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      key: const Key('profile-upgrade-banner'),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppColors.goldLight, AppColors.goldDark],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(AppRadius.lg),
        boxShadow: AppShadows.shadowGoldGlow,
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Upgrade ke Premium untuk akses semua fitur',
              style: AppTypography.headlineSmall.copyWith(
                color: AppColors.textInverse,
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            AppButton(
              label: 'Upgrade',
              variant: AppButtonVariant.secondary,
              onPressed: onUpgrade,
            ),
          ],
        ),
      ),
    );
  }
}
