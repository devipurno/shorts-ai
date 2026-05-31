import '../../../core/errors/app_exception.dart';
import '../../models/user.dart';
import '../../services/supabase_service.dart';
import '../auth_repository.dart';

class SupabaseAuthRepository implements AuthRepository {
  SupabaseAuthRepository({SupabaseService? service})
      : _service = service ?? SupabaseService();

  final SupabaseService _service;

  @override
  Future<User?> currentUser() async {
    final authProfile = _service.currentAuthProfile;
    if (authProfile == null) {
      return null;
    }
    return _userFromAuth(authProfile);
  }

  @override
  Future<User> login({
    required String email,
    required String password,
  }) async {
    return _guardAuth(() async {
      final authProfile = await _service.signInWithPassword(
        email: email,
        password: password,
      );
      final row = await _service.getProfileRow(authProfile.id);
      return _userFromAuth(authProfile, row: row);
    }, fallbackMessage: 'Supabase login failed.');
  }

  @override
  Future<User> signup({
    required String email,
    required String password,
    required String name,
  }) async {
    return _guardAuth(() async {
      final authProfile = await _service.signUp(
        email: email,
        password: password,
        name: name,
      );
      final now = DateTime.now().toUtc();
      final row = await _service.insertProfileRow({
        'id': authProfile.id,
        'email': authProfile.email,
        'name': name.trim(),
        'tier': SubscriptionTier.free.name,
        'locale': 'id_ID',
        'timezone': 'Asia/Bangkok',
        'trial_started_at': now.toIso8601String(),
        'trial_ends_at': now.add(const Duration(days: 14)).toIso8601String(),
        'created_at': now.toIso8601String(),
        'updated_at': now.toIso8601String(),
        'last_login_at': now.toIso8601String(),
      });
      return _userFromAuth(authProfile, row: row);
    }, fallbackMessage: 'Supabase signup failed.');
  }

  @override
  Future<void> sendOtp(String email) async {
    await _guardAuth<void>(
      () => _service.sendOtp(email),
      fallbackMessage: 'Unable to send Supabase OTP.',
    );
  }

  @override
  Future<User?> verifyOtp({
    required String email,
    required String token,
    bool recovery = false,
  }) async {
    return _guardAuth(() async {
      final authProfile = await _service.verifyOtp(
        email: email,
        token: token,
        recovery: recovery,
      );
      if (authProfile == null || recovery) {
        return null;
      }
      final row = await _service.getProfileRow(authProfile.id);
      return _userFromAuth(authProfile, row: row);
    }, fallbackMessage: 'Unable to verify Supabase OTP.');
  }

  @override
  Future<User> resetPassword(String newPassword) async {
    return _guardAuth(() async {
      final authProfile = await _service.updatePassword(newPassword);
      final row = await _service.getProfileRow(authProfile.id);
      return _userFromAuth(authProfile, row: row);
    }, fallbackMessage: 'Unable to reset Supabase password.');
  }

  @override
  Future<void> logout() async {
    await _guardAuth<void>(
      _service.signOut,
      fallbackMessage: 'Supabase logout failed.',
    );
  }

  @override
  Future<User?> refresh() => currentUser();

  @override
  Stream<User?> watchAuthState() {
    return _service.watchAuthProfiles().asyncMap((authProfile) async {
      if (authProfile == null) {
        return null;
      }
      final row = await _service.getProfileRow(authProfile.id);
      return _userFromAuth(authProfile, row: row);
    });
  }

  User _userFromAuth(
    SupabaseAuthProfile authProfile, {
    Map<String, dynamic>? row,
  }) {
    final now = DateTime.now().toUtc();
    final metadataName = authProfile.metadata['name']?.toString();
    final data = <String, Object?>{
      'id': authProfile.id,
      'email': authProfile.email,
      'name': metadataName ?? authProfile.email.split('@').first,
      'locale': 'id_ID',
      'timezone': 'Asia/Bangkok',
      'tier': SubscriptionTier.free.name,
      'created_at': (authProfile.createdAt ?? now).toIso8601String(),
      'updated_at': now.toIso8601String(),
      if (authProfile.createdAt != null)
        'last_login_at': authProfile.createdAt!.toIso8601String(),
      ...?row,
    };
    return User.fromJson(data);
  }

  Future<T> _guardAuth<T>(
    Future<T> Function() action, {
    required String fallbackMessage,
  }) async {
    try {
      return await action();
    } on AppException {
      rethrow;
    } catch (error) {
      throw AuthException(
        _messageFrom(error, fallbackMessage),
        code: 'supabase_auth_error',
        originalError: error,
      );
    }
  }

  String _messageFrom(Object error, String fallback) {
    final message = error.toString();
    if (message.isEmpty) {
      return fallback;
    }
    return message;
  }
}
