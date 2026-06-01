import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

void main() {
  test('coverage gate is at least 70 percent when lcov exists', () {
    final file = File('coverage/lcov.info');
    if (!file.existsSync()) {
      return;
    }

    var found = 0;
    var hit = 0;
    for (final line in file.readAsLinesSync()) {
      if (!line.startsWith('DA:')) {
        continue;
      }
      final parts = line.substring(3).split(',');
      if (parts.length != 2) {
        continue;
      }
      found += 1;
      if ((int.tryParse(parts[1]) ?? 0) > 0) {
        hit += 1;
      }
    }

    final coverage = found == 0 ? 0 : (hit / found) * 100;
    expect(
      coverage,
      greaterThanOrEqualTo(70),
      reason: 'Line coverage ${coverage.toStringAsFixed(2)}% is below 70%.',
    );
  });
}
