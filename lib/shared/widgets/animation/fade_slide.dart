import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../core/theme/app_animations.dart';

class FadeSlide extends StatelessWidget {
  const FadeSlide({
    super.key,
    required this.child,
    this.delay = Duration.zero,
    this.duration = AppDurations.normal,
    this.begin = 0.12,
  });

  final Widget child;
  final Duration delay;
  final Duration duration;
  final double begin;

  @override
  Widget build(BuildContext context) {
    return child
        .animate(delay: delay)
        .fadeIn(duration: duration, curve: AppCurves.enter)
        .slideY(
            begin: begin, end: 0, duration: duration, curve: AppCurves.enter);
  }
}
