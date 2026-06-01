import '../models/script.dart';

/// Contract for ScriptRepository implementations.
///
/// Implementations may be backed by mock memory stores, Supabase, or the
/// Fastify API. Callers should depend on this abstraction through Riverpod
/// providers so feature code stays portable across local and production modes.
abstract class ScriptRepository {
  Future<List<Script>> getAll({String? projectId});

  Future<Script?> getById(String id);

  Future<Script> create(Script script);

  Future<Script> update(Script script);

  Future<void> delete(String id);

  Stream<List<Script>> watch({String? projectId});
}
