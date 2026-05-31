import 'package:dio/dio.dart';

import '../../models/project.dart';
import '../../services/supabase_service.dart';
import '../project_repository.dart';
import 'api_repository_helpers.dart';

class ApiProjectRepository implements ProjectRepository {
  ApiProjectRepository({Dio? dio, SupabaseService? supabaseService})
      : _client = ApiResourceClient<Project>(
          path: '/projects',
          fromJson: Project.fromJson,
          toJson: (project) => project.toJson(),
          idOf: (project) => project.id,
          dio: dio,
        ),
        _supabaseService = supabaseService ?? SupabaseService();

  final ApiResourceClient<Project> _client;
  final SupabaseService _supabaseService;

  @override
  Future<List<Project>> getAll({String? userId}) {
    return _client.getAll(query: {'user_id': userId});
  }

  @override
  Future<Project?> getById(String id) => _client.getById(id);

  @override
  Future<Project> create(Project project) => _client.create(project);

  @override
  Future<Project> update(Project project) => _client.update(project);

  @override
  Future<void> delete(String id) => _client.delete(id);

  @override
  Stream<List<Project>> watch({String? userId}) async* {
    if (!SupabaseService.isInitialized) {
      yield await getAll(userId: userId);
      return;
    }

    final stream =
        _supabaseService.client.from('projects').stream(primaryKey: ['id']);
    final filtered = userId == null ? stream : stream.eq('user_id', userId);
    yield* filtered.map(
      (rows) => rows
          .map((row) => Project.fromJson(Map<String, Object?>.from(row)))
          .toList(),
    );
  }
}
