import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shorts_ai/features/auth/models/user.dart';
import 'package:shorts_ai/features/pricing/providers/pricing_provider.dart';
import 'package:shorts_ai/routing/routes.dart';

void main() {
  test('tier matrix contains 20+ features across all tiers', () {
    final container = ProviderContainer();
    addTearDown(container.dispose);

    final features = container.read(tierMatrixProvider);

    expect(features.length, greaterThanOrEqualTo(20));
    expect(
      features.any((feature) => feature.name == '4K export'),
      isTrue,
    );
    expect(
      features
          .firstWhere((feature) => feature.name == '4K export')
          .enabledFor(SubscriptionTier.free),
      isFalse,
    );
    expect(
      features
          .firstWhere((feature) => feature.name == '4K export')
          .enabledFor(SubscriptionTier.premium),
      isTrue,
    );
  });

  test('pricing plans expose expected Indonesian tier prices', () {
    final container = ProviderContainer();
    addTearDown(container.dispose);

    final plans = container.read(pricingPlansProvider);
    final standard = plans.firstWhere(
      (plan) => plan.tier == SubscriptionTier.standard,
    );
    final premium = plans.firstWhere(
      (plan) => plan.tier == SubscriptionTier.premium,
    );
    final lifetime = plans.firstWhere(
      (plan) => plan.tier == SubscriptionTier.lifetime,
    );

    expect(standard.priceLabel(BillingCycle.monthly), 'Rp 30K');
    expect(premium.priceLabel(BillingCycle.monthly), 'Rp 120K');
    expect(premium.priceLabel(BillingCycle.yearly), 'Rp 1,152jt');
    expect(lifetime.priceLabel(BillingCycle.monthly), 'Rp 1.5jt');
    expect(lifetime.suffixLabel(BillingCycle.monthly), 'one-time');
  });

  test('subscribe mutation returns checkout path with tier and billing',
      () async {
    final mutation = SubscribeMutation();

    final path = await mutation.subscribe(
      SubscriptionTier.premium,
      BillingCycle.yearly,
    );

    expect(path, '${AppRoutes.checkout}?tier=premium&billing=yearly');
    expect(mutation.state.value, SubscriptionTier.premium);
  });
}
