import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/extensions/snackbar_ext.dart';
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
import '../widgets/password_strength_indicator.dart';

class SignupScreen extends ConsumerStatefulWidget {
  const SignupScreen({super.key});

  @override
  ConsumerState<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends ConsumerState<SignupScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  String? _nameError;
  String? _emailError;
  String? _passwordError;
  String? _confirmPasswordError;
  bool _acceptedTerms = false;
  bool _hasInteracted = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  bool get _isFormReady {
    return _acceptedTerms &&
        _nameController.text.trim().isNotEmpty &&
        _emailController.text.trim().isEmail &&
        _passwordController.text.length >= 6 &&
        _confirmPasswordController.text == _passwordController.text;
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<AuthState>(authProvider, (previous, next) {
      if (next is AuthError) {
        context.showErrorSnackBar(next.message);
      }
      if (next is AuthSignupSuccess) {
        _showSignupSuccess(next.email);
      }
    });

    final authState = ref.watch(authProvider);
    final isLoading = authState is Authenticating;

    return Scaffold(
      key: const Key('signup-screen'),
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
                'Daftar Gratis',
                style: AppTypography.displaySmall.copyWith(
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: AppSpacing.sm),
              Text(
                '14 hari trial Premium, no credit card',
                style: AppTypography.bodyMedium.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: AppSpacing.xxl),
              AppTextInput(
                key: const Key('signup-name'),
                controller: _nameController,
                label: 'Nama',
                hint: 'Nama kreator',
                errorText: _nameError,
                textInputAction: TextInputAction.next,
                prefixIcon: const Icon(Icons.person_outline),
                onChanged: (_) => _onFieldChanged(),
              ),
              const SizedBox(height: AppSpacing.lg),
              AppTextInput(
                key: const Key('signup-email'),
                controller: _emailController,
                label: 'Email',
                hint: 'nama@email.com',
                errorText: _emailError,
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                prefixIcon: const Icon(Icons.mail_outline),
                onChanged: (_) => _onFieldChanged(),
              ),
              const SizedBox(height: AppSpacing.lg),
              AppPasswordInput(
                key: const Key('signup-password'),
                controller: _passwordController,
                errorText: _passwordError,
                onChanged: (_) => _onFieldChanged(),
              ),
              const SizedBox(height: AppSpacing.sm),
              PasswordStrengthIndicator(password: _passwordController.text),
              const SizedBox(height: AppSpacing.lg),
              AppPasswordInput(
                key: const Key('signup-confirm-password'),
                controller: _confirmPasswordController,
                label: 'Konfirmasi Password',
                errorText: _confirmPasswordError,
                onChanged: (_) => _onFieldChanged(),
              ),
              const SizedBox(height: AppSpacing.lg),
              _TermsCheckbox(
                value: _acceptedTerms,
                onChanged: isLoading
                    ? null
                    : (value) {
                        setState(() {
                          _acceptedTerms = value ?? false;
                          _hasInteracted = true;
                          _validate(setOnly: true);
                        });
                      },
                onOpenTerms: _showTermsDialog,
              ),
              const SizedBox(height: AppSpacing.xl),
              AppButton(
                key: const Key('signup-submit'),
                label: 'Daftar Sekarang',
                fullWidth: true,
                isLoading: isLoading,
                onPressed: isLoading || !_isFormReady ? null : _submit,
              ),
              const SizedBox(height: AppSpacing.xxl),
              Center(
                child: Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    Text(
                      'Sudah punya akun? ',
                      style: AppTypography.bodyMedium.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                    TextButton(
                      key: const Key('signup-login-link'),
                      onPressed: isLoading
                          ? null
                          : () => context.go(AppRoutes.login),
                      child: const Text('Masuk'),
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
    _hasInteracted = true;
    if (!_validate()) {
      return;
    }

    await ref
        .read(authProvider.notifier)
        .signup(
          _emailController.text.trim(),
          _passwordController.text,
          _nameController.text.trim(),
        );
  }

  void _onFieldChanged() {
    setState(() {
      if (_hasInteracted) {
        _validate(setOnly: true);
      }
    });
  }

  bool _validate({bool setOnly = false}) {
    final name = _nameController.text.trim();
    final email = _emailController.text.trim();
    final password = _passwordController.text;
    final confirmPassword = _confirmPasswordController.text;

    void setErrors() {
      _nameError = name.isEmpty ? 'Nama wajib diisi.' : null;
      _emailError = email.isEmail ? null : 'Masukkan email yang valid.';
      _passwordError = password.length >= 6
          ? null
          : 'Password minimal 6 karakter.';
      _confirmPasswordError = confirmPassword == password
          ? null
          : 'Password tidak sama.';
    }

    if (setOnly) {
      setErrors();
    } else {
      setState(setErrors);
    }

    return name.isNotEmpty &&
        email.isEmail &&
        password.length >= 6 &&
        confirmPassword == password &&
        _acceptedTerms;
  }

  Future<void> _showSignupSuccess(String email) async {
    await showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        key: const Key('signup-success-dialog'),
        title: const Text('Akun berhasil dibuat'),
        content: Text('Cek email  untuk verifikasi akun.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
    if (mounted) {
      context.go(AppRoutes.login);
    }
  }

  void _showTermsDialog() {
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Syarat & Privasi'),
        content: const Text(
          'Dokumen legal akan dibuka lewat webview pada tahap integrasi. '
          'Untuk mock, centang persetujuan untuk melanjutkan.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Tutup'),
          ),
        ],
      ),
    );
  }
}

class _TermsCheckbox extends StatelessWidget {
  const _TermsCheckbox({
    required this.value,
    required this.onChanged,
    required this.onOpenTerms,
  });

  final bool value;
  final ValueChanged<bool?>? onChanged;
  final VoidCallback onOpenTerms;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Checkbox(
          key: const Key('signup-terms'),
          value: value,
          onChanged: onChanged,
          activeColor: AppColors.gold,
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: AppSpacing.sm),
            child: Wrap(
              children: [
                Text(
                  'Saya setuju dengan ',
                  style: AppTypography.bodySmall.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
                InkWell(
                  onTap: onOpenTerms,
                  child: Text(
                    'Syarat & Ketentuan',
                    style: AppTypography.labelSmall.copyWith(
                      color: AppColors.gold,
                    ),
                  ),
                ),
                Text(
                  ' dan ',
                  style: AppTypography.bodySmall.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
                InkWell(
                  onTap: onOpenTerms,
                  child: Text(
                    'Kebijakan Privasi',
                    style: AppTypography.labelSmall.copyWith(
                      color: AppColors.gold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
