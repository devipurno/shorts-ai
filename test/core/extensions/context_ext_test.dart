import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart' hide GoRouterHelper;
import 'package:shorts_ai/core/extensions/context_ext.dart';

void main() {
  testWidgets('exposes theme, colors, textTheme, and screen size',
      (tester) async {
    late BuildContext capturedContext;

    await tester.pumpWidget(
      MaterialApp(
        home: Builder(
          builder: (context) {
            capturedContext = context;
            return const SizedBox.shrink();
          },
        ),
      ),
    );

    expect(capturedContext.theme, isA<ThemeData>());
    expect(capturedContext.colors, isA<ColorScheme>());
    expect(capturedContext.textTheme, isA<TextTheme>());
    expect(capturedContext.screenWidth, greaterThan(0));
    expect(capturedContext.screenHeight, greaterThan(0));
  });

  testWidgets('shows snackbar and error snackbar', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Builder(
            builder: (context) {
              return Column(
                children: [
                  TextButton(
                    onPressed: () => context.showSnackbar('Saved'),
                    child: const Text('snackbar'),
                  ),
                  TextButton(
                    onPressed: () => context.showError('Failed'),
                    child: const Text('error'),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );

    await tester.tap(find.text('snackbar'));
    await tester.pump();
    expect(find.text('Saved'), findsOneWidget);

    await tester.tap(find.text('error'));
    await tester.pump();
    expect(find.text('Failed'), findsOneWidget);
  });

  testWidgets('wraps go_router push and pop', (tester) async {
    final router = GoRouter(
      initialLocation: '/',
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) {
            return TextButton(
              onPressed: () => AutoShortBuildContextX(context).push('/detail'),
              child: const Text('go'),
            );
          },
        ),
        GoRoute(
          path: '/detail',
          builder: (context, state) {
            return TextButton(
              onPressed: AutoShortBuildContextX(context).pop,
              child: const Text('back'),
            );
          },
        ),
      ],
    );

    await tester.pumpWidget(MaterialApp.router(routerConfig: router));
    await tester.tap(find.text('go'));
    await tester.pumpAndSettle();
    expect(find.text('back'), findsOneWidget);

    await tester.tap(find.text('back'));
    await tester.pumpAndSettle();
    expect(find.text('go'), findsOneWidget);
  });
}
