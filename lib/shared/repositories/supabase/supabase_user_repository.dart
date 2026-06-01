import 'dart:io';

import '../../../core/errors/app_exception.dart';
import '../../models/user.dart';
import '../../services/supabase_service.dart';
import '../user_repository.dart';

/// Public API surface for `SupabaseUserRepository`.
class SupabaseUserRepository implements UserRepository {
  SupabaseUserRepository({SupabaseService? service})
      : _service = service ?? SupabaseService();

  final SupabaseService _service;

  @override
  Future<User?> getProfile(String userId) => getById(userId);

  @override
  Future<User?> getById(String id) async {
    return _guardUser(() async {
      final row = await _service.getProfileRow(id);
      return row == null ? null : _userFromRow(row);
    }, fallbackMessage: 'Unable to load Supabase profile.');
  }

  @override
  Future<User> updateProfile(User user) async {
    return _guardUser(() async {
      final row = await _service.updateProfileRow(user.id, user.toJson());
      return _userFromRow(row);
    }, fallbackMessage: 'Unable to update Supabase profile.');
  }

  @override
  Future<String> uploadAvatar(File file, {required String userId}) {
    return _guardUser(
      () => _service.uploadAvatar(userId: userId, file: file),
      fallbackMessage: 'Unable to upload Supabase avatar.',
    );
  }

  @override
  Stream<User?> watchProfile(String userId) async* {
    yield await getProfile(userId);
  }

  User _userFromRow(Map<String, dynamic> row) {
    final now = DateTime.now().toUtc().toIso8601String();
    return User.fromJson({
      'email': '',
      'name': '',
      'locale': 'id_ID',
      'timezone': 'Asia/Bangkok',
      'tier': SubscriptionTier.free.name,
      'created_at': now,
      'updated_at': now,
      ...row,
    });
  }

  Future<T> _guardUser<T>(
    Future<T> Function() action, {
    required String fallbackMessage,
  }) async {
    try {
      return await action();
    } on AppException {
      rethrow;
    } catch (error) {
      throw ServerException(
        error.toString().isEmpty ? fallbackMessage : error.toString(),
        code: 'supabase_user_error',
        originalError: error,
      );
    }
  }
}
