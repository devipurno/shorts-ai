import 'dart:io';

import '../models/user.dart';

/// Contract for UserRepository implementations.
///
/// Implementations may be backed by mock memory stores, Supabase, or the
/// Fastify API. Callers should depend on this abstraction through Riverpod
/// providers so feature code stays portable across local and production modes.
abstract class UserRepository {
  Future<User?> getProfile(String userId);

  Future<User?> getById(String id);

  Future<User> updateProfile(User user);

  Future<String> uploadAvatar(File file, {required String userId});

  Stream<User?> watchProfile(String userId);
}
