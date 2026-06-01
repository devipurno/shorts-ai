import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:shorts_ai/features/auth/screens/login_screen.dart';
import 'package:shorts_ai/features/auth/screens/signup_screen.dart';

import 'integration_flow_helper.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('signup and login screens are reachable', (tester) async {
    await pumpFlowWidget(tester, const SignupScreen());
    expect(find.text('Daftar Gratis'), findsOneWidget);

    await pumpFlowWidget(tester, const LoginScreen());
    expect(find.text('Masuk'), findsWidgets);
  });
}