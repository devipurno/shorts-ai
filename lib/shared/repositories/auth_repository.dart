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

  Stream<User?> watchAuthState();
}
