import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

/// Convenience extensions for showing snack bars.
extension SnackBarExt on BuildContext {
  /// Shows an error snack bar styled with [AppColors.error].
  void showErrorSnackBar(String message, {Key? key}) {
    ScaffoldMessenger.of(this)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          key: key ?? const Key('auth-error-snackbar'),
          content: Text(message),
          backgroundColor: AppColors.error,
        ),
      );
  }
}
