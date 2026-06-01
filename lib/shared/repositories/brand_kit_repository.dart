import '../models/brand_kit.dart';

/// Contract for BrandKitRepository implementations.
///
/// Implementations may be backed by mock memory stores, Supabase, or the
/// Fastify API. Callers should depend on this abstraction through Riverpod
/// providers so feature code stays portable across local and production modes.
abstract class BrandKitRepository {
  Future<BrandKit?> getByUserId(String userId);

  Future<BrandKit?> getById(String id);

  Future<BrandKit> create(BrandKit brandKit);

  Future<BrandKit> update(BrandKit brandKit);

  Future<void> delete(String id);

  Stream<BrandKit?> watchByUserId(String userId);
}
