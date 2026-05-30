import 'package:flutter/animation.dart';

class AppDurations {
  AppDurations._();

  static const fast = Duration(milliseconds: 150);
  static const normal = Duration(milliseconds: 300);
  static const slow = Duration(milliseconds: 500);
  static const slower = Duration(milliseconds: 800);
}

class AppCurves {
  AppCurves._();

  static const standard = Curves.easeInOutCubic;
  static const enter = Curves.easeOutCubic;
  static const exit = Curves.easeInCubic;
  static const emphasized = Curves.easeOutBack;
}
