import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shorts_ai/core/theme/app_theme.dart';
import 'package:shorts_ai/core/theme/app_typography.dart';
import 'package:shorts_ai/features/auth/models/user.dart';
import 'package:shorts_ai/features/auth/providers/auth_provider.dart';

final integrationUser = User(
  id: 'integration-user',
  email: 'creator@autoshort.id',
  name: 'Devi',
  tier: SubscriptionTier.premium,
  createdAt: DateTime(2026),
);

Future<void> pumpFlowWidget(
  WidgetTester tester,
  Widget child, {
  AuthState authState = const Unauthenticated(),
}) async {
  AppTypography.setUseGoogleFontsForTest(false);
  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        authMockDelayProvider.overrideWith((ref) => Duration.zero),
        authProvider.overrideWith((ref) => _FlowAuthNotifier(authState)),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: darkTheme(),
        home: child,
      ),
    ),
  );
  await tester.pumpAndSettle();
}

class _FlowAuthNotifier extends AuthNotifier {
  _FlowAuthNotifier(AuthState seed) : super(mockDelay: Duration.zero) {
    state = seed;
  }
}
