import '../models/thumbnail.dart';

/// Contract for ThumbnailRepository implementations.
///
/// Implementations may be backed by mock memory stores, Supabase, or the
/// Fastify API. Callers should depend on this abstraction through Riverpod
/// providers so feature code stays portable across local and production modes.
abstract class ThumbnailRepository {
  Future<List<Thumbnail>> getAll({String? projectId});

  Future<Thumbnail?> getById(String id);

  Future<Thumbnail> create(Thumbnail thumbnail);

  Future<Thumbnail> update(Thumbnail thumbnail);

  Future<void> delete(String id);

  Stream<List<Thumbnail>> watch({String? projectId});
}
