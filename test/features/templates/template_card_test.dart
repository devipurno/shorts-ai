import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shorts_ai/core/theme/app_theme.dart';
import 'package:shorts_ai/core/theme/app_typography.dart';
import 'package:shorts_ai/features/templates/models/template_model.dart';
import 'package:shorts_ai/features/templates/widgets/template_card.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() {
    AppTypography.setUseGoogleFontsForTest(false);
  });

  testWidgets('renders template card badges and duration', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: darkTheme(),
        home: const Scaffold(
          body: SizedBox(
            width: 220,
            child: TemplateCard(template: _premiumTemplate),
          ),
        ),
      ),
    );

    expect(find.byKey(const Key('template-card-premium')), findsOneWidget);
    expect(find.text('Premium'), findsOneWidget);
    expect(find.text('Coming'), findsOneWidget);
    expect(find.text('Lifestyle'), findsOneWidget);
    expect(find.byKey(const Key('template-duration-premium')), findsOneWidget);
    expect(find.text('45s'), findsOneWidget);
  });

  testWidgets('fires tap and long-press callbacks', (tester) async {
    var tapped = false;
    var longPressed = false;

    await tester.pumpWidget(
      MaterialApp(
        theme: darkTheme(),
        home: Scaffold(
          body: SizedBox(
            width: 220,
            child: TemplateCard(
              template: _premiumTemplate,
              onTap: () => tapped = true,
              onLongPress: () => longPressed = true,
            ),
          ),
        ),
      ),
    );

    await tester.tap(find.byKey(const Key('template-card-premium')));
    await tester.longPress(find.byKey(const Key('template-card-premium')));

    expect(tapped, isTrue);
    expect(longPressed, isTrue);
  });
}

const _premiumTemplate = TemplateModel(
  id: 'premium',
  name: 'Premium Lifestyle',
  description: 'A polished lifestyle starter template.',
  category: 'Lifestyle',
  thumbnailUrl: '',
  previewVideoUrl: '',
  duration: Duration(seconds: 45),
  tags: ['vertical', 'premium'],
  isPremium: true,
  status: TemplateStatus.comingSoon,
);
