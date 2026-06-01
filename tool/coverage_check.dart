import 'dart:io';

void main(List<String> args) {
  var minCoverage = 70.0;
  var filePath = 'coverage/lcov.info';

  for (final arg in args) {
    if (arg.startsWith('--min=')) {
      minCoverage = double.parse(arg.substring('--min='.length));
    } else if (arg.startsWith('--file=')) {
      filePath = arg.substring('--file='.length);
    }
  }

  final file = File(filePath);
  if (!file.existsSync()) {
    stderr.writeln('Coverage file not found: $filePath');
    exitCode = 1;
    return;
  }

  var found = 0;
  var hit = 0;
  for (final line in file.readAsLinesSync()) {
    if (!line.startsWith('DA:')) continue;
    final parts = line.substring(3).split(',');
    if (parts.length != 2) continue;
    found++;
    if ((int.tryParse(parts[1]) ?? 0) > 0) hit++;
  }

  if (found == 0) {
    stderr.writeln('No line coverage records found in $filePath');
    exitCode = 1;
    return;
  }

  final coverage = hit * 100 / found;
  stdout
      .writeln('Line coverage: ${coverage.toStringAsFixed(2)}% ($hit/$found)');
  if (coverage < minCoverage) {
    stderr.writeln(
        'Coverage ${coverage.toStringAsFixed(2)}% is below ${minCoverage.toStringAsFixed(2)}%');
    exitCode = 1;
  }
}
