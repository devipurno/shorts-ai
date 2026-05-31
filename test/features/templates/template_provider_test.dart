import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shorts_ai/features/auth/models/user.dart';
import 'package:shorts_ai/features/auth/providers/current_user_provider.dart';
import 'package:shorts_ai/features/templates/providers/template_provider.dart';
import 'package:shorts_ai/shared/models/project.dart';
import 'package:shorts_ai/shared/models/template.dart';
import 'package:shorts_ai/shared/repositories/project_repository.dart';
import 'package:shorts_ai/shared/repositories/providers.dart';
import 'package:shorts_ai/shared/repositories/template_repository.dart';

void main() {
  test('filters templates by category and query', () {
    final filtered = applyTemplateFilter(
      _templates,
      const TemplateFilter(
        category: TemplateCategory.education,
        query: 'tutorial',
      ),
    );

    expect(filtered, hasLength(1));
    expect(filtered.single.id, 'tutorial');
  });

  test('filters trending templates by usage threshold', () {
    final filtered = applyTemplateFilter(
      _templates,
      const TemplateFilter(category: TemplateCategory.trending),
    );

    expect(filtered.map((template) => template.id), ['podcast']);
  });

  test('templateListProvider paginates results by 20', () async {
    final container = ProviderContainer(
      overrides: [
        templateRepositoryProvider.overrideWithValue(
          _FakeTemplateRepository(_generatedTemplates),
        ),
      ],
    );
    addTearDown(container.dispose);

    final first = await container.read(
      templateListProvider(
        const TemplateFilter(category: TemplateCategory.all),
      ).future,
    );
    final second = await container.read(
      templateListProvider(
        const TemplateFilter(category: TemplateCategory.all, page: 1),
      ).future,
    );

    expect(first.items, hasLength(20));
    expect(first.hasMore, isTrue);
    expect(second.items, hasLength(5));
    expect(second.hasMore, isFalse);
  });

  test('useTemplateMutation creates a project from template', () async {
    final projectRepository = _FakeProjectRepository();
    final container = ProviderContainer(
      overrides: [
        templateRepositoryProvider.overrideWithValue(
          const _FakeTemplateRepository(_templates),
        ),
        projectRepositoryProvider.overrideWithValue(projectRepository),
        currentUserProvider.overrideWithValue(_premiumUser),
      ],
    );
    addTearDown(container.dispose);

    final projectId =
        await container.read(useTemplateMutationProvider)('tutorial');

    expect(projectId, startsWith('project_template_'));
    expect(projectRepository.created.single.templateId, 'tutorial');
    expect(projectRepository.created.single.userId, _premiumUser.id);
  });
}

final _premiumUser = User(
  id: 'premium-user',
  email: 'premium@autoshort.id',
  tier: SubscriptionTier.premium,
  createdAt: DateTime(2026),
);

final _generatedTemplates = List<Template>.generate(
  25,
  (index) => Template(
    id: 'template_$index',
    name: 'Template $index',
    description: 'Generated template $index',
    category: index.isEven ? 'education' : 'tech',
    timesUsed: index,
    rating: 4 + (index % 10) / 10,
    structure: const TemplateStructure(duration: 30),
  ),
);

const _templates = <Template>[
  Template(
    id: 'tutorial',
    name: 'Tutorial How-To',
    description: 'Step by step tutorial structure',
    category: 'education',
    tier: TemplateTier.free,
    timesUsed: 400,
    rating: 4.7,
    structure: TemplateStructure(
      duration: 45,
      hooks: ['how to'],
      segments: ['hook', 'steps'],
    ),
  ),
  Template(
    id: 'podcast',
    name: 'Podcast 2-Speaker Split',
    description: 'Speaker split template',
    category: 'podcast_split',
    tier: TemplateTier.premium,
    timesUsed: 1200,
    rating: 4.9,
    structure: TemplateStructure(
      duration: 75,
      hooks: ['speaker debate'],
      segments: ['speaker 1', 'speaker 2'],
    ),
  ),
  Template(
    id: 'story',
    name: 'Lifestyle Story',
    description: 'Narrative format',
    category: 'lifestyle',
    tier: TemplateTier.free,
    timesUsed: 100,
    rating: 4.2,
  ),
];

class _FakeTemplateRepository implements TemplateRepository {
  const _FakeTemplateRepository(this.templates);

  final List<Template> templates;

  @override
  Future<List<Template>> getAll() async => templates;

  @override
  Future<Template?> getById(String id) async {
    return templates.where((template) => template.id == id).firstOrNull;
  }

  @override
  Future<List<Template>> getByCategory(String category) async {
    return templates
        .where((template) => template.category == category)
        .toList(growable: false);
  }

  @override
  Stream<List<Template>> watchAll() => Stream.value(templates);
}

class _FakeProjectRepository implements ProjectRepository {
  final created = <Project>[];

  @override
  Future<Project> create(Project project) async {
    created.add(project);
    return project;
  }

  @override
  Future<void> delete(String id) async {}

  @override
  Future<List<Project>> getAll({String? userId}) async => created;

  @override
  Future<Project?> getById(String id) async {
    return created.where((project) => project.id == id).firstOrNull;
  }

  @override
  Future<Project> update(Project project) async => project;

  @override
  Stream<List<Project>> watch({String? userId}) => Stream.value(created);
}
