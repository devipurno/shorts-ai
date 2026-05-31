import '../models/subscription.dart';

abstract class SubscriptionRepository {
  Future<int> getLifetimeSlots();

  Future<Subscription?> getByUserId(String userId);

  Future<Subscription?> getById(String id);

  Future<Subscription> create(Subscription subscription);

  Future<Subscription> update(Subscription subscription);

  Future<void> cancel(String id);

  Stream<Subscription?> watchByUserId(String userId);
}
