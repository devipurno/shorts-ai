import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:table_calendar/table_calendar.dart';

@Tags(['perf'])
void main() {
  testWidgets(
    'Calendar month with 30 scheduled posts renders quickly',
    (tester) async {
      final focused = DateTime(2026, 6, 1);
      final stopwatch = Stopwatch()..start();
      await tester.pumpWidget(MaterialApp(
        home: TableCalendar<int>(
          firstDay: DateTime(2026),
          lastDay: DateTime(2027),
          focusedDay: focused,
          eventLoader: (day) =>
              day.month == focused.month ? [day.day] : const [],
        ),
      ));
      await tester.pump();
      stopwatch.stop();

      expect(stopwatch.elapsedMilliseconds, lessThan(500));
    },
    skip: true,
  );
}
