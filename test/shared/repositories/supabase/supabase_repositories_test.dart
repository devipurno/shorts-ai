import 'dart:async';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:shorts_ai/core/errors/app_exception.dart';
import 'package:shorts_ai/shared/models/user.dart';
import 'package:shorts_ai/shared/repositories/supabase/supabase_auth_repository.dart';
import 'package:shorts_ai/shared/repositories/supabase/supabase_user_repository.dart';
import 'package:shorts_ai/shared/services/supabase_service.dart';

void main() {
  test('SupabaseAuthRepository supports login, signup, OTP, reset, and logout',
      () async {
    final service = _FakeSupabaseService();
    final repository = SupabaseAuthRepository(service: service);

    final loggedIn = await repository.login(
      email: 'creator@autoshort.id',
      password: 'secret123',
    );

    expect(loggedIn.email, 'creator@autoshort.id');
    expect(loggedIn.name, 'Creator');
    expect(await repository.currentUser(), isNotNull);

    final signedUp = await repository.signup(
      email: 'new@autoshort.id',
      password: 'secret123',
      name: 'New Creator',
    );

    expect(signedUp.name, 'New Creator');
    expect(service.profileRows[signedUp.id]?['tier'], 'free');

    await repository.sendOtp('new@autoshort.id');
    final otpUser = await repository.verifyOtp(
      email: 'new@autoshort.id',
      token: '123456',
    );
    expect(otpUser?.email, 'new@autoshort.id');

    final resetUser = await repository.resetPassword('new-secret123');
    expect(resetUser.id, signedUp.id);

    await repository.logout();
    expect(service.signOutCalled, isTrue);
    expect(await repository.currentUser(), isNull);
  });

  test('SupabaseUserRepository supports profile CRUD and avatar upload',
      () async {
    final service = _FakeSupabaseService();
    final repository = SupabaseUserRepository(service: service);

    final initial = await repository.getProfile('user_1');
    expect(initial?.name, 'Creator');

    final updated = await repository.updateProfile(initial!.copyWith(
      name: 'Creator Updated',
    ));
    expect(updated.name, 'Creator Updated');

    final tempDir = await Directory.systemTemp.createTemp('autoshort-avatar');
    addTearDown(() => tempDir.delete(recursive: true));
    final file = File('${tempDir.path}/avatar.png')..writeAsBytesSync([1, 2]);
    final avatarUrl = await repository.uploadAvatar(file, userId: 'user_1');

    expect(avatarUrl, contains('/avatars/user_1/avatar.png'));
  });

  test('Supabase repositories map service failures into app exceptions',
      () async {
    final service = _FakeSupabaseService()..failNext = StateError('network');

    await expectLater(
      SupabaseAuthRepository(service: service).login(
        email: 'creator@autoshort.id',
        password: 'secret123',
      ),
      throwsA(isA<AuthException>()),
    );

    service.failNext = StateError('profile fail');
    await expectLater(
      SupabaseUserRepository(service: service).getProfile('user_1'),
      throwsA(isA<ServerException>()),
    );
  });
}

class _FakeSupabaseService extends SupabaseService {
  _FakeSupabaseService() {
    profileRows['user_1'] = _profileRow(
      id: 'user_1',
      email: 'creator@autoshort.id',
      name: 'Creator',
    );
  }

  final authController = StreamController<SupabaseAuthProfile?>.broadcast();
  final profileRows = <String, Map<String, dynamic>>{};
  SupabaseAuthProfile? activeUser;
  Object? failNext;
  bool signOutCalled = false;

  @override
  SupabaseAuthProfile? get currentAuthProfile => activeUser;

  @override
  Stream<SupabaseAuthProfile?> watchAuthProfiles() => authController.stream;

  @override
  Future<SupabaseAuthProfile> signInWithPassword({
    required String email,
    required String password,
  }) async {
    _throwIfNeeded();
    final row = profileRows.values.firstWhere(
      (item) => item['email'] == email,
      orElse: () =>
          _profileRow(id: 'user_login', email: email, name: 'Creator'),
    );
    activeUser = SupabaseAuthProfile(
      id: row['id'] as String,
      email: email,
      metadata: {'name': row['name']},
      createdAt: DateTime.parse(row['created_at'] as String),
    );
    authController.add(activeUser);
    return activeUser!;
  }

  @override
  Future<SupabaseAuthProfile> signUp({
    required String email,
    required String password,
    required String name,
  }) async {
    _throwIfNeeded();
    activeUser = SupabaseAuthProfile(
      id: 'user_${profileRows.length + 1}',
      email: email,
      metadata: {'name': name},
      createdAt: DateTime.utc(2026, 6),
    );
    authController.add(activeUser);
    return activeUser!;
  }

  @override
  Future<void> sendOtp(String email) async {
    _throwIfNeeded();
  }

  @override
  Future<SupabaseAuthProfile?> verifyOtp({
    required String email,
    required String token,
    bool recovery = false,
  }) async {
    _throwIfNeeded();
    if (recovery) {
      return null;
    }
    activeUser ??= SupabaseAuthProfile(
      id: 'user_otp',
      email: email,
      metadata: {'name': email.split('@').first},
      createdAt: DateTime.utc(2026, 6),
    );
    return activeUser;
  }

  @override
  Future<SupabaseAuthProfile> updatePassword(String newPassword) async {
    _throwIfNeeded();
    return activeUser!;
  }

  @override
  Future<void> signOut() async {
    _throwIfNeeded();
    signOutCalled = true;
    activeUser = null;
    authController.add(null);
  }

  @override
  Future<Map<String, dynamic>?> getProfileRow(String userId) async {
    _throwIfNeeded();
    return profileRows[userId];
  }

  @override
  Future<Map<String, dynamic>> insertProfileRow(
    Map<String, dynamic> values,
  ) async {
    _throwIfNeeded();
    profileRows[values['id'] as String] = Map<String, dynamic>.from(values);
    return profileRows[values['id'] as String]!;
  }

  @override
  Future<Map<String, dynamic>> updateProfileRow(
    String userId,
    Map<String, dynamic> values,
  ) async {
    _throwIfNeeded();
    profileRows[userId] = {
      ...?profileRows[userId],
      ...values,
      'updated_at': DateTime.utc(2026, 6, 1).toIso8601String(),
    };
    return profileRows[userId]!;
  }

  @override
  Future<String> uploadAvatar({
    required String userId,
    required File file,
  }) async {
    _throwIfNeeded();
    return 'https://cdn.autoshort.test/avatars/$userId/${file.uri.pathSegments.last}';
  }

  void _throwIfNeeded() {
    final error = failNext;
    if (error == null) {
      return;
    }
    failNext = null;
    throw error;
  }
}

Map<String, dynamic> _profileRow({
  required String id,
  required String email,
  required String name,
}) {
  return {
    'id': id,
    'email': email,
    'name': name,
    'avatar_url': null,
    'phone_number': null,
    'locale': 'id_ID',
    'timezone': 'Asia/Bangkok',
    'tier': SubscriptionTier.free.name,
    'created_at': DateTime.utc(2026, 6).toIso8601String(),
    'updated_at': DateTime.utc(2026, 6).toIso8601String(),
    'last_login_at': DateTime.utc(2026, 6).toIso8601String(),
  };
}
