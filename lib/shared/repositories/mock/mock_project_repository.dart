import 'dart:async';

import 'package:faker/faker.dart';

import '../../../core/errors/app_exception.dart';
import '../../models/project.dart';
import '../project_repository.dart';
import 'mock_repository_utils.dart';

class MockProjectRepository implements ProjectRepository {
  MockProjectRepository({
    MockRepositoryConfig config = const MockRepositoryConfig(),
  })  : _runtime = MockRepositoryRuntime(config),
        _faker = Faker() {
    _projects.addAll(_seedProjects());
  }

  final MockRepositoryRuntime _runtime;
  final Faker _faker;
  final _controller = StreamController<void>.broadcast();
  final _projects = <Project>[];

  @override
  Future<List<Project>> getAll({String? userId}) async {
    await _runtime.simulateNetwork();
    return List<Project>.unmodifiable(_filter(userId));
  }

  @override
  Future<Project?> getById(String id) async {
    await _runtime.simulateNetwork();
    return _projects.where((project) => project.id == id).firstOrNull;
  }

  @override
  Future<Project> create(Project project) async {
    await _runtime.simulateNetwork();
    _projects.add(project);
    _emit();
    return project;
  }

  @override
  Future<Project> update(Project project) async {
    await _runtime.simulateNetwork();
    final index = _projects.indexWhere((item) => item.id == project.id);
    if (index == -1) {
      throw const NotFoundException('Project not found.',
          code: 'project_not_found');
    }
    final updated = project.copyWith(updatedAt: DateTime.now().toUtc());
    _projects[index] = updated;
    _emit();
    return updated;
  }

  @override
  Future<void> delete(String id) async {
    await _runtime.simulateNetwork();
    _projects.removeWhere((project) => project.id == id);
    _emit();
  }

  @override
  Stream<List<Project>> watch({String? userId}) async* {
    await _runtime.simulateNetwork();
    yield List<Project>.unmodifiable(_filter(userId));
    yield* _controller.stream
        .map((_) => List<Project>.unmodifiable(_filter(userId)));
  }

  List<Project> _seedProjects() {
    return List<Project>.generate(8, (index) {
      final createdAt =
          DateTime.now().toUtc().subtract(Duration(days: index + 1));
      return Project(
        id: 'project_${index + 1}',
        userId: 'user_${index % 3 + 1}',
        title: 'AutoShort ${_faker.lorem.words(3).join(' ')}',
        description: _faker.lorem.sentence(),
        status: ProjectStatus.values[index % ProjectStatus.values.length],
        originalVideoUrl: 'https://cdn.autoshort.test/source-${index + 1}.mp4',
        processedVideoUrl: index.isEven
            ? 'https://cdn.autoshort.test/short-${index + 1}.mp4'
            : null,
        thumbnailUrl: 'https://picsum.photos/seed/project-$index/720/1280',
        duration: 20 + _runtime.nextInt(80),
        aspectRatio: '9:16',
        resolution: '1080x1920',
        templateId: 'template_${index % 5 + 1}',
        brandKitId: 'brand_${index % 3 + 1}',
        tags: _faker.lorem.words(3),
        createdAt: createdAt,
        updatedAt: createdAt,
        publishedAt:
            index.isEven ? createdAt.add(const Duration(hours: 3)) : null,
      );
    });
  }

  List<Project> _filter(String? userId) {
    if (userId == null) {
      return [..._projects];
    }
    return _projects.where((project) => project.userId == userId).toList();
  }

  void _emit() => _controller.add(null);
}
