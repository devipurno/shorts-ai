import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shorts_ai/core/theme/app_theme.dart';
import 'package:shorts_ai/core/theme/app_typography.dart';
import 'package:shorts_ai/features/templates/template_library_screen.dart';
import 'package:shorts_ai/shared/models/template.dart';
import 'package:shorts_ai/shared/repositories/providers.dart';
import 'package:shorts_ai/shared/repositories/template_repository.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() {
    AppTypography.setUseGoogleFontsForTest(false);
  });

  testWidgets('renders template library and filters search results', (
    tester,
  ) async {
    await tester.pumpWidget(
      _TemplateHarness(
        templates: _templates,
        child: const TemplateLibraryScreen(),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.byKey(const Key('template-library-screen')), findsOneWidget);
    expect(find.byKey(const Key('template-library-grid')), findsOneWidget);
    expect(find.text('Tutorial How-To'), findsOneWidget);
    expect(find.text('Podcast 2-Speaker Split'), findsWidgets);

    await tester.enterText(find.byType(TextField).first, 'tutorial');
    await tester.pumpAndSettle();

    expect(find.text('Tutorial How-To'), findsOneWidget);
    expect(
        find.byKey(const Key('template-library-card-podcast')), findsNothing);

    await tester.tap(find.byKey(const Key('template-clear-filter')));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('template-tier-premium')));
    await tester.pumpAndSettle();

    expect(
        find.byKey(const Key('template-library-card-podcast')), findsOneWidget);
    expect(
        find.byKey(const Key('template-library-card-tutorial')), findsNothing);
  });

  testWidgets('renders premium template detail with upgrade CTA',
      (tester) async {
    await tester.pumpWidget(
      _TemplateHarness(
        templates: _templates,
        child: const TemplateDetailScreen(templateId: 'podcast'),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.byKey(const Key('template-detail-screen')), findsOneWidget);
    expect(find.text('Podcast 2-Speaker Split'), findsWidgets);
    await tester.drag(find.byType(ListView), const Offset(0, -520));
    await tester.pumpAndSettle();
    expect(find.text('Blueprint'), findsOneWidget);
    expect(find.byKey(const Key('template-upgrade-button')), findsOneWidget);
  });
}

class _TemplateHarness extends StatelessWidget {
  const _TemplateHarness({
    required this.child,
    required this.templates,
  });

  final Widget child;
  final List<Template> templates;

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      overrides: [
        templateRepositoryProvider.overrideWithValue(
          _FakeTemplateRepository(templates),
        ),
      ],
      child: MaterialApp(
        theme: darkTheme(),
        home: child,
      ),
    );
  }
}

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

const _templates = <Template>[
  Template(
    id: 'tutorial',
    name: 'Tutorial How-To',
    description: 'Step by step educational structure',
    category: 'education',
    tier: TemplateTier.free,
    timesUsed: 400,
    rating: 4.7,
    structure: TemplateStructure(
      duration: 45,
      hooks: ['how to'],
      segments: ['hook', 'steps', 'result'],
      transitions: ['cut'],
      music: ['clean-focus'],
    ),
  ),
  Template(
    id: 'podcast',
    name: 'Podcast 2-Speaker Split',
    description: 'Split-frame podcast template',
    category: 'podcast',
    tier: TemplateTier.premium,
    timesUsed: 900,
    rating: 4.9,
    structure: TemplateStructure(
      duration: 75,
      hooks: ['speaker debate'],
      segments: ['speaker 1', 'speaker 2', 'payoff'],
      transitions: ['split-screen'],
      music: ['calm-conversation'],
    ),
  ),
];
