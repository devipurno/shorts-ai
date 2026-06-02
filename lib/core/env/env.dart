import 'package:flutter/widgets.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class Env {
  Env._();

  static const String defaultEnvFile = '.env.local';
  static const String defaultApiBaseUrl = 'http://localhost:8000';
  static const String defaultAiProxyBaseUrl =
      'https://ai-proxy.autoshort.workers.dev';

  static Future<void> init({
    String fileName = defaultEnvFile,
    bool failFast = true,
    bool isOptional = true,
    Set<String> requiredKeys = const {'API_BASE_URL'},
  }) async {
    WidgetsFlutterBinding.ensureInitialized();
    await dotenv.load(fileName: fileName, isOptional: isOptional);

    if (failFast) {
      _validateRequired(requiredKeys);
    }
  }

  @visibleForTesting
  static void loadFromStringForTest(
    String value, {
    bool failFast = false,
    Set<String> requiredKeys = const {'API_BASE_URL'},
  }) {
    dotenv.loadFromString(envString: value, isOptional: true);
    if (failFast) {
      _validateRequired(requiredKeys);
    }
  }

  @visibleForTesting
  static void resetForTest() {
    dotenv.clean();
  }

  static String? get supabaseUrl => _value('SUPABASE_URL');
  static String? get supabaseAnonKey => _value('SUPABASE_ANON_KEY');
  static String? get supabasePublishableKey =>
      _value('SUPABASE_PUBLISHABLE_KEY');
  static String? get supabaseClientKey =>
      supabaseAnonKey ?? supabasePublishableKey;
  static String? get supabaseRedirectUrl => _value('SUPABASE_REDIRECT_URL');
  static bool get useMockAuth => _bool('USE_MOCK_AUTH') ?? false;
  static bool get useSupabase {
    final explicit = _bool('USE_SUPABASE');
    if (explicit != null) {
      return explicit;
    }
    return !useMockAuth && supabaseUrl != null && supabaseClientKey != null;
  }

  static String? get apiBaseUrlOrNull => _value('API_BASE_URL');
  static String get apiBaseUrl => apiBaseUrlOrNull ?? defaultApiBaseUrl;
  static bool get useMockRepositories => _bool('USE_MOCK') ?? false;
  static bool get useApiRepositories {
    final explicit = _bool('USE_API');
    if (explicit != null) {
      return explicit && !useMockRepositories;
    }
    return apiBaseUrlOrNull != null && !useMockRepositories;
  }

  static String? get aiProxyBaseUrlOrNull => _value('AI_PROXY_BASE_URL');
  static String get aiProxyBaseUrl =>
      aiProxyBaseUrlOrNull ?? defaultAiProxyBaseUrl;

  static String? get openaiApiKey => _value('OPENAI_API_KEY');
  static String? get elevenLabsApiKey => _value('ELEVENLABS_API_KEY');
  static String? get geminiApiKey => _value('GEMINI_API_KEY');
  static String? get groqApiKey => _value('GROQ_API_KEY');
  static String? get deepSeekApiKey => _value('DEEPSEEK_API_KEY');
  static String? get upstashRedisRestUrl => _value('UPSTASH_REDIS_REST_URL');
  static String? get upstashRedisRestToken =>
      _value('UPSTASH_REDIS_REST_TOKEN');
  static String? get sentryDsn => _value('SENTRY_DSN');
  static String? get firebaseApiKey => _value('FIREBASE_API_KEY');
  static String? get r2AccountId => _value('R2_ACCOUNT_ID');
  static String? get r2Bucket => _value('R2_BUCKET');
  static String? get r2PublicBaseUrl => _value('R2_PUBLIC_BASE_URL');
  static String? get defaultLlmProvider => _value('DEFAULT_LLM_PROVIDER');
  static String? get defaultOpenAiModel => _value('DEFAULT_OPENAI_MODEL');
  static String? get ollamaBaseUrl => _value('OLLAMA_BASE_URL');
  static String? get defaultOllamaModel => _value('DEFAULT_OLLAMA_MODEL');

  static bool get isInitialized => dotenv.isInitialized;

  static String require(String key) {
    final value = _value(key);
    if (value == null) {
      throw StateError('Missing required environment variable: $key');
    }
    return value;
  }

  static void _validateRequired(Set<String> keys) {
    final missing = keys.where((key) => _value(key) == null).toList();
    if (missing.isEmpty) {
      return;
    }

    throw StateError(
      'Missing required environment variables: ${missing.join(', ')}. '
      'Check $defaultEnvFile and restart AutoShort.',
    );
  }

  static String? _value(String key) {
    if (!dotenv.isInitialized) {
      return null;
    }

    final value = dotenv.env[key]?.trim();
    if (value == null || value.isEmpty) {
      return null;
    }
    return value;
  }

  static bool? _bool(String key) {
    final value = _value(key)?.toLowerCase();
    if (value == null) {
      return null;
    }
    if (value == 'true' || value == '1' || value == 'yes') {
      return true;
    }
    if (value == 'false' || value == '0' || value == 'no') {
      return false;
    }
    return null;
  }
}
