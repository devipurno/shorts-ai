import '../models/project.dart';

/// Contract for ProjectRepository implementations.
///
/// Implementations may be backed by mock memory stores, Supabase, or the
/// Fastify API. Callers should depend on this abstraction through Riverpod
/// providers so feature code stays portable across local and production modes.
abstract class ProjectRepository {
  Future<List<Project>> getAll({String? userId});

  Future<Project?> getById(String id);

  Future<Project> create(Project project);

  Future<Project> update(Project project);

  Future<void> delete(String id);

  Stream<List<Project>> watch({String? userId});
}
