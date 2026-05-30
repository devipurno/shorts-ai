import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../features/auth/models/user.dart';
import '../animation/fade_slide.dart';
import '../animation/pulse.dart';
import '../animation/shake.dart';
import '../buttons/app_button.dart';
import '../buttons/fab.dart';
import '../buttons/icon_button.dart';
import '../cards/app_card.dart';
import '../display/app_avatar.dart';
import '../display/app_badge.dart';
import '../display/app_chip.dart';
import '../display/app_tag.dart';
import '../display/tier_indicator.dart';
import '../feedback/app_loader.dart';
import '../feedback/app_shimmer.dart';
import '../feedback/app_snackbar.dart';
import '../feedback/empty_state.dart';
import '../feedback/error_state.dart';
import '../inputs/otp_input.dart';
import '../inputs/password_input.dart';
import '../inputs/search_input.dart';
import '../inputs/textarea.dart';
import '../inputs/text_input.dart';
import '../layout/app_divider.dart';
import '../layout/page_scaffold.dart';
import '../layout/section.dart';
import '../modals/app_bottom_sheet.dart';
import '../modals/app_dialog.dart';
import '../modals/app_drawer.dart';
import '../navigation/app_appbar.dart';
import '../navigation/app_tabs.dart';
import '../navigation/bottom_nav_bar.dart';

class ComponentGallery extends StatelessWidget {
  const ComponentGallery({super.key});

  @override
  Widget build(BuildContext context) {
    if (!kDebugMode) {
      return const SizedBox.shrink();
    }

    return DefaultTabController(
      length: 3,
      child: PageScaffold(
        title: 'Components',
        scrollable: true,
        floatingActionButton: AppFab(
          icon: const Icon(Icons.auto_awesome),
          onPressed: () => AppSnackbar.info(context, 'Gold action'),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AppSection(
              title: 'Buttons',
              child: Wrap(
                spacing: AppSpacing.sm,
                runSpacing: AppSpacing.sm,
                children: [
                  AppButton(label: 'Primary', onPressed: () {}),
                  AppButton(
                    label: 'Secondary',
                    variant: AppButtonVariant.secondary,
                    onPressed: () {},
                  ),
                  AppButton(
                    label: 'Ghost',
                    variant: AppButtonVariant.ghost,
                    onPressed: () {},
                  ),
                  AppButton(
                    label: 'Danger',
                    variant: AppButtonVariant.danger,
                    onPressed: () {},
                  ),
                  const AppButton(
                    label: 'Loading',
                    onPressed: null,
                    isLoading: true,
                  ),
                  AppIconButton(
                    icon: const Icon(Icons.more_horiz),
                    tooltip: 'More',
                    variant: AppIconButtonVariant.outlined,
                    onPressed: () {},
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.xl),
            const AppSection(
              title: 'Inputs',
              child: Column(
                children: [
                  AppTextInput(label: 'Title', hint: 'Short title'),
                  SizedBox(height: AppSpacing.md),
                  AppPasswordInput(),
                  SizedBox(height: AppSpacing.md),
                  AppSearchInput(hint: 'Search clips'),
                  SizedBox(height: AppSpacing.md),
                  AppOtpInput(),
                  SizedBox(height: AppSpacing.md),
                  AppTextArea(label: 'Description'),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.xl),
            AppSection(
              title: 'Cards',
              child: Wrap(
                spacing: AppSpacing.md,
                runSpacing: AppSpacing.md,
                children: const [
                  SizedBox(
                    width: 180,
                    child: AppCard(child: Text('Flat card')),
                  ),
                  SizedBox(
                    width: 180,
                    child: AppCard(
                      variant: AppCardVariant.elevated,
                      child: Text('Elevated card'),
                    ),
                  ),
                  SizedBox(
                    width: 180,
                    child: AppCard(
                      variant: AppCardVariant.glass,
                      child: Text('Glass card'),
                    ),
                  ),
                  SizedBox(
                    width: 180,
                    child: AppCard(
                      variant: AppCardVariant.premiumGold,
                      child: Text('Premium gold'),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.xl),
            AppSection(
              title: 'Feedback',
              child: Wrap(
                spacing: AppSpacing.md,
                runSpacing: AppSpacing.md,
                children: [
                  const AppLoader(label: 'Loading'),
                  AppShimmer.box(width: 120, height: 28),
                  EmptyState(
                    title: 'No clips yet',
                    message: 'Create your first AutoShort.',
                    ctaLabel: 'Create',
                    onCtaPressed: () {},
                  ),
                  ErrorState(
                    title: 'Render failed',
                    message: 'Try again in a moment.',
                    onRetry: () {},
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.xl),
            AppSection(
              title: 'Display',
              child: Wrap(
                spacing: AppSpacing.sm,
                runSpacing: AppSpacing.sm,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: const [
                  AppAvatar(initials: 'AS'),
                  AppBadge(count: 12),
                  AppBadge(variant: AppBadgeVariant.notification),
                  AppChip(label: 'Filter', variant: AppChipVariant.filter),
                  AppChip(
                    label: 'Selected',
                    variant: AppChipVariant.selectable,
                    selected: true,
                  ),
                  AppTag(label: 'AI Ready', icon: Icons.bolt),
                  TierIndicator(tier: SubscriptionTier.free),
                  TierIndicator(tier: SubscriptionTier.premium),
                  TierIndicator(tier: SubscriptionTier.lifetime),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.xl),
            AppSection(
              title: 'Navigation',
              child: Column(
                children: [
                  const AppAppBar(title: 'Preview Bar'),
                  const SizedBox(height: AppSpacing.md),
                  const AppTabs(
                    tabs: ['Subtitle', 'Thumbnail', 'Metadata'],
                    variant: AppTabsVariant.pill,
                  ),
                  const SizedBox(height: AppSpacing.md),
                  AppBottomNavBar(
                    currentPath: '/create',
                    onDestinationSelected: (_) {},
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.xl),
            AppSection(
              title: 'Modals',
              child: Wrap(
                spacing: AppSpacing.sm,
                children: [
                  AppButton(
                    label: 'Dialog',
                    onPressed: () => AppDialog.showConfirm(
                      context,
                      title: 'Confirm action',
                      message: 'This previews the AutoShort dialog.',
                    ),
                  ),
                  AppButton(
                    label: 'Bottom sheet',
                    variant: AppButtonVariant.secondary,
                    onPressed: () => AppBottomSheet.show<void>(
                      context,
                      child: const Text('Bottom sheet content'),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.xl),
            AppSection(
              title: 'Layout & Animation',
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const AppDivider(),
                  const SizedBox(height: AppSpacing.md),
                  const FadeSlide(child: Text('Fade slide entrance')),
                  const SizedBox(height: AppSpacing.md),
                  const Shake(child: Text('Shake error feedback')),
                  const SizedBox(height: AppSpacing.md),
                  Pulse(
                    enabled: false,
                    child: AppButton(
                      label: 'Pulse CTA',
                      icon: const Icon(Icons.play_arrow),
                      onPressed: () {},
                    ),
                  ),
                  const SizedBox(height: AppSpacing.md),
                  SizedBox(
                    height: 180,
                    child: AppDrawer(
                      items: [
                        AppDrawerItem(
                          label: 'Library',
                          icon: Icons.video_library,
                          onTap: () {},
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.xl),
            const Text(
              'Debug-only component gallery',
              style: TextStyle(color: AppColors.textTertiary),
            ),
          ],
        ),
      ),
    );
  }
}
