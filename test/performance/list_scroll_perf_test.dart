import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

@Tags(['perf'])
void main() {
  testWidgets(
    'Library grid with 100 projects scrolls within widget budget',
    (tester) async {
      await tester.pumpWidget(MaterialApp(
        home: GridView.builder(
          itemCount: 100,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 9 / 16,
          ),
          itemBuilder: (context, index) => Card(child: Text('Project $index')),
        ),
      ));

      final stopwatch = Stopwatch()..start();
      await tester.drag(find.byType(GridView), const Offset(0, -800));
      await tester.pumpAndSettle();
      stopwatch.stop();

      expect(stopwatch.elapsedMilliseconds, lessThan(1000));
    },
    skip: true,
  );
}
