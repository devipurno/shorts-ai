import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shorts_ai/core/theme/app_theme.dart';
import 'package:shorts_ai/core/theme/app_typography.dart';
import 'package:shorts_ai/features/thumbnail/thumbnail_editor_screen.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() {
    AppTypography.setUseGoogleFontsForTest(false);
  });

  testWidgets('renders canvas and switches thumbnail editor tabs',
      (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          theme: darkTheme(),
          home: const ThumbnailEditorScreen(videoId: 'project_1'),
        ),
      ),
    );
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 350));

    expect(find.byKey(const Key('thumbnail-editor-screen')), findsOneWidget);
    expect(
        find.byKey(const Key('thumbnail-canvas-interactive')), findsOneWidget);
    expect(find.byKey(const Key('thumbnail-ab-toggle')), findsOneWidget);
    expect(find.byKey(const Key('thumbnail-tab-frame')), findsOneWidget);

    await _tapTab(tester, 'text');
    expect(find.byKey(const Key('thumbnail-tab-text')), findsOneWidget);

    await tester.tap(find.byKey(const Key('thumbnail-add-text')));
    await tester.pump();
    expect(find.text('VIRAL MOMENT'), findsWidgets);

    await _tapTab(tester, 'aiGenerate');
    expect(find.byKey(const Key('thumbnail-tab-ai')), findsOneWidget);

    await tester.drag(
        find.byKey(const Key('thumbnail-tab-ai')), const Offset(0, -260));
    await tester.pump();
    final aiButton = find.byKey(const Key('thumbnail-ai-generate'));
    await tester.tap(aiButton);
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 600));
    expect(
        find.textContaining('Bold').evaluate().isNotEmpty ||
            find.textContaining('Cinematic').evaluate().isNotEmpty,
        isTrue);

    await _tapTab(tester, 'ctrPredict');
    expect(find.byKey(const Key('thumbnail-tab-ctr')), findsOneWidget);
    final ctrButton = find.byKey(const Key('thumbnail-predict-ctr'));
    await tester.ensureVisible(ctrButton);
    await tester.tap(ctrButton);
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 900));
    await tester.drag(
        find.byKey(const Key('thumbnail-tab-ctr')), const Offset(0, -260));
    await tester.pump();
    expect(find.text('Tips improvement'), findsOneWidget);
  });
}

Future<void> _tapTab(WidgetTester tester, String tabName) async {
  final tab = find.byKey(Key('thumbnail-tab-button-$tabName'));
  await tester.ensureVisible(tab);
  await tester.tap(tab);
  await tester.pump();
  await tester.pump(const Duration(milliseconds: 250));
}
