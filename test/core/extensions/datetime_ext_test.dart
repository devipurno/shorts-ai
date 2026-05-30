import 'package:flutter_test/flutter_test.dart';
import 'package:shorts_ai/core/extensions/datetime_ext.dart';

void main() {
  test('formats DateTime in Asia/Bangkok offset', () {
    final value = DateTime.utc(2026, 5, 30, 10, 15);

    expect(value.formatLocal, '2026-05-30 17:15 WIB');
  });

  test('reports relative time in Indonesian', () {
    final fiveMinutesAgo = DateTime.now().subtract(const Duration(minutes: 5));

    expect(fiveMinutesAgo.timeAgo, contains('menit lalu'));
  });

  test('detects today, yesterday, and this week', () {
    final now = DateTime.now();

    expect(now.isToday, isTrue);
    expect(now.subtract(const Duration(days: 1)).isYesterday, isTrue);
    expect(now.isThisWeek, isTrue);
  });
}
