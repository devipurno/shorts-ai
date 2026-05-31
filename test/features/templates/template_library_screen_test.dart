import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shorts_ai/core/theme/app_theme.dart';
import 'package:shorts_ai/core/theme/app_typography.dart';
import 'package:shorts_ai/features/auth/models/user.dart';
import 'package:shorts_ai/features/auth/providers/current_user_provider.dart';
import 'package:shorts_ai/features/templates/template_detail_screen.dart';
import 'package:shorts_ai/features/templates/template_library_screen.dart';
import 'package:shorts_ai/shared/models/template.dart';
import 'package:shorts_ai/shared/repositories/providers.dart';
import 'package:shorts_ai/shared/repositories/template_repository.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() {
    AppTypography.setUseGoogleFontsForTest(false);
  });

  testWidgets('renders template grid and filters by category/search', (
    tester,
  ) async {
    await tester.pumpWidget(
      _TemplateHarness(
        templates: _generatedTemplates,
        child: const TemplateLibraryScreen(),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.byKey(const Key('template-library-screen')), findsOneWidget);
    expect(find.byKey(const Key('template-library-grid')), findsOneWidget);
    expect(find.byKey(const Key('template-card-template_9')), findsOneWidget);

    await tester.enterText(find.byType(TextField).first, 'Template 24');
    await tester.pumpAndSettle();

    expect(find.byKey(const Key('template-card-template_24')), findsOneWidget);
    expect(find.byKey(const Key('template-card-template_9')), findsNothing);

    await tester.enterText(find.byType(TextField).first, '');
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('template-category-tech')));
    await tester.pumpAndSettle();

    expect(find.byKey(const Key('template-card-template_9')), findsOneWidget);
    expect(find.byKey(const Key('template-card-template_24')), findsNothing);
  });

  testWidgets('free user sees upgrade CTA for premium template',
      (tester) async {
    await tester.pumpWidget(
      _TemplateHarness(
        templates: _templates,
        user: _freeUser,
        child: const TemplateDetailScreen(templateId: 'podcast'),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.byKey(const Key('template-detail-screen')), findsOneWidget);
    expect(find.byKey(const Key('template-video-preview')), findsOneWidget);
    await tester.drag(find.byType(ListView), const Offset(0, -700));
    await tester.pumpAndSettle();
    expect(find.text('Podcast 2-Speaker Split'), findsWidgets);
    expect(find.byKey(const Key('template-upgrade-button')), findsOneWidget);
    expect(find.byKey(const Key('template-use-button')), findsNothing);
  });

  testWidgets('premium user can use free template from detail', (tester) async {
    await tester.pumpWidget(
      _TemplateHarness(
        templates: _templates,
        user: _premiumUser,
        child: const TemplateDetailScreen(templateId: 'tutorial'),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.byKey(const Key('template-video-preview')), findsOneWidget);
    await tester.drag(find.byType(ListView), const Offset(0, -700));
    await tester.pumpAndSettle();
    expect(find.text('Structure preview'), findsOneWidget);
    expect(find.byKey(const Key('template-use-button')), findsOneWidget);
  });
}

class _TemplateHarness extends StatelessWidget {
  const _TemplateHarness({
    required this.child,
    required this.templates,
    this.user,
  });

  final Widget child;
  final List<Template> templates;
  final User? user;

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      overrides: [
        templateRepositoryProvider.overrideWithValue(
          _FakeTemplateRepository(templates),
        ),
        if (user != null) currentUserProvider.overrideWithValue(user),
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

final _freeUser = User(
  id: 'free-user',
  email: 'free@autoshort.id',
  tier: SubscriptionTier.free,
  createdAt: DateTime(2026),
);

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
    timesUsed: index == 0 ? 1200 : index,
    rating: 4 + (index % 10) / 10,
    structure: const TemplateStructure(duration: 30),
  ),
);

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
    category: 'podcast_split',
    tier: TemplateTier.premium,
    timesUsed: 1200,
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
