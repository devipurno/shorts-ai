import '../../core/env/env.dart';
import '../../core/error_reporter.dart';
import '../models/user.dart';
import 'supabase_service.dart';

/// Thin auth facade used by feature code and tests.
///
/// The app keeps repositories as the broader data abstraction, while this
/// service exposes the direct Supabase Auth operations needed by email/password
/// screens and profile identity display.
class AuthService {
  AuthService({
    SupabaseService? supabaseService,
    ErrorReporter? errorReporter,
  })  : _supabaseService = supabaseService ?? SupabaseService(),
        _errorReporter = errorReporter ?? const NoOpErrorReporter();

  final SupabaseService _supabaseService;
  final ErrorReporter _errorReporter;

  Stream<SupabaseAuthProfile?> get authStateChanges =>
      _supabaseService.watchAuthProfiles();

  SupabaseAuthProfile? get currentUser => _supabaseService.currentAuthProfile;

  bool get isAuthenticated => _supabaseService.isAuthenticated;

  Future<SupabaseAuthProfile> signInWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      final profile = await _supabaseService.signInWithPassword(
        email: email,
        password: password,
      );
      _errorReporter.addBreadcrumb(
        message: 'Sign-in attempt: success',
        category: 'auth',
      );
      return profile;
    } catch (error, stackTrace) {
      _errorReporter.addBreadcrumb(
        message: 'Sign-in attempt: failure',
        category: 'auth',
      );
      await _errorReporter.captureException(
        error,
        stackTrace: stackTrace,
        hint: 'auth_service_sign_in',
      );
      rethrow;
    }
  }

  Future<SupabaseAuthProfile> signUpWithEmail({
    required String email,
    required String password,
    required String displayName,
  }) async {
    final profile = await _supabaseService.signUp(
      email: email,
      password: password,
      name: displayName,
    );
    _errorReporter.addBreadcrumb(
      message: 'Sign-up attempt: success',
      category: 'auth',
    );
    return profile;
  }

  Future<void> sendPasswordResetEmail(String email) {
    return _supabaseService.sendPasswordResetEmail(email);
  }

  Future<void> signOut() => _supabaseService.signOut();

  String? get displayName => _supabaseService.displayName;
}

String displayNameFromAuthProfile(SupabaseAuthProfile? profile) {
  if (profile == null) {
    return 'Devi';
  }

  final metadataName =
      profile.metadata['display_name'] ?? profile.metadata['name'];
  final name = metadataName?.toString().trim();
  if (name != null && name.isNotEmpty) {
    return name;
  }

  if (profile.email.contains('@')) {
    return profile.email.split('@').first;
  }

  return 'Devi';
}

String displayNameFromUser(User? user) {
  final rawName = user?.name;
  final name = rawName?.trim();
  if (name != null && name.isNotEmpty) {
    return name;
  }
  final email = user?.email.trim();
  if (email != null && email.contains('@')) {
    return email.split('@').first;
  }
  return Env.useMockAuth ? 'Devi' : 'Devi';
}
