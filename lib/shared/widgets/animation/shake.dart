import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class Shake extends StatelessWidget {
  const Shake({
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
    return child.animate().shakeX(
          duration: const Duration(milliseconds: 420),
          hz: 5,
          amount: 8,
        );
  }
}
