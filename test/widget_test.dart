import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:shorts_ai/core/theme/app_typography.dart';
import 'package:shorts_ai/main.dart';

void main() {
  setUpAll(() {
    AppTypography.setUseGoogleFontsForTest(false);
  });

  testWidgets('App shows splash then sends unauthenticated user to onboarding',
      (
    tester,
  ) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: MyApp(),
      ),
    );
    await tester.pump();

    expect(find.byKey(const Key('splash-screen')), findsOneWidget);

    await tester.pump(const Duration(seconds: 3));
    await tester.pumpAndSettle();

    expect(find.byKey(const Key('placeholder-Onboarding')), findsOneWidget);
  });
}
