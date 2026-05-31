import '../models/user.dart';

abstract class AuthRepository {
  Future<User?> currentUser();

  Future<User> login({
    required String email,
    required String password,
  });

  Future<User> signup({
    required String email,
    required String password,
    required String name,
  });

  Future<void> logout();

  Future<User?> refresh();

  Future<void> sendOtp(String email);

  Future<User?> verifyOtp({
    required String email,
    required String token,
    bool recovery,
  });

  Future<User> resetPassword(String newPassword);

  Stream<User?> watchAuthState();
}
