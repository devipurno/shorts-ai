import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

@Tags(['perf'])
void main() {
  testWidgets(
    'Template grid scrolls 26 cards within widget budget',
    (tester) async {
      await tester.pumpWidget(MaterialApp(
        home: GridView.builder(
          itemCount: 26,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 9 / 16,
          ),
          itemBuilder: (context, index) => Card(child: Text('Template $index')),
        ),
      ));

      final stopwatch = Stopwatch()..start();
      await tester.drag(find.byType(GridView), const Offset(0, -600));
      await tester.pumpAndSettle();
      stopwatch.stop();

      expect(stopwatch.elapsedMilliseconds, lessThan(1000));
    },
    skip: true,
  );
}