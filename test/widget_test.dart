import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:shorts_ai/core/theme/app_typography.dart';
import 'package:shorts_ai/main.dart';

void main() {
  setUpAll(() {
    AppTypography.setUseGoogleFontsForTest(false);
  });

  testWidgets('App redirects unauthenticated user to login route', (
    tester,
  ) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: MyApp(),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.byKey(const Key('placeholder-Login')), findsOneWidget);
  });
}
