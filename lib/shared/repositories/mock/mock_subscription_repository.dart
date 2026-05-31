import 'dart:async';
import 'dart:math' as math;

import '../../../core/errors/app_exception.dart';
import '../../models/subscription.dart';
import '../../models/user.dart';
import '../subscription_repository.dart';
import 'mock_repository_utils.dart';

class MockSubscriptionRepository implements SubscriptionRepository {
  MockSubscriptionRepository({
    MockRepositoryConfig config = const MockRepositoryConfig(),
  }) : _runtime = MockRepositoryRuntime(config) {
    _subscriptions.addAll(_seedSubscriptions());
  }

  final MockRepositoryRuntime _runtime;
  final _controller = StreamController<void>.broadcast();
  final _subscriptions = <Subscription>[];

  @override
  Future<int> getLifetimeSlots() async {
    await _runtime.simulateNetwork();
    final reservedSlots = math.Random(42).nextInt(30) + 1;
    return 100 - reservedSlots;
  }

  @override
  Future<Subscription?> getByUserId(String userId) async {
    await _runtime.simulateNetwork();
    return _findByUserId(userId);
  }

  @override
  Future<Subscription?> getById(String id) async {
    await _runtime.simulateNetwork();
    return _subscriptions.where((item) => item.id == id).firstOrNull;
  }

  @override
  Future<Subscription> create(Subscription subscription) async {
    await _runtime.simulateNetwork();
    _subscriptions.add(subscription);
    _emit();
    return subscription;
  }

  @override
  Future<Subscription> update(Subscription subscription) async {
    await _runtime.simulateNetwork();
    final index =
        _subscriptions.indexWhere((item) => item.id == subscription.id);
    if (index == -1) {
      throw const NotFoundException(
        'Subscription not found.',
        code: 'subscription_not_found',
      );
    }
    _subscriptions[index] = subscription;
    _emit();
    return subscription;
  }

  @override
  Future<void> cancel(String id) async {
    await _runtime.simulateNetwork();
    final index = _subscriptions.indexWhere((item) => item.id == id);
    if (index == -1) {
      throw const NotFoundException(
        'Subscription not found.',
        code: 'subscription_not_found',
      );
    }
    _subscriptions[index] = _subscriptions[index].copyWith(
      status: SubscriptionStatus.cancelled,
      cancelledAt: DateTime.now().toUtc(),
      autoRenew: false,
    );
    _emit();
  }

  @override
  Stream<Subscription?> watchByUserId(String userId) async* {
    await _runtime.simulateNetwork();
    yield _findByUserId(userId);
    yield* _controller.stream.map((_) => _findByUserId(userId));
  }

  List<Subscription> _seedSubscriptions() {
    return List<Subscription>.generate(6, (index) {
      final startedAt =
          DateTime.now().toUtc().subtract(Duration(days: index * 12));
      final tier =
          SubscriptionTier.values[index % SubscriptionTier.values.length];
      return Subscription(
        id: 'subscription_${index + 1}',
        userId: 'user_${index + 1}',
        tier: tier,
        status: SubscriptionStatus.active,
        startedAt: startedAt,
        expiresAt: tier == SubscriptionTier.lifetime
            ? null
            : startedAt.add(const Duration(days: 30)),
        paymentMethod: index.isEven ? 'midtrans' : 'google_play',
        autoRenew: tier != SubscriptionTier.lifetime,
        source: tier == SubscriptionTier.free
            ? SubscriptionSource.trial
            : SubscriptionSource.monthly,
      );
    });
  }

  Subscription? _findByUserId(String userId) {
    return _subscriptions.where((item) => item.userId == userId).firstOrNull;
  }

  void _emit() => _controller.add(null);
}
