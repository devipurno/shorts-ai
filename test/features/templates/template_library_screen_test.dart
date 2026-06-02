import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:shorts_ai/core/theme/app_theme.dart';
import 'package:shorts_ai/core/theme/app_typography.dart';
import 'package:shorts_ai/features/templates/data/mock_templates.dart';
import 'package:shorts_ai/features/templates/models/template_model.dart';
import 'package:shorts_ai/features/templates/providers/template_provider.dart';
import 'package:shorts_ai/features/templates/template_detail_screen.dart';
import 'package:shorts_ai/features/templates/template_library_screen.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() {
    AppTypography.setUseGoogleFontsForTest(false);
  });

  testWidgets('renders starter templates and filters by category', (
    tester,
  ) async {
    await tester.pumpWidget(
      _TemplateHarness(
        templates: _testTemplates,
        child: const TemplateLibraryScreen(),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.byKey(const Key('templates-gallery-screen')), findsOneWidget);
    expect(find.byKey(const Key('templates-starter-banner')), findsOneWidget);
    expect(find.byKey(const Key('templates-gallery-grid')), findsOneWidget);
    expect(find.byKey(const Key('template-card-motivation')), findsOneWidget);
    expect(find.byKey(const Key('template-card-quote')), findsOneWidget);

    await tester.tap(find.byKey(const Key('template-filter-Quote')));
    await tester.pumpAndSettle();

    expect(find.byKey(const Key('template-card-quote')), findsOneWidget);
    expect(find.byKey(const Key('template-card-motivation')), findsNothing);
  });

  testWidgets('shows empty state when filtered templates are empty', (
    tester,
  ) async {
    await tester.pumpWidget(
      _TemplateHarness(
        templates: const <TemplateModel>[],
        child: const TemplateLibraryScreen(),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Belum ada template'), findsOneWidget);
    expect(
      find.text('Template untuk kategori ini belum tersedia.'),
      findsOneWidget,
    );
  });

  testWidgets('tap template opens detail preview route', (tester) async {
    await tester.pumpWidget(_TemplateRouterHarness(templates: _testTemplates));
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(const Key('template-card-motivation')));
    await tester.pumpAndSettle();

    expect(find.byKey(const Key('template-detail-screen')), findsOneWidget);
    expect(find.text('Motivation Starter'), findsOneWidget);
    expect(
        find.byKey(const Key('template-preview-coming-soon')), findsOneWidget);
    expect(find.byKey(const Key('template-use-button')), findsOneWidget);
  });

  testWidgets('long press template opens info sheet', (tester) async {
    await tester.pumpWidget(
      _TemplateHarness(
        templates: _testTemplates,
        child: const TemplateLibraryScreen(),
      ),
    );
    await tester.pumpAndSettle();

    await tester.longPress(find.byKey(const Key('template-card-motivation')));
    await tester.pumpAndSettle();

    expect(find.byKey(const Key('template-info-sheet')), findsOneWidget);
    expect(find.text('Motivation Starter'), findsWidgets);
  });

  test('mock templates provide exactly five starter items', () {
    expect(mockTemplates, hasLength(5));
    expect(mockTemplates.every((template) => template.previewVideoUrl.isEmpty),
        isTrue);
  });
}

class _TemplateHarness extends StatelessWidget {
  const _TemplateHarness({required this.child, required this.templates});

  final Widget child;
  final List<TemplateModel> templates;

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      overrides: [
        templatesProvider.overrideWith((ref) async => templates),
      ],
      child: MaterialApp(
        theme: darkTheme(),
        home: child,
      ),
    );
  }
}

class _TemplateRouterHarness extends StatelessWidget {
  const _TemplateRouterHarness({required this.templates});

  final List<TemplateModel> templates;

  @override
  Widget build(BuildContext context) {
    final router = GoRouter(
      initialLocation: '/templates',
      routes: [
        GoRoute(
          path: '/templates',
          builder: (context, state) => const TemplateLibraryScreen(),
        ),
        GoRoute(
          path: '/templates/:templateId',
          builder: (context, state) => TemplateDetailScreen(
            templateId: state.pathParameters['templateId']!,
          ),
        ),
      ],
    );

    return ProviderScope(
      overrides: [
        templatesProvider.overrideWith((ref) async => templates),
      ],
      child: MaterialApp.router(
        theme: darkTheme(),
        routerConfig: router,
      ),
    );
  }
}

const _testTemplates = <TemplateModel>[
  TemplateModel(
    id: 'motivation',
    name: 'Motivation Starter',
    description: 'Quick punchy structure for daily motivation shorts.',
    category: 'Motivation',
    thumbnailUrl: '',
    previewVideoUrl: '',
    duration: Duration(seconds: 30),
    tags: ['vertical', 'quotes'],
    isPremium: false,
    status: TemplateStatus.comingSoon,
  ),
  TemplateModel(
    id: 'quote',
    name: 'Quote Pack',
    description: 'Fast quote format with cinematic pacing.',
    category: 'Quote',
    thumbnailUrl: '',
    previewVideoUrl: '',
    duration: Duration(seconds: 18),
    tags: ['text', 'b-roll'],
    isPremium: true,
    status: TemplateStatus.comingSoon,
  ),
];
