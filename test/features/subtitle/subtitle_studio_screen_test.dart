import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shorts_ai/core/theme/app_theme.dart';
import 'package:shorts_ai/core/theme/app_typography.dart';
import 'package:shorts_ai/features/subtitle/subtitle_studio_screen.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() {
    AppTypography.setUseGoogleFontsForTest(false);
  });

  testWidgets('renders preview, timeline, and switches all four tabs',
      (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          theme: darkTheme(),
          home: const SubtitleStudioScreen(videoId: 'project_1'),
        ),
      ),
    );
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 350));

    expect(find.byKey(const Key('subtitle-studio-screen')), findsOneWidget);
    expect(find.byKey(const Key('subtitle-video-preview')), findsOneWidget);
    expect(find.byKey(const Key('subtitle-timeline')), findsOneWidget);
    expect(find.byKey(const Key('subtitle-tab-segments')), findsOneWidget);

    await _tapTab(tester, 'style');
    expect(find.byKey(const Key('subtitle-tab-style')), findsOneWidget);
    expect(find.byKey(const Key('subtitle-style-preview')), findsWidgets);

    await _tapTab(tester, 'animation');
    expect(find.byKey(const Key('subtitle-tab-animation')), findsOneWidget);

    await _tapTab(tester, 'export');
    expect(find.byKey(const Key('subtitle-tab-export')), findsOneWidget);
    expect(find.byKey(const Key('subtitle-format-ass')), findsOneWidget);
  });
}

Future<void> _tapTab(WidgetTester tester, String tabName) async {
  final tab = find.byKey(Key('subtitle-tab-button-$tabName'));
  await tester.tap(tab);
  await tester.pump();
  await tester.pump(const Duration(milliseconds: 250));
}
