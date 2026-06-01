import '../models/subtitle.dart';

/// Contract for SubtitleRepository implementations.
///
/// Implementations may be backed by mock memory stores, Supabase, or the
/// Fastify API. Callers should depend on this abstraction through Riverpod
/// providers so feature code stays portable across local and production modes.
abstract class SubtitleRepository {
  Future<List<Subtitle>> getAll({String? projectId});

  Future<Subtitle?> getById(String id);

  Future<Subtitle> create(Subtitle subtitle);

  Future<Subtitle> update(Subtitle subtitle);

  Future<void> delete(String id);

  Stream<List<Subtitle>> watch({String? projectId});
}
