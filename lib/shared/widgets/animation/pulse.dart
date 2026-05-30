import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class Pulse extends StatelessWidget {
  const Pulse({
    super.key,
    required this.child,
    this.enabled = true,
  });

  final Widget child;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    if (!enabled) {
      return child;
    }

    return child
        .animate(onPlay: (controller) => controller.repeat(reverse: true))
        .scale(
          begin: const Offset(1, 1),
          end: const Offset(1.04, 1.04),
          duration: const Duration(milliseconds: 850),
          curve: Curves.easeInOut,
        );
  }
}
