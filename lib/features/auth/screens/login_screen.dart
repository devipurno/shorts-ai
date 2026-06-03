import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/extensions/string_ext.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../routing/routes.dart';
import '../../../shared/widgets/brand/app_logo.dart';
import '../../../shared/widgets/buttons/app_button.dart';
import '../../../shared/widgets/inputs/password_input.dart';
import '../../../shared/widgets/inputs/text_input.dart';
import '../providers/auth_provider.dart';
import '../widgets/social_auth_button.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  String? _emailError;
  String? _passwordError;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<AuthState>(authProvider, (previous, next) {
      if (next is AuthError) {
        _showError(next.message);
      }
      if (next is Authenticated) {
        context.go(AppRoutes.home);
      }
    });

    final authState = ref.watch(authProvider);
    final isLoading = authState is Authenticating;

    return Scaffold(
      key: const Key('login-screen'),
      backgroundColor: AppColors.obsidian,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppSpacing.xl),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: AppSpacing.xl),
              const AppLogo(
                variant: AppLogoVariant.wordmark,
                size: AppLogoSize.sm,
              ),
              const SizedBox(height: AppSpacing.xxl),
              Text(
                'Masuk',
                style: AppTypography.displaySmall.copyWith(
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: AppSpacing.sm),
              Text(
                'Selamat datang kembali',
                style: AppTypography.bodyMedium.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: AppSpacing.xxl),
              AppTextInput(
                key: const Key('login-email'),
                controller: _emailController,
                label: 'Email',
                hint: 'nama@email.com',
                errorText: _emailError,
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                prefixIcon: const Icon(Icons.mail_outline),
                onChanged: (_) => _clearEmailError(),
              ),
              const SizedBox(height: AppSpacing.lg),
              AppPasswordInput(
                key: const Key('login-password'),
                controller: _passwordController,
                errorText: _passwordError,
                onChanged: (_) => _clearPasswordError(),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  key: const Key('login-forgot-link'),
                  onPressed: isLoading
                      ? null
                      : () => context.go(AppRoutes.forgotPassword),
                  child: Text(
                    'Lupa password?',
                    style: AppTypography.labelMedium.copyWith(
                      color: AppColors.gold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.md),
              AppButton(
                key: const Key('login-submit'),
                label: 'Masuk',
                fullWidth: true,
                isLoading: isLoading,
                onPressed: isLoading ? null : _submit,
              ),
              const SizedBox(height: AppSpacing.xl),
              const _OrDivider(),
              const SizedBox(height: AppSpacing.xl),
              SocialAuthButton(
                label: 'Lanjut dengan Google',
                icon: const Icon(Icons.g_mobiledata),
                onPressed: isLoading ? null : _mockGoogle,
              ),
              const SizedBox(height: AppSpacing.xxl),
              Center(
                child: Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    Text(
                      'Belum punya akun? ',
                      style: AppTypography.bodyMedium.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                    TextButton(
                      key: const Key('login-signup-link'),
                      onPressed:
                          isLoading ? null : () => context.go(AppRoutes.signup),
                      child: const Text('Daftar'),
                    ),
                  ],
                ),
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

    await ref.read(authProvider.notifier).login(
          _emailController.text.trim(),
          _passwordController.text,
        );
  }

  bool _validate() {
    final email = _emailController.text.trim();
    final password = _passwordController.text;
    setState(() {
      _emailError = email.isEmail ? null : 'Masukkan email yang valid.';
      _passwordError =
          password.length >= 8 ? null : 'Password minimal 8 karakter.';
    });

    return _emailError == null && _passwordError == null;
  }

  void _clearEmailError() {
    if (_emailError != null) {
      setState(() => _emailError = null);
    }
  }

  void _clearPasswordError() {
    if (_passwordError != null) {
      setState(() => _passwordError = null);
    }
  }

  void _mockGoogle() {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        const SnackBar(content: Text('Google sign-in masih mock.')),
      );
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          key: const Key('auth-error-snackbar'),
          content: Text(message),
          backgroundColor: AppColors.error,
        ),
      );
  }
}

class _OrDivider extends StatelessWidget {
  const _OrDivider();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(child: Divider()),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
          child: Text(
            'atau',
            style: AppTypography.labelMedium.copyWith(
              color: AppColors.textTertiary,
            ),
          ),
        ),
        const Expanded(child: Divider()),
      ],
    );
  }
}
