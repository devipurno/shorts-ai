import 'package:flutter_test/flutter_test.dart';
import 'package:shorts_ai/features/templates/providers/template_library_provider.dart';
import 'package:shorts_ai/shared/models/template.dart';

void main() {
  test('filters templates by query, category, and tier', () {
    final filtered = applyTemplateLibraryFilter(
      _templates,
      filter: const TemplateLibraryFilterState(
        category: 'podcast',
        tier: TemplateTierFilter.premium,
      ),
      query: 'speaker',
    );

    expect(filtered, hasLength(1));
    expect(filtered.single.id, 'podcast');
  });

  test('sorts templates by rating and usage', () {
    final sorted = applyTemplateLibraryFilter(
      _templates,
      filter:
          const TemplateLibraryFilterState(sort: TemplateSortOrder.topRated),
      query: '',
    );

    expect(sorted.first.id, 'podcast');
    expect(sorted[1].id, 'tutorial');
  });
}

const _templates = <Template>[
  Template(
    id: 'tutorial',
    name: 'Tutorial How-To',
    description: 'Step by step template',
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
    category: 'podcast',
    tier: TemplateTier.premium,
    timesUsed: 900,
    rating: 4.9,
    structure: TemplateStructure(
      duration: 75,
      hooks: ['speaker debate'],
      segments: ['speaker 1', 'speaker 2'],
    ),
  ),
  Template(
    id: 'story',
    name: 'Story Curhat',
    description: 'Narrative format',
    category: 'story',
    tier: TemplateTier.free,
    timesUsed: 100,
    rating: 4.2,
  ),
];
