import '../models/user.dart';

/// Contract for AuthRepository implementations.
///
/// Implementations may be backed by mock memory stores, Supabase, or the
/// Fastify API. Callers should depend on this abstraction through Riverpod
/// providers so feature code stays portable across local and production modes.
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

  Future<void> sendPasswordResetEmail(String email);

  Future<User?> verifyOtp({
    required String email,
    required String token,
    bool recovery,
  });

  Future<User> resetPassword(String newPassword);

  Stream<User?> watchAuthState();
}
