import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

import '../../../routing/routes.dart';
import '../../../shared/repositories/providers.dart';
import '../../auth/models/user.dart';

enum BillingCycle { monthly, yearly }

extension BillingCycleX on BillingCycle {
  String get label => switch (this) {
        BillingCycle.monthly => 'Monthly',
        BillingCycle.yearly => 'Yearly',
      };

  String get suffix => switch (this) {
        BillingCycle.monthly => '/bln',
        BillingCycle.yearly => '/thn',
      };
}

final pricingBillingCycleProvider =
    StateProvider<BillingCycle>((ref) => BillingCycle.monthly);

final lifetimeSlotsProvider = FutureProvider<int>((ref) {
  return ref.watch(subscriptionRepositoryProvider).getLifetimeSlots();
});

final pricingPlansProvider = Provider<List<PricingPlan>>((ref) {
  return const [
    PricingPlan(
      tier: SubscriptionTier.free,
      title: 'Free',
      monthlyPrice: 0,
      yearlyPrice: 0,
      description: 'Trial Premium 14 hari, auto-end tanpa kartu kredit.',
      features: [
        '14 hari trial Premium',
        'Basic analytics',
        'Watermark AutoShort',
        '3 hook generation/hari',
      ],
      badge: 'Trial',
    ),
    PricingPlan(
      tier: SubscriptionTier.standard,
      title: 'Standard',
      monthlyPrice: 30000,
      yearlyPrice: 288000,
      description: 'Untuk creator aktif yang butuh workflow rapi.',
      features: [
        'Watermark removable',
        '10 hook/hari',
        'Full analytics charts',
        '30 scheduled post/bulan',
      ],
    ),
    PricingPlan(
      tier: SubscriptionTier.premium,
      title: 'Premium',
      monthlyPrice: 120000,
      yearlyPrice: 1152000,
      description: 'Unlimited everything untuk scale konten serius.',
      features: [
        'Unlimited generation',
        '4K export',
        'AI generate thumbnails',
        'Multi-account scheduler',
      ],
      badge: 'Recommended',
      highlighted: true,
    ),
    PricingPlan(
      tier: SubscriptionTier.lifetime,
      title: 'Lifetime',
      monthlyPrice: 1500000,
      yearlyPrice: 1500000,
      description: 'Semua fitur Premium forever, one-time payment.',
      features: [
        'Semua Premium features',
        'Lifetime updates',
        'Priority support',
        '100 founding creator slots',
      ],
      badge: 'Limited',
      highlighted: true,
      oneTime: true,
    ),
  ];
});

final tierMatrixProvider = Provider<List<TierFeature>>((ref) {
  return const [
    TierFeature('Premium trial 14 hari', true, true, true, true),
    TierFeature('Watermark removable', false, true, true, true),
    TierFeature('Hook generator quota', true, true, true, true,
        freeLabel: '3/hari', standardLabel: '10/hari'),
    TierFeature('Unlimited hook generator', false, false, true, true),
    TierFeature('AI thumbnail generator', false, false, true, true),
    TierFeature('CTR prediction', false, true, true, true),
    TierFeature('Mini editor basic', true, true, true, true),
    TierFeature('4K export', false, false, true, true),
    TierFeature('Subtitle Studio Pro', false, true, true, true),
    TierFeature('Karaoke subtitle style', false, false, true, true),
    TierFeature('Template library', true, true, true, true),
    TierFeature('Premium templates', false, false, true, true),
    TierFeature('Brand kit count', true, true, true, true,
        freeLabel: '1', standardLabel: '3', premiumLabel: 'Unlimited'),
    TierFeature('Intro/outro video brand kit', false, false, true, true),
    TierFeature('Content calendar quota', true, true, true, true,
        freeLabel: '5/bln', standardLabel: '30/bln', premiumLabel: 'Unlimited'),
    TierFeature('Multi-account scheduler', false, false, true, true),
    TierFeature('Creator analytics basic', true, true, true, true),
    TierFeature('Full analytics charts', false, true, true, true),
    TierFeature('Audience demographics', false, false, true, true),
    TierFeature('Export analytics PDF', false, false, true, true),
    TierFeature('Priority support', false, false, true, true),
    TierFeature('Lifetime updates', false, false, false, true),
  ];
});

final pricingFaqProvider = Provider<List<PricingFaq>>((ref) {
  return const [
    PricingFaq(
      question: 'Apakah trial butuh kartu kredit?',
      answer:
          'Tidak. Trial Premium 14 hari auto-end dan bisa upgrade kapan saja.',
    ),
    PricingFaq(
      question: 'Apa beda Standard dan Premium?',
      answer:
          'Standard membuka workflow inti. Premium membuka unlimited generation, 4K export, AI thumbnail, dan multi-account.',
    ),
    PricingFaq(
      question: 'Lifetime Deal termasuk update?',
      answer:
          'Ya. Lifetime mendapat semua fitur Premium dan update produk selamanya.',
    ),
    PricingFaq(
      question: 'Bisa downgrade atau cancel?',
      answer:
          'Bisa. Paket monthly/yearly bisa diganti atau dibatalkan dari Billing.',
    ),
    PricingFaq(
      question: 'Metode pembayaran apa yang didukung?',
      answer:
          'Checkout masih mock di fase ini. Integrasi production akan memakai Google Play Billing dan payment gateway lokal.',
    ),
  ];
});

final subscribeMutationProvider =
    StateNotifierProvider<SubscribeMutation, AsyncValue<SubscriptionTier?>>(
  (ref) => SubscribeMutation(),
);

class SubscribeMutation extends StateNotifier<AsyncValue<SubscriptionTier?>> {
  SubscribeMutation() : super(const AsyncData(null));

  Future<String> subscribe(SubscriptionTier tier, BillingCycle billing) async {
    state = const AsyncLoading();
    await Future<void>.delayed(const Duration(milliseconds: 350));
    state = AsyncData(tier);
    return Uri(
      path: AppRoutes.checkout,
      queryParameters: {
        'tier': tier.name,
        'billing': billing.name,
      },
    ).toString();
  }
}

class PricingPlan {
  const PricingPlan({
    required this.tier,
    required this.title,
    required this.monthlyPrice,
    required this.yearlyPrice,
    required this.description,
    required this.features,
    this.badge,
    this.highlighted = false,
    this.oneTime = false,
  });

  final SubscriptionTier tier;
  final String title;
  final int monthlyPrice;
  final int yearlyPrice;
  final String description;
  final List<String> features;
  final String? badge;
  final bool highlighted;
  final bool oneTime;

  String priceLabel(BillingCycle billing) {
    if (monthlyPrice == 0) {
      return 'Rp 0';
    }
    if (oneTime) {
      return 'Rp 1.5jt';
    }
    final value = billing == BillingCycle.yearly ? yearlyPrice : monthlyPrice;
    return _formatRupiah(value);
  }

  String suffixLabel(BillingCycle billing) {
    if (monthlyPrice == 0) {
      return '';
    }
    if (oneTime) {
      return 'one-time';
    }
    return billing.suffix;
  }
}

class TierFeature {
  const TierFeature(
    this.name,
    this.free,
    this.standard,
    this.premium,
    this.lifetime, {
    this.freeLabel,
    this.standardLabel,
    this.premiumLabel,
    this.lifetimeLabel,
  });

  final String name;
  final bool free;
  final bool standard;
  final bool premium;
  final bool lifetime;
  final String? freeLabel;
  final String? standardLabel;
  final String? premiumLabel;
  final String? lifetimeLabel;

  bool enabledFor(SubscriptionTier tier) => switch (tier) {
        SubscriptionTier.free => free,
        SubscriptionTier.standard => standard,
        SubscriptionTier.premium => premium,
        SubscriptionTier.lifetime => lifetime,
      };

  String? labelFor(SubscriptionTier tier) => switch (tier) {
        SubscriptionTier.free => freeLabel,
        SubscriptionTier.standard => standardLabel,
        SubscriptionTier.premium => premiumLabel,
        SubscriptionTier.lifetime => lifetimeLabel,
      };
}

class PricingFaq {
  const PricingFaq({
    required this.question,
    required this.answer,
  });

  final String question;
  final String answer;
}

String _formatRupiah(int value) {
  if (value >= 1000000) {
    var label = (value / 1000000).toStringAsFixed(3);
    label = label.replaceFirst(RegExp(r'\.?0+$'), '').replaceAll('.', ',');
    return 'Rp ${label}jt';
  }
  if (value >= 1000 && value % 1000 == 0) {
    return 'Rp ${value ~/ 1000}K';
  }
  return 'Rp $value';
}
