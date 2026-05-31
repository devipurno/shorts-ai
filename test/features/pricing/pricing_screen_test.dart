import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:shorts_ai/core/theme/app_theme.dart';
import 'package:shorts_ai/core/theme/app_typography.dart';
import 'package:shorts_ai/features/auth/models/user.dart';
import 'package:shorts_ai/features/auth/providers/current_user_provider.dart';
import 'package:shorts_ai/features/pricing/pricing_screen.dart';
import 'package:shorts_ai/routing/routes.dart';
import 'package:shorts_ai/shared/models/subscription.dart';
import 'package:shorts_ai/shared/repositories/providers.dart';
import 'package:shorts_ai/shared/repositories/subscription_repository.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() {
    AppTypography.setUseGoogleFontsForTest(false);
  });

  testWidgets('renders four pricing tiers, lifetime urgency, matrix, and FAQ',
      (tester) async {
    await tester.pumpWidget(_PricingHarness(user: _freeUser));
    await _pumpPricing(tester);

    expect(find.byKey(const Key('pricing-screen')), findsOneWidget);
    expect(find.text('Upgrade Plan'), findsOneWidget);
    expect(find.byKey(const Key('pricing-tier-free')), findsOneWidget);
    expect(find.text('Standard'), findsOneWidget);

    await _scrollPricingUntilVisible(
      tester,
      find.byKey(const Key('pricing-tier-premium')),
    );

    expect(find.text('Premium'), findsOneWidget);

    await _scrollPricingUntilVisible(
      tester,
      find.byKey(const Key('pricing-tier-lifetime')),
    );
    await tester.pump();

    expect(find.text('Lifetime'), findsWidgets);
    expect(find.text('76 slots tersisa'), findsOneWidget);

    await _scrollPricingUntilVisible(
      tester,
      find.byKey(const Key('pricing-comparison-table')),
    );

    expect(find.text('Tier comparison'), findsOneWidget);

    await _scrollPricingUntilVisible(
      tester,
      find.byKey(const Key('pricing-faq')),
    );

    expect(find.text('FAQ'), findsOneWidget);
  });

  testWidgets('yearly toggle shows 20 percent discount pricing',
      (tester) async {
    await tester.pumpWidget(_PricingHarness(user: _freeUser));
    await _pumpPricing(tester);

    await tester.tap(find.text('Yearly'));
    await tester.pumpAndSettle();

    expect(find.text('20% OFF'), findsOneWidget);

    await _scrollPricingUntilVisible(
      tester,
      find.byKey(const Key('pricing-tier-premium')),
    );
    await tester.pump();

    expect(find.text('Rp 1,152jt'), findsOneWidget);
    expect(find.text('/thn'), findsWidgets);
  });

  testWidgets('selecting Premium plan navigates to checkout', (tester) async {
    await tester.pumpWidget(_PricingRouterHarness(user: _freeUser));
    await _pumpPricing(tester);

    await _scrollPricingUntilVisible(
      tester,
      find.byKey(const Key('pricing-select-premium')),
    );
    await tester.pump();

    await tester.tap(find.byKey(const Key('pricing-select-premium')));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 500));
    await tester.pump();

    expect(find.byKey(const Key('checkout-screen')), findsOneWidget);
  });
}

Future<void> _pumpPricing(WidgetTester tester) async {
  await tester.pump();
  await tester.pump(const Duration(milliseconds: 450));
}

Future<void> _scrollPricingUntilVisible(
  WidgetTester tester,
  Finder finder,
) async {
  for (var i = 0; i < 12 && finder.evaluate().isEmpty; i++) {
    await tester.drag(
      find.byKey(const Key('pricing-list')),
      const Offset(0, -460),
    );
    await tester.pumpAndSettle();
  }
  expect(finder, findsOneWidget);
  await tester.ensureVisible(finder);
  await tester.pump();
}

final _freeUser = User(
  id: 'user_1',
  email: 'creator@autoshort.id',
  name: 'Creator',
  tier: SubscriptionTier.free,
  createdAt: DateTime(2026, 5, 31),
);

class _PricingHarness extends StatelessWidget {
  const _PricingHarness({required this.user});

  final User user;

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      overrides: [
        currentUserProvider.overrideWithValue(user),
        subscriptionRepositoryProvider.overrideWithValue(
          _FakeSubscriptionRepository(),
        ),
      ],
      child: MaterialApp(
        theme: darkTheme(),
        home: const PricingScreen(),
      ),
    );
  }
}

class _PricingRouterHarness extends StatelessWidget {
  _PricingRouterHarness({required this.user});

  final User user;

  late final GoRouter _router = GoRouter(
    initialLocation: AppRoutes.pricing,
    routes: [
      GoRoute(
        path: AppRoutes.pricing,
        builder: (context, state) => const PricingScreen(),
      ),
      GoRoute(
        path: AppRoutes.checkout,
        builder: (context, state) => const Scaffold(
          key: Key('checkout-screen'),
          body: Text('Checkout'),
        ),
      ),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      overrides: [
        currentUserProvider.overrideWithValue(user),
        subscriptionRepositoryProvider.overrideWithValue(
          _FakeSubscriptionRepository(),
        ),
      ],
      child: MaterialApp.router(
        theme: darkTheme(),
        routerConfig: _router,
      ),
    );
  }
}

class _FakeSubscriptionRepository implements SubscriptionRepository {
  @override
  Future<void> cancel(String id) async {}

  @override
  Future<Subscription> create(Subscription subscription) async => subscription;

  @override
  Future<Subscription?> getById(String id) async => null;

  @override
  Future<int> getLifetimeSlots() async => 76;

  @override
  Future<Subscription?> getByUserId(String userId) async => null;

  @override
  Future<Subscription> update(Subscription subscription) async => subscription;

  @override
  Stream<Subscription?> watchByUserId(String userId) => Stream.value(null);
}
