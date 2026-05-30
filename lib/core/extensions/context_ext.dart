import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart' as go_router;

extension AutoShortBuildContextX on BuildContext {
  ThemeData get theme => Theme.of(this);
  ColorScheme get colors => theme.colorScheme;
  TextTheme get textTheme => theme.textTheme;

  double get screenWidth => MediaQuery.sizeOf(this).width;
  double get screenHeight => MediaQuery.sizeOf(this).height;

  void showSnackbar(String message) {
    ScaffoldMessenger.of(this)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message)));
  }

  void showError(String message) {
    ScaffoldMessenger.of(this)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: colors.error,
        ),
      );
  }

  void pop<T extends Object?>([T? result]) {
    go_router.GoRouter.of(this).pop<T>(result);
  }

  Future<T?> push<T extends Object?>(String location, {Object? extra}) {
    return go_router.GoRouter.of(this).push<T>(location, extra: extra);
  }
}
