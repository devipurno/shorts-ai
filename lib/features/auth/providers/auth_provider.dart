import 'package:flutter_riverpod/legacy.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../models/user.dart';

part 'auth_provider.g.dart';

@Riverpod(keepAlive: true)
Duration authMockDelay(Ref ref) => const Duration(seconds: 1);

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  return AuthNotifier(mockDelay: ref.watch(authMockDelayProvider));
});

sealed class AuthState {
  const AuthState();
}

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
  AuthNotifier({Duration mockDelay = const Duration(seconds: 1)})
      : _mockDelay = mockDelay,
        super(const Unauthenticated());

  final Duration _mockDelay;

  Future<void> login(String email, String password) async {
    state = const Authenticating();
    await Future<void>.delayed(_mockDelay);

    if (_shouldFail(email, password)) {
      state = const AuthError('Invalid mock credentials.');
      return;
    }

    state = Authenticated(
      User(
        id: _mockUserId(email),
        email: email,
        name: email.split('@').first,
        tier: SubscriptionTier.free,
        createdAt: DateTime.now(),
      ),
    );
  }

  Future<void> signup(String email, String password, String name) async {
    state = const Authenticating();
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

  Future<void> logout() async {
    await Future<void>.delayed(_mockDelay);
    state = const Unauthenticated();
  }

  Future<void> refreshSession() async {
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
}
