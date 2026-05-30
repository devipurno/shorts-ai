import 'package:flutter/material.dart';

import '../../../shared/widgets/buttons/app_button.dart';

class SocialAuthButton extends StatelessWidget {
  const SocialAuthButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
    this.isLoading = false,
  });

  final String label;
  final VoidCallback? onPressed;
  final Widget? icon;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return AppButton(
      key: const Key('social-auth-button'),
      label: label,
      variant: AppButtonVariant.secondary,
      fullWidth: true,
      icon: icon,
      isLoading: isLoading,
      onPressed: onPressed,
    );
  }
}
