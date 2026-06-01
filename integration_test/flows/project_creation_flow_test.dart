import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:shorts_ai/features/auth/providers/auth_provider.dart';
import 'package:shorts_ai/features/home/home_screen.dart';

import 'integration_flow_helper.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('home create project entry point is visible', (tester) async {
    await pumpFlowWidget(
      tester,
      const HomeScreen(),
      authState: Authenticated(integrationUser),
    );
    await tester.pump(const Duration(seconds: 1));
    expect(find.text('Buat Shorts Baru'), findsOneWidget);
  });
}
