import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:shorts_ai/features/auth/providers/auth_provider.dart';
import 'package:shorts_ai/features/calendar/content_calendar_screen.dart';

import 'integration_flow_helper.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('calendar scheduler screen renders schedule action', (tester) async {
    await pumpFlowWidget(
      tester,
      const ContentCalendarScreen(),
      authState: Authenticated(integrationUser),
    );
    expect(find.byKey(const Key('calendar-screen')), findsOneWidget);
    expect(find.text('Schedule New'), findsOneWidget);
  });
}