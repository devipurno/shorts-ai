import 'package:flutter_test/flutter_test.dart';
import 'package:shorts_ai/features/home/widgets/greeting_header.dart';

void main() {
  group('getGreeting', () {
    final cases = <({DateTime time, String expected})>[
      (time: DateTime(2026, 6, 2, 4, 59), expected: 'Selamat malam'),
      (time: DateTime(2026, 6, 2, 5), expected: 'Selamat pagi'),
      (time: DateTime(2026, 6, 2, 10, 59), expected: 'Selamat pagi'),
      (time: DateTime(2026, 6, 2, 11), expected: 'Selamat siang'),
      (time: DateTime(2026, 6, 2, 14, 59), expected: 'Selamat siang'),
      (time: DateTime(2026, 6, 2, 15), expected: 'Selamat sore'),
      (time: DateTime(2026, 6, 2, 18, 59), expected: 'Selamat sore'),
      (time: DateTime(2026, 6, 2, 19), expected: 'Selamat malam'),
      (time: DateTime(2026, 6, 2, 23, 59), expected: 'Selamat malam'),
      (time: DateTime(2026, 6, 2), expected: 'Selamat malam'),
    ];

    for (final entry in cases) {
      test(
          '${entry.time.hour.toString().padLeft(2, '0')}:${entry.time.minute.toString().padLeft(2, '0')} -> ${entry.expected}',
          () {
        expect(getGreeting(entry.time), entry.expected);
      });
    }
  });
}
