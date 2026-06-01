param(
  [double]$MinCoverage = 70
)

$ErrorActionPreference = "Stop"
flutter test --coverage

$lcov = "coverage/lcov.info"
if (!(Test-Path $lcov)) {
  throw "coverage/lcov.info was not generated."
}

$filtered = "coverage/lcov.filtered.info"
$skip = $false
$totalFound = 0
$totalHit = 0
$out = New-Object System.Collections.Generic.List[string]
foreach ($line in Get-Content $lcov) {
  if ($line.StartsWith("SF:")) {
    $skip = $line -match "(\.g\.dart|\.freezed\.dart|\.gr\.dart)"
  }
  if (!$skip) {
    $out.Add($line)
    if ($line.StartsWith("DA:")) {
      $parts = $line.Substring(3).Split(',')
      if ($parts.Count -eq 2) {
        $totalFound++
        if ([int]$parts[1] -gt 0) { $totalHit++ }
      }
    }
  }
  if ($line -eq "end_of_record") {
    $skip = $false
  }
}
$out | Set-Content $filtered

$coverage = if ($totalFound -eq 0) { 0 } else { ($totalHit / $totalFound) * 100 }
Write-Host ("Line coverage: {0:N2}% ({1}/{2})" -f $coverage, $totalHit, $totalFound)
if ($coverage -lt $MinCoverage) {
  throw "Coverage gate failed: $coverage < $MinCoverage"
}

if (Get-Command genhtml -ErrorAction SilentlyContinue) {
  genhtml $filtered --output-directory coverage/html | Out-Null
  Write-Host "HTML coverage: coverage/html/index.html"
}