import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:shorts_ai/features/auth/providers/auth_provider.dart';
import 'package:shorts_ai/features/templates/template_library_screen.dart';

import '../golden_test_helper.dart';

void main() {
  setUpGoldenTests();

  testGoldens('template library GOLDEN', (tester) async {
    await pumpResponsiveGolden(
      tester,
      authState: Authenticated(goldenUser),
      builder: () => const TemplateLibraryScreen(),
    );
    await expectResponsiveGolden(tester, 'template_library');
  });
}