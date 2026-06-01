import '../models/subscription.dart';

/// Contract for SubscriptionRepository implementations.
///
/// Implementations may be backed by mock memory stores, Supabase, or the
/// Fastify API. Callers should depend on this abstraction through Riverpod
/// providers so feature code stays portable across local and production modes.
abstract class SubscriptionRepository {
  Future<int> getLifetimeSlots();

  Future<Subscription?> getByUserId(String userId);

  Future<Subscription?> getById(String id);

  Future<Subscription> create(Subscription subscription);

  Future<Subscription> update(Subscription subscription);

  Future<void> cancel(String id);

  Stream<Subscription?> watchByUserId(String userId);
}
