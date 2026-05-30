import '../models/project.dart';

abstract class ProjectRepository {
  Future<List<Project>> getAll({String? userId});

  Future<Project?> getById(String id);

  Future<Project> create(Project project);

  Future<Project> update(Project project);

  Future<void> delete(String id);

  Stream<List<Project>> watch({String? userId});
}
