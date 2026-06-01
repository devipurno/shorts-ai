import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as supabase;

import '../../core/env/env.dart';

/// Supabase bootstrap service for auth, database, storage, and realtime access.
class SupabaseService {
  SupabaseService({supabase.SupabaseClient? client}) : _client = client;

  static bool _initialized = false;

  static bool get isInitialized => _initialized;

  static Future<void> initializeFromEnv() async {
    final url = Env.supabaseUrl;
    final key = Env.supabaseClientKey;
    if (url == null || key == null) {
      return;
    }

    await supabase.Supabase.initialize(
      url: url,
      anonKey: key,
      debug: kDebugMode,
    );
    _initialized = true;
  }

  final supabase.SupabaseClient? _client;

  supabase.SupabaseClient get client =>
      _client ?? supabase.Supabase.instance.client;

  supabase.User? get currentUser => client.auth.currentUser;

  supabase.Session? get currentSession => client.auth.currentSession;

  bool get isAuthenticated => currentSession != null;

  String? get accessToken => currentSession?.accessToken;

  SupabaseAuthProfile? get currentAuthProfile => _mapSupabaseUser(currentUser);

  Stream<SupabaseAuthProfile?> watchAuthProfiles() {
    return client.auth.onAuthStateChange.map(
      (event) => _mapSupabaseUser(event.session?.user),
    );
  }

  Future<SupabaseAuthProfile> signInWithPassword({
    required String email,
    required String password,
  }) async {
    final response = await client.auth.signInWithPassword(
      email: email,
      password: password,
    );
    return _requireUser(response.user);
  }

  Future<SupabaseAuthProfile> signUp({
    required String email,
    required String password,
    required String name,
  }) async {
    final response = await client.auth.signUp(
      email: email,
      password: password,
      data: {'name': name},
    );
    return _requireUser(response.user);
  }

  Future<void> sendOtp(String email) {
    return client.auth.signInWithOtp(
      email: email,
      shouldCreateUser: false,
    );
  }

  Future<SupabaseAuthProfile?> verifyOtp({
    required String email,
    required String token,
    bool recovery = false,
  }) async {
    final response = await client.auth.verifyOTP(
      email: email,
      token: token,
      type: recovery ? supabase.OtpType.recovery : supabase.OtpType.email,
    );
    return _mapSupabaseUser(response.user);
  }

  Future<SupabaseAuthProfile> updatePassword(String newPassword) async {
    final response = await client.auth.updateUser(
      supabase.UserAttributes(password: newPassword),
    );
    return _requireUser(response.user);
  }

  Future<void> signOut() => client.auth.signOut();

  Future<String?> refreshAccessToken() async {
    final response = await client.auth.refreshSession();
    return response.session?.accessToken;
  }

  Future<Map<String, dynamic>?> getProfileRow(String userId) async {
    final row =
        await client.from('profiles').select().eq('id', userId).maybeSingle();
    return row == null ? null : Map<String, dynamic>.from(row);
  }

  Future<Map<String, dynamic>> insertProfileRow(
    Map<String, dynamic> values,
  ) async {
    final row = await client.from('profiles').insert(values).select().single();
    return Map<String, dynamic>.from(row);
  }

  Future<Map<String, dynamic>> updateProfileRow(
    String userId,
    Map<String, dynamic> values,
  ) async {
    final row = await client
        .from('profiles')
        .update(values)
        .eq('id', userId)
        .select()
        .single();
    return Map<String, dynamic>.from(row);
  }

  Future<String> uploadAvatar({
    required String userId,
    required File file,
  }) async {
    final extension = file.path.split('.').last.toLowerCase();
    final objectPath =
        '$userId/avatar-${DateTime.now().millisecondsSinceEpoch}.$extension';
    await client.storage.from('avatars').upload(
          objectPath,
          file,
          fileOptions: const supabase.FileOptions(
            cacheControl: '3600',
            upsert: true,
          ),
        );
    return client.storage.from('avatars').getPublicUrl(objectPath);
  }

  SupabaseAuthProfile _requireUser(supabase.User? user) {
    final profile = _mapSupabaseUser(user);
    if (profile == null) {
      throw StateError('Supabase auth response did not include a user.');
    }
    return profile;
  }

  SupabaseAuthProfile? _mapSupabaseUser(supabase.User? user) {
    if (user == null) {
      return null;
    }
    return SupabaseAuthProfile(
      id: user.id,
      email: user.email ?? '',
      metadata: Map<String, dynamic>.from(user.userMetadata ?? const {}),
      createdAt: DateTime.tryParse(user.createdAt),
    );
  }
}

/// Supabase bootstrap service for auth, database, storage, and realtime access.
class SupabaseAuthProfile {
  const SupabaseAuthProfile({
    required this.id,
    required this.email,
    this.metadata = const {},
    this.createdAt,
  });

  final String id;
  final String email;
  final Map<String, dynamic> metadata;
  final DateTime? createdAt;
}
