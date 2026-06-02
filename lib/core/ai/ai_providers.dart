import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../error_reporter.dart';
import '../../shared/services/providers.dart';
import 'ai_proxy_client.dart';
import 'ai_router.dart';
import 'cache/ai_cache.dart';
import 'cache/upstash_client.dart';
import 'providers/deepseek_provider.dart';
import 'providers/edge_tts_provider.dart';
import 'providers/gemini_provider.dart';
import 'providers/groq_provider.dart';
import 'providers/pollinations_provider.dart';
import 'quota_tracker.dart';

part 'ai_providers.g.dart';

@Riverpod(keepAlive: true)
GeminiProvider geminiLlm(Ref ref) => GeminiProvider();

@Riverpod(keepAlive: true)
GroqProvider groqAi(Ref ref) => GroqProvider();

@Riverpod(keepAlive: true)
DeepSeekProvider deepSeekLlm(Ref ref) => DeepSeekProvider();

@Riverpod(keepAlive: true)
EdgeTTSProvider edgeTts(Ref ref) => EdgeTTSProvider();

@Riverpod(keepAlive: true)
PollinationsProvider pollinationsImage(Ref ref) => PollinationsProvider();

@Riverpod(keepAlive: true)
Future<QuotaTracker> quotaTracker(Ref ref) async {
  final preferences = await ref.watch(preferencesServiceProvider.future);
  return QuotaTracker(preferences: preferences);
}

@Riverpod(keepAlive: true)
Future<AICache> aiCache(Ref ref) async {
  return AICache(upstashClient: UpstashClient());
}

@Riverpod(keepAlive: true)
Future<AIRouter> aiRouter(Ref ref) async {
  return AIRouter(
    gemini: ref.watch(geminiLlmProvider),
    groq: ref.watch(groqAiProvider),
    deepSeek: ref.watch(deepSeekLlmProvider),
    edgeTts: ref.watch(edgeTtsProvider),
    pollinations: ref.watch(pollinationsImageProvider),
    quotaTracker: await ref.watch(quotaTrackerProvider.future),
    cache: await ref.watch(aiCacheProvider.future),
    proxy: AIProxyClient(),
    errorReporter: ref.watch(errorReporterProvider),
  );
}
