import '../shared/services/supabase_service.dart';

Future<void> initSupabase() => SupabaseService.initializeFromEnv();
