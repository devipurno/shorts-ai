import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shorts_ai/core/theme/app_theme.dart';
import 'package:shorts_ai/core/theme/app_typography.dart';
import 'package:shorts_ai/features/auth/models/user.dart';
import 'package:shorts_ai/features/auth/providers/current_user_provider.dart';
import 'package:shorts_ai/features/hook_generator/hook_generator_screen.dart';
import 'package:shorts_ai/features/hook_generator/services/ai_hook_service.dart';
import 'package:shorts_ai/shared/models/script.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() {
    AppTypography.setUseGoogleFontsForTest(false);
  });

  testWidgets('generates hook cards from the form', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          currentUserProvider.overrideWithValue(_premiumUser),
          aiHookServiceProvider.overrideWithValue(_FakeAiHookService()),
        ],
        child: MaterialApp(
          theme: darkTheme(),
          home: const HookGeneratorScreen(),
        ),
      ),
    );

    await tester.enterText(
      find.byKey(const Key('hook-topic-input')),
      'ide konten finance',
    );
    await tester.scrollUntilVisible(
      find.byKey(const Key('hook-generate-button')),
      500,
      scrollable: find.byType(Scrollable).first,
    );
    await tester.tap(find.byKey(const Key('hook-generate-button')));
    await tester.pumpAndSettle();

    await tester.scrollUntilVisible(
      find.textContaining('ide konten finance hook variant 1'),
      500,
      scrollable: find.byType(Scrollable).first,
    );
    expect(find.text('Results'), findsOneWidget);
    expect(
      find.textContaining('ide konten finance hook variant 1'),
      findsOneWidget,
    );

    expect(find.byIcon(Icons.favorite_border_rounded), findsWidgets);
  });
}

final _premiumUser = User(
  id: 'premium-user',
  email: 'premium@autoshort.id',
  tier: SubscriptionTier.premium,
  createdAt: DateTime(2026),
);

class _FakeAiHookService extends AiHookService {
  @override
  Future<List<HookOption>> generate({
    required String topic,
    required List<HookStyle> styles,
    required String niche,
    required HookLanguage language,
    String? customStylePrompt,
  }) async {
    return List<HookOption>.generate(
      5,
      (index) => HookOption(
        id: 'screen_hook_$index',
        text: '$topic hook variant ${index + 1}',
        style: HookStyle.values[index % HookStyle.values.length],
        score: (50 + index * 10).toDouble(),
      ),
    );
  }
}
