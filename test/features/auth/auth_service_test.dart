import 'package:flutter_test/flutter_test.dart';
import 'package:shorts_ai/shared/services/auth_service.dart';
import 'package:shorts_ai/shared/services/supabase_service.dart';

void main() {
  test('signInWithEmail delegates to SupabaseService', () async {
    final fake = _FakeSupabaseService();
    final service = AuthService(supabaseService: fake);

    final profile = await service.signInWithEmail(
      email: 'devi@autoshort.id',
      password: 'secret123',
    );

    expect(fake.lastSignInEmail, 'devi@autoshort.id');
    expect(fake.lastSignInPassword, 'secret123');
    expect(profile.email, 'devi@autoshort.id');
  });

  test('signUpWithEmail passes displayName metadata through service boundary',
      () async {
    final fake = _FakeSupabaseService();
    final service = AuthService(supabaseService: fake);

    final profile = await service.signUpWithEmail(
      email: 'new@autoshort.id',
      password: 'secret123',
      displayName: 'Devi Purnomo',
    );

    expect(fake.lastSignupName, 'Devi Purnomo');
    expect(profile.metadata['display_name'], 'Devi Purnomo');
  });

  test('password reset and sign out delegate to SupabaseService', () async {
    final fake = _FakeSupabaseService();
    final service = AuthService(supabaseService: fake);

    await service.sendPasswordResetEmail('reset@autoshort.id');
    await service.signOut();

    expect(fake.lastResetEmail, 'reset@autoshort.id');
    expect(fake.didSignOut, isTrue);
  });

  test('displayNameFromAuthProfile uses metadata, email, then Devi fallback',
      () {
    expect(
      displayNameFromAuthProfile(
        const SupabaseAuthProfile(
          id: '1',
          email: 'creator@autoshort.id',
          metadata: {'display_name': 'Creator Name'},
        ),
      ),
      'Creator Name',
    );
    expect(
      displayNameFromAuthProfile(
        const SupabaseAuthProfile(id: '2', email: 'devi@autoshort.id'),
      ),
      'devi',
    );
    expect(displayNameFromAuthProfile(null), 'Devi');
  });
}

class _FakeSupabaseService extends SupabaseService {
  String? lastSignInEmail;
  String? lastSignInPassword;
  String? lastSignupName;
  String? lastResetEmail;
  bool didSignOut = false;

  @override
  Future<SupabaseAuthProfile> signInWithPassword({
    required String email,
    required String password,
  }) async {
    lastSignInEmail = email;
    lastSignInPassword = password;
    return SupabaseAuthProfile(id: 'signin-user', email: email);
  }

  @override
  Future<SupabaseAuthProfile> signUp({
    required String email,
    required String password,
    required String name,
  }) async {
    lastSignupName = name;
    return SupabaseAuthProfile(
      id: 'signup-user',
      email: email,
      metadata: {'display_name': name},
    );
  }

  @override
  Future<void> sendPasswordResetEmail(String email) async {
    lastResetEmail = email;
  }

  @override
  Future<void> signOut() async {
    didSignOut = true;
  }
}
