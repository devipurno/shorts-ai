import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../routing/routes.dart';
import '../../../shared/widgets/buttons/app_button.dart';
import '../../../shared/widgets/inputs/otp_input.dart';
import '../providers/auth_provider.dart';

class OtpVerifyScreen extends ConsumerStatefulWidget {
  const OtpVerifyScreen({
    super.key,
    required this.email,
    this.flow = 'forgot-password',
    this.resendDuration = const Duration(seconds: 60),
  });

  final String email;
  final String flow;
  final Duration resendDuration;

  @override
  ConsumerState<OtpVerifyScreen> createState() => _OtpVerifyScreenState();
}

class _OtpVerifyScreenState extends ConsumerState<OtpVerifyScreen> {
  Timer? _timer;
  String _code = '';
  late int _secondsRemaining;
  bool _submittedFromAutoComplete = false;

  bool get _isForgotPasswordFlow => widget.flow != 'signup';

  @override
  void initState() {
    super.initState();
    _secondsRemaining = widget.resendDuration.inSeconds;
    _startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<AuthState>(authProvider, (previous, next) {
      if (next is AuthError) {
        _showError(next.message);
      }
    });

    final authState = ref.watch(authProvider);
    final isLoading = authState is Authenticating;

    return Scaffold(
      key: const Key('otp-verify-screen'),
      backgroundColor: AppColors.obsidian,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppSpacing.xl),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                key: const Key('otp-back'),
                onPressed: isLoading ? null : _goBack,
                icon: const Icon(Icons.arrow_back),
                color: AppColors.gold,
              ),
              const SizedBox(height: AppSpacing.xxl),
              Text(
                'Verifikasi OTP',
                style: AppTypography.displaySmall.copyWith(
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: AppSpacing.sm),
              Text(
                'Kode dikirim ke ${widget.email.isEmpty ? 'email kamu' : widget.email}',
                style: AppTypography.bodyMedium.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: AppSpacing.xxl),
              Center(
                child: AppOtpInput(
                  key: const Key('otp-input'),
                  autoFocus: true,
                  onChanged: (value) => setState(() => _code = value),
                  onCompleted: (value) {
                    _code = value;
                    _verify(autoSubmitted: true);
                  },
                ),
              ),
              const SizedBox(height: AppSpacing.xl),
              Center(
                  child: _ResendControl(
                secondsRemaining: _secondsRemaining,
                onResend: isLoading ? null : _resend,
              )),
              const SizedBox(height: AppSpacing.xl),
              AppButton(
                key: const Key('otp-submit'),
                label: 'Verifikasi',
                fullWidth: true,
                isLoading: isLoading,
                onPressed: isLoading || _code.length != 6 ? null : _verify,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _verify({bool autoSubmitted = false}) async {
    if (autoSubmitted && _submittedFromAutoComplete) {
      return;
    }
    if (autoSubmitted) {
      _submittedFromAutoComplete = true;
    }
    if (_code.length != 6) {
      return;
    }

    await ref.read(authProvider.notifier).verifyOtp(
          _code,
          email: widget.email,
          purpose: _isForgotPasswordFlow
              ? OtpPurpose.forgotPassword
              : OtpPurpose.signup,
        );
    if (!mounted || ref.read(authProvider) is AuthError) {
      return;
    }

    context.go(
      _isForgotPasswordFlow
          ? AppRoutes.resetPasswordPath(email: widget.email)
          : AppRoutes.home,
    );
  }

  Future<void> _resend() async {
    await ref.read(authProvider.notifier).sendOtp(widget.email);
    if (!mounted || ref.read(authProvider) is AuthError) {
      return;
    }
    setState(() {
      _secondsRemaining = widget.resendDuration.inSeconds;
      _submittedFromAutoComplete = false;
    });
    _startTimer();
  }

  void _startTimer() {
    _timer?.cancel();
    if (_secondsRemaining <= 0) {
      return;
    }
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) {
        timer.cancel();
        return;
      }
      if (_secondsRemaining <= 1) {
        timer.cancel();
      }
      setState(() {
        _secondsRemaining = (_secondsRemaining - 1).clamp(0, 60);
      });
    });
  }

  void _goBack() {
    if (context.canPop()) {
      context.pop();
      return;
    }
    context.go(AppRoutes.forgotPassword);
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

class _ResendControl extends StatelessWidget {
  const _ResendControl({
    required this.secondsRemaining,
    required this.onResend,
  });

  final int secondsRemaining;
  final VoidCallback? onResend;

  @override
  Widget build(BuildContext context) {
    if (secondsRemaining > 0) {
      return Text(
        'Kirim ulang dalam ${secondsRemaining}s',
        style: AppTypography.labelMedium.copyWith(
          color: AppColors.textTertiary,
        ),
      );
    }

    return TextButton(
      key: const Key('otp-resend'),
      onPressed: onResend,
      child: const Text('Kirim ulang kode'),
    );
  }
}
