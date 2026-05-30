import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppShadows {
  AppShadows._();

  static const shadowSm = [
    BoxShadow(
      color: Color(0x33000000),
      blurRadius: 8,
      offset: Offset(0, 2),
    ),
  ];

  static const shadowMd = [
    BoxShadow(
      color: Color(0x52000000),
      blurRadius: 18,
      offset: Offset(0, 8),
    ),
  ];

  static const shadowLg = [
    BoxShadow(
      color: Color(0x70000000),
      blurRadius: 32,
      offset: Offset(0, 18),
    ),
  ];

  static const shadowGoldGlow = [
    BoxShadow(
      color: AppColors.goldGlow,
      blurRadius: 24,
      spreadRadius: 1,
      offset: Offset(0, 8),
    ),
  ];
}
