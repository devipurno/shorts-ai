import '../models/template.dart';

/// Contract for TemplateRepository implementations.
///
/// Implementations may be backed by mock memory stores, Supabase, or the
/// Fastify API. Callers should depend on this abstraction through Riverpod
/// providers so feature code stays portable across local and production modes.
abstract class TemplateRepository {
  Future<List<Template>> getAll();

  Future<Template?> getById(String id);

  Future<List<Template>> getByCategory(String category);

  Stream<List<Template>> watchAll();
}
