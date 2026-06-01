import 'dart:async';

import 'package:flutter_riverpod/legacy.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/env/env.dart';
import '../../../core/errors/app_exception.dart';
import '../../../shared/models/user.dart' as data_user;
import '../../../shared/repositories/auth_repository.dart';
import '../../../shared/repositories/providers.dart';
import '../../../shared/services/supabase_service.dart';
import '../models/user.dart';

part 'auth_provider.g.dart';

@Riverpod(keepAlive: true)
Duration authMockDelay(Ref ref) => const Duration(seconds: 1);

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  final useRepository = Env.useSupabase && SupabaseService.isInitialized;
  return AuthNotifier(
    mockDelay: ref.watch(authMockDelayProvider),
    repository: useRepository ? ref.watch(authRepositoryProvider) : null,
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
  })  : _mockDelay = mockDelay,
        _repository = repository,
        super(const Unauthenticated()) {
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
      state = const AuthError('Invalid mock credentials.');
      return;
    }

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
      await _runRepositoryAction(
        () async => Authenticated(
          _fromDataUser(
            await repository.signup(
              email: email,
              password: password,
              name: name,
            ),
          ),
        ),
      );
      return;
    }

    await Future<void>.delayed(_mockDelay);

    if (_shouldFail(email, password) || name.trim().isEmpty) {
      state = const AuthError('Unable to create mock account.');
      return;
    }

    state = Authenticated(
      User(
        id: _mockUserId(email),
        email: email,
        name: name.trim(),
        tier: SubscriptionTier.free,
        createdAt: DateTime.now(),
      ),
    );
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
    } catch (error) {
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
    return error.toString();
  }

  @override
  void dispose() {
    _authSubscription?.cancel();
    super.dispose();
  }
}
