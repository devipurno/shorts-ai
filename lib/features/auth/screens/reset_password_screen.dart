import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/extensions/snackbar_ext.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../routing/routes.dart';
import '../../../shared/widgets/buttons/app_button.dart';
import '../../../shared/widgets/inputs/password_input.dart';
import '../providers/auth_provider.dart';
import '../widgets/password_strength_indicator.dart';

class ResetPasswordScreen extends ConsumerStatefulWidget {
  const ResetPasswordScreen({super.key, required this.email});

  final String email;

  @override
  ConsumerState<ResetPasswordScreen> createState() =>
      _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends ConsumerState<ResetPasswordScreen> {
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  String? _passwordError;
  String? _confirmPasswordError;

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<AuthState>(authProvider, (previous, next) {
      if (next is AuthError) {
        context.showErrorSnackBar(next.message);
      }
    });

    final authState = ref.watch(authProvider);
    final isLoading = authState is Authenticating;

    return Scaffold(
      key: const Key('reset-password-screen'),
      backgroundColor: AppColors.obsidian,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppSpacing.xl),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                key: const Key('reset-back'),
                onPressed: isLoading ? null : () => context.go(AppRoutes.login),
                icon: const Icon(Icons.arrow_back),
                color: AppColors.gold,
              ),
              const SizedBox(height: AppSpacing.xxl),
              Text(
                'Reset Password',
                style: AppTypography.displaySmall.copyWith(
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: AppSpacing.sm),
              Text(
                widget.email.isEmpty
                    ? 'Buat password baru untuk akunmu'
                    : 'Buat password baru untuk ${widget.email}',
                style: AppTypography.bodyMedium.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: AppSpacing.xxl),
              AppPasswordInput(
                key: const Key('reset-password'),
                controller: _passwordController,
                label: 'Password Baru',
                errorText: _passwordError,
                onChanged: (_) => _clearErrors(),
              ),
              const SizedBox(height: AppSpacing.sm),
              PasswordStrengthIndicator(password: _passwordController.text),
              const SizedBox(height: AppSpacing.lg),
              AppPasswordInput(
                key: const Key('reset-confirm-password'),
                controller: _confirmPasswordController,
                label: 'Konfirmasi Password',
                errorText: _confirmPasswordError,
                onChanged: (_) => _clearErrors(),
              ),
              const SizedBox(height: AppSpacing.xl),
              AppButton(
                key: const Key('reset-submit'),
                label: 'Reset Password',
                fullWidth: true,
                isLoading: isLoading,
                onPressed: isLoading ? null : _submit,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _submit() async {
    if (!_validate()) {
      return;
    }

    await ref
        .read(authProvider.notifier)
        .resetPassword(_passwordController.text);
    if (!mounted || ref.read(authProvider) is AuthError) {
      return;
    }

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        const SnackBar(content: Text('Password berhasil direset.')),
      );
    context.go(AppRoutes.login);
  }

  bool _validate() {
    final password = _passwordController.text;
    final confirm = _confirmPasswordController.text;
    setState(() {
      _passwordError =
          password.length >= 8 ? null : 'Password minimal 8 karakter.';
      _confirmPasswordError =
          confirm == password ? null : 'Password tidak sama.';
    });

    return _passwordError == null && _confirmPasswordError == null;
  }

  void _clearErrors() {
    if (_passwordError != null || _confirmPasswordError != null) {
      setState(() {
        _passwordError = null;
        _confirmPasswordError = null;
      });
    } else {
      setState(() {});
    }
  }
}
