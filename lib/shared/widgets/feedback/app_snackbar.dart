import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';

enum AppSnackbarType { success, error, info }

class AppSnackbar {
  AppSnackbar._();

  static ScaffoldFeatureController<SnackBar, SnackBarClosedReason> show(
    BuildContext context, {
    required String message,
    AppSnackbarType type = AppSnackbarType.info,
  }) {
    final data = _SnackbarData.fromType(type);
    final messenger = ScaffoldMessenger.of(context)..hideCurrentSnackBar();

    return messenger.showSnackBar(
      SnackBar(
        backgroundColor: data.color,
        content: Row(
          children: [
            Icon(data.icon, color: AppColors.textPrimary),
            const SizedBox(width: 12),
            Expanded(child: Text(message)),
          ],
        ),
      ),
    );
  }

  static ScaffoldFeatureController<SnackBar, SnackBarClosedReason> success(
    BuildContext context,
    String message,
  ) =>
      show(context, message: message, type: AppSnackbarType.success);

  static ScaffoldFeatureController<SnackBar, SnackBarClosedReason> error(
    BuildContext context,
    String message,
  ) =>
      show(context, message: message, type: AppSnackbarType.error);

  static ScaffoldFeatureController<SnackBar, SnackBarClosedReason> info(
    BuildContext context,
    String message,
  ) =>
      show(context, message: message, type: AppSnackbarType.info);
}

class _SnackbarData {
  const _SnackbarData({required this.color, required this.icon});

  final Color color;
  final IconData icon;

  static _SnackbarData fromType(AppSnackbarType type) {
    return switch (type) {
      AppSnackbarType.success => const _SnackbarData(
          color: AppColors.success,
          icon: Icons.check_circle_outline,
        ),
      AppSnackbarType.error => const _SnackbarData(
          color: AppColors.error,
          icon: Icons.error_outline,
        ),
      AppSnackbarType.info => const _SnackbarData(
          color: AppColors.surface2,
          icon: Icons.info_outline,
        ),
    };
  }
}
