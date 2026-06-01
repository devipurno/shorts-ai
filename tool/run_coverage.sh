#!/usr/bin/env bash
set -euo pipefail
MIN_COVERAGE="${MIN_COVERAGE:-70}"
flutter test --coverage
LCOV="coverage/lcov.info"
FILTERED="coverage/lcov.filtered.info"
awk '
  /^SF:/ { skip = ($0 ~ /(\.g\.dart|\.freezed\.dart|\.gr\.dart)/) }
  !skip { print }
  /^end_of_record/ { skip = 0 }
' "$LCOV" > "$FILTERED"
python - <<'PY'
import os
min_cov = float(os.environ.get('MIN_COVERAGE', '70'))
found = hit = 0
with open('coverage/lcov.filtered.info', encoding='utf-8') as fh:
    for line in fh:
        if line.startswith('DA:'):
            _, value = line[3:].split(',', 1)
            found += 1
            hit += int(value) > 0
coverage = 0 if found == 0 else hit / found * 100
print(f'Line coverage: {coverage:.2f}% ({hit}/{found})')
if coverage < min_cov:
    raise SystemExit(f'Coverage gate failed: {coverage:.2f} < {min_cov:.2f}')
PY
if command -v genhtml >/dev/null 2>&1; then
  genhtml "$FILTERED" --output-directory coverage/html >/dev/null
  echo "HTML coverage: coverage/html/index.html"
fi