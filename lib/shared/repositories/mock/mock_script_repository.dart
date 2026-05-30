import 'dart:async';

import 'package:faker/faker.dart';

import '../../../core/errors/app_exception.dart';
import '../../models/script.dart';
import '../script_repository.dart';
import 'mock_repository_utils.dart';

class MockScriptRepository implements ScriptRepository {
  MockScriptRepository({
    MockRepositoryConfig config = const MockRepositoryConfig(),
  })  : _runtime = MockRepositoryRuntime(config),
        _faker = Faker() {
    _scripts.addAll(_seedScripts());
  }

  final MockRepositoryRuntime _runtime;
  final Faker _faker;
  final _controller = StreamController<void>.broadcast();
  final _scripts = <Script>[];

  @override
  Future<List<Script>> getAll({String? projectId}) async {
    await _runtime.simulateNetwork();
    return List<Script>.unmodifiable(_filter(projectId));
  }

  @override
  Future<Script?> getById(String id) async {
    await _runtime.simulateNetwork();
    return _scripts.where((script) => script.id == id).firstOrNull;
  }

  @override
  Future<Script> create(Script script) async {
    await _runtime.simulateNetwork();
    _scripts.add(script);
    _emit();
    return script;
  }

  @override
  Future<Script> update(Script script) async {
    await _runtime.simulateNetwork();
    final index = _scripts.indexWhere((item) => item.id == script.id);
    if (index == -1) {
      throw const NotFoundException('Script not found.',
          code: 'script_not_found');
    }
    _scripts[index] = script;
    _emit();
    return script;
  }

  @override
  Future<void> delete(String id) async {
    await _runtime.simulateNetwork();
    _scripts.removeWhere((script) => script.id == id);
    _emit();
  }

  @override
  Stream<List<Script>> watch({String? projectId}) async* {
    await _runtime.simulateNetwork();
    yield List<Script>.unmodifiable(_filter(projectId));
    yield* _controller.stream
        .map((_) => List<Script>.unmodifiable(_filter(projectId)));
  }

  List<Script> _seedScripts() {
    return List<Script>.generate(6, (index) {
      final hooks = List<HookOption>.generate(5, (hookIndex) {
        return HookOption(
          id: 'hook_${index + 1}_$hookIndex',
          text: _faker.lorem.sentence(),
          style: HookStyle.values[hookIndex % HookStyle.values.length],
          score: 55 + _runtime.nextInt(45).toDouble(),
        );
      });

      return Script(
        id: 'script_${index + 1}',
        projectId: 'project_${index + 1}',
        content: _faker.lorem.sentences(4).join(' '),
        hookOptions: hooks,
        selectedHookId: hooks.first.id,
        language: 'id',
        durationEstimate: 25 + _runtime.nextInt(35),
        aiModelUsed: 'mock-gpt',
        generatedAt: DateTime.now().toUtc().subtract(Duration(hours: index)),
      );
    });
  }

  List<Script> _filter(String? projectId) {
    if (projectId == null) {
      return [..._scripts];
    }
    return _scripts.where((script) => script.projectId == projectId).toList();
  }

  void _emit() => _controller.add(null);
}
