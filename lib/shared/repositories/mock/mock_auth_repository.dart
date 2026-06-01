import 'dart:async';

import 'package:faker/faker.dart';

import '../../../core/errors/app_exception.dart';
import '../../models/user.dart';
import '../auth_repository.dart';
import 'mock_repository_utils.dart';

/// Public API surface for `MockAuthRepository`.
class MockAuthRepository implements AuthRepository {
  MockAuthRepository({
    MockRepositoryConfig config = const MockRepositoryConfig(),
  })  : _runtime = MockRepositoryRuntime(config),
        _faker = Faker();

  final MockRepositoryRuntime _runtime;
  final Faker _faker;
  final _controller = StreamController<User?>.broadcast();

  User? _currentUser;

  @override
  Future<User?> currentUser() async {
    await _runtime.simulateNetwork();
    return _currentUser;
  }

  @override
  Future<User> login({
    required String email,
    required String password,
  }) async {
    await _runtime.simulateNetwork();
    if (_shouldFail(email, password)) {
      throw const AuthException(
        'Invalid mock credentials.',
        code: 'mock_invalid_credentials',
      );
    }

    _currentUser = _buildUser(email: email, name: 'Devi');
    _controller.add(_currentUser);
    return _currentUser!;
  }

  @override
  Future<User> signup({
    required String email,
    required String password,
    required String name,
  }) async {
    await _runtime.simulateNetwork();
    if (_shouldFail(email, password) || name.trim().isEmpty) {
      throw const AuthException(
        'Unable to create mock account.',
        code: 'mock_signup_failed',
      );
    }

    _currentUser = _buildUser(email: email, name: name.trim());
    _controller.add(_currentUser);
    return _currentUser!;
  }

  @override
  Future<void> logout() async {
    await _runtime.simulateNetwork();
    _currentUser = null;
    _controller.add(null);
  }

  @override
  Future<void> sendOtp(String email) async {
    await _runtime.simulateNetwork();
    if (email.trim().isEmpty || email.toLowerCase().contains('fail')) {
      throw const AuthException(
        'Unable to send mock OTP.',
        code: 'mock_otp_failed',
      );
    }
  }

  @override
  Future<User?> verifyOtp({
    required String email,
    required String token,
    bool recovery = false,
  }) async {
    await _runtime.simulateNetwork();
    if (token.length != 6 || token == '000000') {
      throw const AuthException(
        'Invalid mock OTP.',
        code: 'mock_invalid_otp',
      );
    }
    if (recovery) {
      return null;
    }
    _currentUser = _buildUser(email: email, name: 'Devi');
    _controller.add(_currentUser);
    return _currentUser;
  }

  @override
  Future<User> resetPassword(String newPassword) async {
    await _runtime.simulateNetwork();
    if (newPassword.length < 8) {
      throw const AuthException(
        'Unable to reset mock password.',
        code: 'mock_reset_failed',
      );
    }
    final user = _currentUser ??
        _buildUser(email: 'reset@autoshort.id', name: 'Reset User');
    _currentUser = user;
    _controller.add(_currentUser);
    return user;
  }

  @override
  Future<User?> refresh() async {
    await _runtime.simulateNetwork();
    _controller.add(_currentUser);
    return _currentUser;
  }

  @override
  Stream<User?> watchAuthState() async* {
    yield _currentUser;
    yield* _controller.stream;
  }

  User _buildUser({
    required String email,
    required String name,
  }) {
    final now = DateTime.now().toUtc();
    return User(
      id: _faker.guid.guid(),
      email: email.trim().toLowerCase(),
      name: name,
      avatarUrl: 'https://i.pravatar.cc/256?u=${Uri.encodeComponent(email)}',
      locale: 'id_ID',
      timezone: 'Asia/Bangkok',
      tier: SubscriptionTier.free,
      referralCode: 'AS${_runtime.nextInt(9000) + 1000}',
      createdAt: now,
      updatedAt: now,
      lastLoginAt: now,
    );
  }

  bool _shouldFail(String email, String password) {
    return email.toLowerCase().contains('fail') || password == 'fail';
  }
}
