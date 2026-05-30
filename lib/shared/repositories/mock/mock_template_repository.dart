import 'dart:async';

import 'package:faker/faker.dart';

import '../../models/template.dart';
import '../template_repository.dart';
import 'mock_repository_utils.dart';

class MockTemplateRepository implements TemplateRepository {
  MockTemplateRepository({
    MockRepositoryConfig config = const MockRepositoryConfig(),
  })  : _runtime = MockRepositoryRuntime(config),
        _faker = Faker() {
    _templates.addAll(_seedTemplates());
  }

  final MockRepositoryRuntime _runtime;
  final Faker _faker;
  final _controller = StreamController<void>.broadcast();
  final _templates = <Template>[];

  @override
  Future<List<Template>> getAll() async {
    await _runtime.simulateNetwork();
    return List<Template>.unmodifiable(_templates);
  }

  @override
  Future<Template?> getById(String id) async {
    await _runtime.simulateNetwork();
    return _templates.where((template) => template.id == id).firstOrNull;
  }

  @override
  Future<List<Template>> getByCategory(String category) async {
    await _runtime.simulateNetwork();
    return List<Template>.unmodifiable(
      _templates.where((template) => template.category == category),
    );
  }

  @override
  Stream<List<Template>> watchAll() async* {
    await _runtime.simulateNetwork();
    yield List<Template>.unmodifiable(_templates);
    yield* _controller.stream
        .map((_) => List<Template>.unmodifiable(_templates));
  }

  List<Template> _seedTemplates() {
    const categories = ['podcast', 'education', 'reaction', 'story', 'review'];
    return List<Template>.generate(8, (index) {
      final category = categories[index % categories.length];
      return Template(
        id: 'template_${index + 1}',
        name:
            '${category[0].toUpperCase()}${category.substring(1)} ${index + 1}',
        description: _faker.lorem.sentence(),
        category: category,
        thumbnailUrl: 'https://picsum.photos/seed/template-$index/640/960',
        previewVideoUrl: 'https://cdn.autoshort.test/templates/$index.mp4',
        structure: TemplateStructure(
          duration: 30 + _runtime.nextInt(30),
          hooks: _faker.lorem.words(3),
          segments: const ['hook', 'context', 'payoff', 'cta'],
          transitions: const ['cut', 'zoom', 'caption-pop'],
          music: const ['cinematic-rise'],
        ),
        difficulty:
            TemplateDifficulty.values[index % TemplateDifficulty.values.length],
        tier: index < 3 ? TemplateTier.free : TemplateTier.premium,
        timesUsed: _runtime.nextInt(2500),
        rating: 3.8 + _runtime.nextDouble() * 1.2,
      );
    });
  }
}
