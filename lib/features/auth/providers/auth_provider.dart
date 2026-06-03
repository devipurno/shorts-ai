import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/env/env.dart';
import '../../../core/error_reporter.dart';
import '../../../core/utils/logger.dart';
import '../../../core/errors/app_exception.dart';
import '../../../shared/models/user.dart' as data_user;
import '../../../shared/repositories/auth_repository.dart';
import '../../../shared/repositories/providers.dart';
import '../../../shared/services/auth_service.dart';
import '../../../shared/services/supabase_service.dart';
import '../models/user.dart';

part 'auth_provider.g.dart';

@Riverpod(keepAlive: true)
Duration authMockDelay(Ref ref) => const Duration(seconds: 1);

final authServiceProvider = Provider<AuthService>((ref) => AuthService());

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  final useRepository =
      !Env.useMockAuth && Env.useSupabase && SupabaseService.isInitialized;
  return AuthNotifier(
    mockDelay: ref.watch(authMockDelayProvider),
    repository: useRepository ? ref.watch(authRepositoryProvider) : null,
    errorReporter: ref.watch(errorReporterProvider),
  );
});

sealed class AuthState {
  const AuthState();
}

enum OtpPurpose { signup, forgotPassword }

final class Unauthenticated extends AuthState {
  const Unauthenticated();

  @override
  bool operator ==(Object other) => other is Unauthenticated;

  @override
  int get hashCode => Object.hash(runtimeType, 'unauthenticated');
}

final class Authenticating extends AuthState {
  const Authenticating();

  @override
  bool operator ==(Object other) => other is Authenticating;

  @override
  int get hashCode => Object.hash(runtimeType, 'authenticating');
}

final class Authenticated extends AuthState {
  const Authenticated(this.user);

  final User user;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is Authenticated && other.user == user;
  }

  @override
  int get hashCode => user.hashCode;
}

final class AuthSignupSuccess extends AuthState {
  const AuthSignupSuccess(this.email);

  final String email;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is AuthSignupSuccess && other.email == email;
  }

  @override
  int get hashCode => email.hashCode;
}

final class AuthError extends AuthState {
  const AuthError(this.message);

  final String message;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is AuthError && other.message == message;
  }

  @override
  int get hashCode => message.hashCode;
}

class AuthNotifier extends StateNotifier<AuthState> {
  AuthNotifier({
    Duration mockDelay = const Duration(seconds: 1),
    AuthRepository? repository,
    ErrorReporter? errorReporter,
  })  : _mockDelay = mockDelay,
        _repository = repository,
        _errorReporter = errorReporter ?? const NoOpErrorReporter(),
        super(const Unauthenticated()) {
    _hydrateInitialUser();
    _authSubscription = _repository?.watchAuthState().listen(
      (user) {
        state = user == null
            ? const Unauthenticated()
            : Authenticated(_fromDataUser(user));
      },
      onError: (Object error) {
        state = AuthError(_errorMessage(error));
      },
    );
  }

  final Duration _mockDelay;
  final AuthRepository? _repository;
  final ErrorReporter _errorReporter;
  StreamSubscription<data_user.User?>? _authSubscription;

  Future<void> login(String email, String password) async {
    state = const Authenticating();
    final repository = _repository;
    if (repository != null) {
      await _runRepositoryAction(
        () async => Authenticated(
          _fromDataUser(
            await repository.login(email: email, password: password),
          ),
        ),
      );
      return;
    }

    await Future<void>.delayed(_mockDelay);

    if (_shouldFail(email, password)) {
      _errorReporter.addBreadcrumb(
          message: 'Sign-in attempt: failure', category: 'auth');
      state = const AuthError('Invalid mock credentials.');
      return;
    }

    _errorReporter.addBreadcrumb(
        message: 'Sign-in attempt: success', category: 'auth');
    state = Authenticated(
      User(
        id: _mockUserId(email),
        email: email,
        name: 'Devi',
        tier: SubscriptionTier.free,
        createdAt: DateTime.now(),
      ),
    );
  }

  Future<void> signup(String email, String password, String name) async {
    state = const Authenticating();
    final repository = _repository;
    if (repository != null) {
      await _runRepositoryAction(() async {
        await repository.signup(
          email: email,
          password: password,
          name: name,
        );
        return AuthSignupSuccess(email.trim().toLowerCase());
      });
      return;
    }

    await Future<void>.delayed(_mockDelay);

    if (_shouldFail(email, password) || name.trim().isEmpty) {
      _errorReporter.addBreadcrumb(
          message: 'Sign-up attempt: failure', category: 'auth');
      state = const AuthError('Unable to create mock account.');
      return;
    }

    _errorReporter.addBreadcrumb(
        message: 'Sign-up attempt: success', category: 'auth');
    state = AuthSignupSuccess(email.trim().toLowerCase());
  }

  Future<void> sendPasswordResetEmail(String email) async {
    state = const Authenticating();
    final repository = _repository;
    if (repository != null) {
      await _runRepositoryAction(() async {
        await repository.sendPasswordResetEmail(email);
        return const Unauthenticated();
      });
      return;
    }

    await Future<void>.delayed(_mockDelay);

    if (email.trim().isEmpty || email.toLowerCase().contains('fail')) {
      state = const AuthError('Unable to send password reset email.');
      return;
    }

    state = const Unauthenticated();
  }

  Future<void> sendOtp(String email) async {
    state = const Authenticating();
    final repository = _repository;
    if (repository != null) {
      await _runRepositoryAction(() async {
        await repository.sendOtp(email);
        return const Unauthenticated();
      });
      return;
    }

    await Future<void>.delayed(_mockDelay);

    if (email.trim().isEmpty || email.toLowerCase().contains('fail')) {
      state = const AuthError('Unable to send OTP code.');
      return;
    }

    state = const Unauthenticated();
  }

  Future<void> verifyOtp(
    String code, {
    String? email,
    OtpPurpose purpose = OtpPurpose.forgotPassword,
  }) async {
    state = const Authenticating();
    final repository = _repository;
    if (repository != null) {
      await _runRepositoryAction(() async {
        final user = await repository.verifyOtp(
          email: email ?? '',
          token: code,
          recovery: purpose == OtpPurpose.forgotPassword,
        );
        return user == null
            ? const Unauthenticated()
            : Authenticated(_fromDataUser(user));
      });
      return;
    }

    await Future<void>.delayed(_mockDelay);

    if (code.length != 6 || code == '000000') {
      state = const AuthError('Invalid OTP code.');
      return;
    }

    if (purpose == OtpPurpose.signup) {
      final normalizedEmail =
          email?.trim().isNotEmpty == true ? email!.trim() : 'otp@autoshort.id';
      state = Authenticated(
        User(
          id: _mockUserId(normalizedEmail),
          email: normalizedEmail,
          name: 'Devi',
          tier: SubscriptionTier.free,
          createdAt: DateTime.now(),
        ),
      );
      return;
    }

    state = const Unauthenticated();
  }

  Future<void> resetPassword(String password) async {
    state = const Authenticating();
    final repository = _repository;
    if (repository != null) {
      await _runRepositoryAction(() async {
        await repository.resetPassword(password);
        return const Unauthenticated();
      });
      return;
    }

    await Future<void>.delayed(_mockDelay);

    if (password.length < 8 || password == 'fail-password') {
      state = const AuthError('Unable to reset password.');
      return;
    }

    state = const Unauthenticated();
  }

  Future<void> logout() async {
    final repository = _repository;
    if (repository != null) {
      await _runRepositoryAction(() async {
        await repository.logout();
        return const Unauthenticated();
      });
      return;
    }

    await Future<void>.delayed(_mockDelay);
    _errorReporter.addBreadcrumb(
        message: 'Sign-out: success', category: 'auth');
    state = const Unauthenticated();
  }

  Future<void> refreshSession() async {
    final repository = _repository;
    if (repository != null) {
      await _runRepositoryAction(() async {
        final user = await repository.refresh();
        return user == null
            ? const Unauthenticated()
            : Authenticated(_fromDataUser(user));
      });
      return;
    }

    final currentState = state;
    await Future<void>.delayed(_mockDelay);
    state =
        currentState is Authenticated ? currentState : const Unauthenticated();
  }

  Future<void> _hydrateInitialUser() async {
    final repository = _repository;
    if (repository == null) {
      return;
    }
    try {
      final user = await repository.currentUser();
      if (user != null) {
        state = Authenticated(_fromDataUser(user));
      }
    } catch (error, stackTrace) {
      AppLogger.w(
        'Startup user hydration failed, staying unauthenticated',
        tag: 'Auth',
        error: error,
        stackTrace: stackTrace,
      );
    }
  }

  bool _shouldFail(String email, String password) {
    return email.toLowerCase().contains('fail') || password == 'fail';
  }

  String _mockUserId(String email) {
    return 'mock-${email.trim().toLowerCase().hashCode.abs()}';
  }

  Future<void> _runRepositoryAction(
    Future<AuthState> Function() action,
  ) async {
    try {
      state = await action();
    } catch (error, stackTrace) {
      _errorReporter.captureException(
        error,
        stackTrace: stackTrace,
        extra: {'auth_state': state.runtimeType.toString()},
        hint: 'auth_repository_action',
      );
      state = AuthError(_errorMessage(error));
    }
  }

  static User _fromDataUser(data_user.User user) {
    return User(
      id: user.id,
      email: user.email,
      name: user.name.isEmpty ? null : user.name,
      avatarUrl: user.avatarUrl,
      tier: SubscriptionTier.values.firstWhere(
        (tier) => tier.name == user.tier.name,
        orElse: () => SubscriptionTier.free,
      ),
      createdAt: user.createdAt,
    );
  }

  static String _errorMessage(Object error) {
    if (error is AppException) {
      return error.message;
    }
    return friendlyAuthMessage(error.toString());
  }

  @override
  void dispose() {
    _authSubscription?.cancel();
    super.dispose();
  }
}

String friendlyAuthMessage(String rawMessage) {
  final message = rawMessage.toLowerCase();
  if (message.contains('invalid_credentials') ||
      message.contains('invalid login credentials')) {
    return 'Email atau password salah';
  }
  if (message.contains('email_not_confirmed') ||
      message.contains('email not confirmed')) {
    return 'Cek email lo untuk verifikasi akun';
  }
  if (message.contains('too_many_requests') || message.contains('rate limit')) {
    return 'Terlalu banyak percobaan, coba lagi nanti';
  }
  if (message.contains('user_already_exists') ||
      message.contains('already registered')) {
    return 'Email sudah terdaftar. Coba masuk.';
  }
  if (message.contains('weak_password') || message.contains('weak password')) {
    return 'Password terlalu lemah. Min 6 chars + mix.';
  }
  return rawMessage;
}
