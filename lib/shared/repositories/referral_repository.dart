import '../models/referral.dart';

/// Contract for ReferralRepository implementations.
///
/// Implementations may be backed by mock memory stores, Supabase, or the
/// Fastify API. Callers should depend on this abstraction through Riverpod
/// providers so feature code stays portable across local and production modes.
abstract class ReferralRepository {
  Future<List<Referral>> getAll({
    String? referrerUserId,
    String? refereeUserId,
  });

  Future<Referral?> getById(String id);

  Future<Referral> create(Referral referral);

  Future<Referral> update(Referral referral);

  Future<void> delete(String id);

  Stream<List<Referral>> watch({
    String? referrerUserId,
    String? refereeUserId,
  });
}
