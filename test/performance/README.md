# AutoShort Performance Benchmarks

These widget-level benchmarks cover the heaviest Phase 1-4 surfaces: library grids, editor timeline, subtitle rendering, template grid, and content calendar. They are tagged `perf` so CI can exclude them by default and run them explicitly with:

```powershell
flutter test test/performance --tags perf
```

Baseline targets from Task 26:
- Library grid scroll: target 60 FPS, max frame budget <16ms in device profiling.
- Mini editor timeline: initial render <100ms in widget benchmark.
- Subtitle rendering: 500 word timings <200ms.
- Template grid scroll: no jank regressions in widget scroll pump.
- Calendar month: render scheduled month <200ms.