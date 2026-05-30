import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shorts_ai/core/theme/app_theme.dart';
import 'package:shorts_ai/core/theme/app_typography.dart';
import 'package:shorts_ai/shared/widgets/brand/app_logo.dart';

void main() {
  setUpAll(() {
    AppTypography.setUseGoogleFontsForTest(false);
  });

  testWidgets('renders monogram and wordmark SVG logos', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: darkTheme(),
        home: const Scaffold(
          body: Column(
            children: [
              AppLogo(
                variant: AppLogoVariant.monogram,
                size: AppLogoSize.sm,
              ),
              AppLogo(
                variant: AppLogoVariant.wordmark,
                size: AppLogoSize.lg,
              ),
            ],
          ),
        ),
      ),
    );
    await tester.pump();

    expect(find.byType(SvgPicture), findsNWidgets(2));
    expect(find.bySemanticsLabel('AutoShort monogram'), findsOneWidget);
    expect(find.bySemanticsLabel('AutoShort wordmark'), findsOneWidget);
  });
}
