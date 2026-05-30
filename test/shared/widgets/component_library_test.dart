import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shorts_ai/core/theme/app_colors.dart';
import 'package:shorts_ai/core/theme/app_theme.dart';
import 'package:shorts_ai/core/theme/app_typography.dart';
import 'package:shorts_ai/features/auth/models/user.dart';
import 'package:shorts_ai/features/auth/providers/auth_provider.dart';
import 'package:shorts_ai/routing/app_router.dart';
import 'package:shorts_ai/routing/routes.dart';
import 'package:shorts_ai/shared/widgets/_dev/component_gallery.dart';
import 'package:shorts_ai/shared/widgets/animation/fade_slide.dart';
import 'package:shorts_ai/shared/widgets/animation/pulse.dart';
import 'package:shorts_ai/shared/widgets/animation/shake.dart';
import 'package:shorts_ai/shared/widgets/buttons/app_button.dart';
import 'package:shorts_ai/shared/widgets/buttons/fab.dart';
import 'package:shorts_ai/shared/widgets/buttons/icon_button.dart';
import 'package:shorts_ai/shared/widgets/cards/app_card.dart';
import 'package:shorts_ai/shared/widgets/display/app_avatar.dart';
import 'package:shorts_ai/shared/widgets/display/app_badge.dart';
import 'package:shorts_ai/shared/widgets/display/app_chip.dart';
import 'package:shorts_ai/shared/widgets/display/app_tag.dart';
import 'package:shorts_ai/shared/widgets/display/tier_indicator.dart';
import 'package:shorts_ai/shared/widgets/feedback/app_loader.dart';
import 'package:shorts_ai/shared/widgets/feedback/app_shimmer.dart';
import 'package:shorts_ai/shared/widgets/feedback/app_snackbar.dart';
import 'package:shorts_ai/shared/widgets/feedback/empty_state.dart';
import 'package:shorts_ai/shared/widgets/feedback/error_state.dart';
import 'package:shorts_ai/shared/widgets/inputs/otp_input.dart';
import 'package:shorts_ai/shared/widgets/inputs/password_input.dart';
import 'package:shorts_ai/shared/widgets/inputs/search_input.dart';
import 'package:shorts_ai/shared/widgets/inputs/textarea.dart';
import 'package:shorts_ai/shared/widgets/inputs/text_input.dart';
import 'package:shorts_ai/shared/widgets/layout/app_divider.dart';
import 'package:shorts_ai/shared/widgets/layout/page_scaffold.dart';
import 'package:shorts_ai/shared/widgets/layout/section.dart';
import 'package:shorts_ai/shared/widgets/modals/app_bottom_sheet.dart';
import 'package:shorts_ai/shared/widgets/modals/app_dialog.dart';
import 'package:shorts_ai/shared/widgets/modals/app_drawer.dart';
import 'package:shorts_ai/shared/widgets/navigation/app_appbar.dart';
import 'package:shorts_ai/shared/widgets/navigation/app_tabs.dart';
import 'package:shorts_ai/shared/widgets/navigation/bottom_nav_bar.dart';

void main() {
  setUpAll(() {
    AppTypography.setUseGoogleFontsForTest(false);
  });

  testWidgets('AppButton variants render and primary tap works',
      (tester) async {
    var taps = 0;
    await tester.pumpWidget(
      _Harness(
        child: Wrap(
          children: [
            AppButton(label: 'Primary', onPressed: () => taps++),
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
            const AppButton(label: 'Loading', onPressed: null, isLoading: true),
          ],
        ),
      ),
    );

    await tester.tap(find.text('Primary'));
    expect(taps, 1);
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('AppIconButton and AppFab trigger actions', (tester) async {
    var iconTap = 0;
    var fabTap = 0;
    await tester.pumpWidget(
      _Harness(
        child: Column(
          children: [
            AppIconButton(
              tooltip: 'More',
              icon: const Icon(Icons.more_horiz),
              onPressed: () => iconTap++,
            ),
            AppFab(
              icon: const Icon(Icons.add),
              label: 'Create',
              onPressed: () => fabTap++,
            ),
          ],
        ),
      ),
    );

    await tester.tap(find.byTooltip('More'));
    await tester.tap(find.text('Create'));
    expect(iconTap, 1);
    expect(fabTap, 1);
  });

  testWidgets('text, password, search, otp, and textarea inputs render',
      (tester) async {
    String? otp;
    final searchController = TextEditingController(text: 'clip');
    addTearDown(searchController.dispose);

    await tester.pumpWidget(
      _Harness(
        child: Column(
          children: [
            const AppTextInput(label: 'Title', hint: 'Video title'),
            const AppPasswordInput(),
            AppSearchInput(controller: searchController),
            AppOtpInput(onCompleted: (value) => otp = value),
            const AppTextArea(label: 'Description'),
          ],
        ),
      ),
    );

    expect(find.text('Title'), findsOneWidget);
    expect(find.byTooltip('Show password'), findsOneWidget);

    await tester.tap(find.byTooltip('Show password'));
    await tester.pump();
    expect(find.byTooltip('Hide password'), findsOneWidget);

    await tester.tap(find.byTooltip('Clear search'));
    await tester.pump();
    expect(searchController.text, isEmpty);

    for (var index = 0; index < 6; index++) {
      await tester.enterText(find.byKey(Key('otp-$index')), '${index + 1}');
    }
    expect(otp, '123456');
  });

  testWidgets('AppCard variants render content', (tester) async {
    await tester.pumpWidget(
      const _Harness(
        child: Wrap(
          children: [
            AppCard(child: Text('Flat')),
            AppCard(variant: AppCardVariant.elevated, child: Text('Elevated')),
            AppCard(variant: AppCardVariant.glass, child: Text('Glass')),
            AppCard(
              variant: AppCardVariant.premiumGold,
              child: Text('Premium'),
            ),
          ],
        ),
      ),
    );

    expect(find.text('Flat'), findsOneWidget);
    expect(find.text('Premium'), findsOneWidget);
  });

  testWidgets('feedback widgets render and snackbar opens', (tester) async {
    await tester.pumpWidget(
      _Harness(
        child: Builder(
          builder: (context) => Column(
            children: [
              const AppLoader(label: 'Loading'),
              AppShimmer.box(width: 120, height: 20),
              EmptyState(
                title: 'Empty',
                message: 'Nothing here',
                ctaLabel: 'Create',
                onCtaPressed: () {},
              ),
              ErrorState(title: 'Error', onRetry: () {}),
              ElevatedButton(
                onPressed: () => AppSnackbar.success(context, 'Saved'),
                child: const Text('Show snack'),
              ),
            ],
          ),
        ),
      ),
    );

    expect(find.text('Loading'), findsOneWidget);
    expect(find.text('Empty'), findsOneWidget);
    expect(find.text('Error'), findsOneWidget);

    await tester.tap(find.text('Show snack'));
    await tester.pump();
    expect(find.text('Saved'), findsOneWidget);
  });

  testWidgets('display widgets render all variants', (tester) async {
    await tester.pumpWidget(
      const _Harness(
        child: Wrap(
          children: [
            AppAvatar(initials: 'AS'),
            AppBadge(count: 125),
            AppBadge(variant: AppBadgeVariant.notification),
            AppChip(label: 'Filter', variant: AppChipVariant.filter),
            AppChip(
              label: 'Selectable',
              variant: AppChipVariant.selectable,
              selected: true,
            ),
            AppTag(label: 'AI Ready', icon: Icons.bolt),
            TierIndicator(tier: SubscriptionTier.free),
            TierIndicator(tier: SubscriptionTier.standard),
            TierIndicator(tier: SubscriptionTier.premium),
            TierIndicator(tier: SubscriptionTier.lifetime),
          ],
        ),
      ),
    );

    expect(find.text('AS'), findsOneWidget);
    expect(find.text('99+'), findsOneWidget);
    expect(find.text('Premium'), findsOneWidget);
    expect(find.text('Lifetime'), findsOneWidget);
  });

  testWidgets('navigation widgets render and bottom nav selects routes',
      (tester) async {
    String? selectedRoute;

    await tester.pumpWidget(
      _Harness(
        child: DefaultTabController(
          length: 3,
          child: Column(
            children: [
              const AppAppBar(title: 'Gallery'),
              const AppTabs(tabs: ['One', 'Two', 'Three']),
              AppBottomNavBar(
                currentPath: AppRoutes.home,
                onDestinationSelected: (route) => selectedRoute = route,
              ),
            ],
          ),
        ),
      ),
    );

    expect(find.text('Gallery'), findsOneWidget);
    await tester.tap(find.text('Profile'));
    expect(selectedRoute, AppRoutes.profile);
  });

  testWidgets('modal widgets show dialog, bottom sheet, and drawer',
      (tester) async {
    await tester.pumpWidget(
      _Harness(
        scrollable: false,
        child: Builder(
          builder: (context) => Scaffold(
            drawer: AppDrawer(
              items: [
                AppDrawerItem(
                  label: 'Library',
                  icon: Icons.video_library,
                  onTap: () {},
                ),
              ],
            ),
            body: Column(
              children: [
                ElevatedButton(
                  onPressed: () => AppDialog.showConfirm(
                    context,
                    title: 'Delete clip',
                    message: 'Are you sure?',
                  ),
                  child: const Text('Dialog'),
                ),
                ElevatedButton(
                  onPressed: () => AppBottomSheet.show<void>(
                    context,
                    child: const Text('Sheet content'),
                  ),
                  child: const Text('Sheet'),
                ),
              ],
            ),
          ),
        ),
      ),
    );

    await tester.tap(find.text('Dialog'));
    await tester.pumpAndSettle();
    expect(find.text('Delete clip'), findsOneWidget);
    await tester.tap(find.text('Cancel'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Sheet'));
    await tester.pumpAndSettle();
    expect(find.text('Sheet content'), findsOneWidget);
    await tester.tapAt(const Offset(20, 20));
    await tester.pumpAndSettle();
  });

  testWidgets('layout widgets render scaffold, section, and divider',
      (tester) async {
    await tester.pumpWidget(
      const _Harness(
        scrollable: false,
        child: PageScaffold(
          title: 'Page',
          body: AppSection(
            title: 'Section',
            child: AppDivider(),
          ),
        ),
      ),
    );

    expect(find.text('Page'), findsOneWidget);
    expect(find.text('Section'), findsOneWidget);
    expect(find.byType(Divider), findsOneWidget);
  });

  testWidgets('animation wrappers render child widgets', (tester) async {
    await tester.pumpWidget(
      _Harness(
        child: Column(
          children: const [
            FadeSlide(child: Text('Fade')),
            Shake(child: Text('Shake')),
            Pulse(enabled: false, child: Text('Pulse')),
          ],
        ),
      ),
    );
    await tester.pump(const Duration(seconds: 1));

    expect(find.text('Fade'), findsOneWidget);
    expect(find.text('Shake'), findsOneWidget);
    expect(find.text('Pulse'), findsOneWidget);
  });

  testWidgets('debug component gallery is reachable through router',
      (tester) async {
    final router = createAppRouter(
      initialLocation: AppRoutes.devComponents,
      initialAuthState: Authenticated(mockAuthenticatedRouteUser()),
    );

    await tester.pumpWidget(
      MaterialApp.router(
        theme: darkTheme(),
        routerConfig: router,
      ),
    );
    await tester.pump(const Duration(seconds: 1));

    expect(find.byType(ComponentGallery), findsOneWidget);
    expect(find.text('Components'), findsOneWidget);
  });
}

class _Harness extends StatelessWidget {
  const _Harness({
    required this.child,
    this.scrollable = true,
  });

  final Widget child;
  final bool scrollable;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: darkTheme(),
      home: Scaffold(
        backgroundColor: AppColors.obsidian,
        body: SafeArea(
          child: scrollable
              ? SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: child,
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.all(16),
                  child: child,
                ),
        ),
      ),
    );
  }
}
