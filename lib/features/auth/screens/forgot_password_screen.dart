import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/extensions/snackbar_ext.dart';
import '../../../core/extensions/string_ext.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../routing/routes.dart';
import '../../../shared/widgets/buttons/app_button.dart';
import '../../../shared/widgets/inputs/text_input.dart';
import '../providers/auth_provider.dart';

class ForgotPasswordScreen extends ConsumerStatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  ConsumerState<ForgotPasswordScreen> createState() =>
      _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends ConsumerState<ForgotPasswordScreen> {
  final _emailController = TextEditingController();
  String? _emailError;

  @override
  void dispose() {
    _emailController.dispose();
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
      key: const Key('forgot-password-screen'),
      backgroundColor: AppColors.obsidian,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppSpacing.xl),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                key: const Key('forgot-back'),
                onPressed: isLoading ? null : _goBack,
                icon: const Icon(Icons.arrow_back),
                color: AppColors.gold,
              ),
              const SizedBox(height: AppSpacing.xxl),
              Text(
                'Lupa Password?',
                style: AppTypography.displaySmall.copyWith(
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: AppSpacing.sm),
              Text(
                'Masukkan email lo, kami kirim link reset.',
                style: AppTypography.bodyMedium.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: AppSpacing.xxl),
              AppTextInput(
                key: const Key('forgot-email'),
                controller: _emailController,
                label: 'Email',
                hint: 'nama@email.com',
                errorText: _emailError,
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.done,
                prefixIcon: const Icon(Icons.mail_outline),
                onChanged: (_) {
                  if (_emailError != null) {
                    setState(() => _emailError = null);
                  }
                },
              ),
              const SizedBox(height: AppSpacing.xl),
              AppButton(
                key: const Key('forgot-submit'),
                label: 'Kirim link reset',
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
    final email = _emailController.text.trim();
    if (!email.isEmail) {
      setState(() => _emailError = 'Masukkan email yang valid.');
      return;
    }

    await ref.read(authProvider.notifier).sendPasswordResetEmail(email);
    if (!mounted || ref.read(authProvider) is AuthError) {
      return;
    }

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        const SnackBar(
          key: Key('forgot-success-snackbar'),
          content: Text('Link reset terkirim. Cek inbox + spam folder.'),
        ),
      );
  }

  void _goBack() {
    if (context.canPop()) {
      context.pop();
      return;
    }
    context.go(AppRoutes.login);
  }

}
