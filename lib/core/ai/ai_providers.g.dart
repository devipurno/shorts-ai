// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ai_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(geminiLlm)
const geminiLlmProvider = GeminiLlmProvider._();

final class GeminiLlmProvider
    extends $FunctionalProvider<GeminiProvider, GeminiProvider, GeminiProvider>
    with $Provider<GeminiProvider> {
  const GeminiLlmProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'geminiLlmProvider',
          isAutoDispose: false,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$geminiLlmHash();

  @$internal
  @override
  $ProviderElement<GeminiProvider> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  GeminiProvider create(Ref ref) {
    return geminiLlm(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GeminiProvider value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GeminiProvider>(value),
    );
  }
}

String _$geminiLlmHash() => r'2df84754ecdbd09a2bad4f96dac5b04018cb09eb';

@ProviderFor(groqAi)
const groqAiProvider = GroqAiProvider._();

final class GroqAiProvider
    extends $FunctionalProvider<GroqProvider, GroqProvider, GroqProvider>
    with $Provider<GroqProvider> {
  const GroqAiProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'groqAiProvider',
          isAutoDispose: false,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$groqAiHash();

  @$internal
  @override
  $ProviderElement<GroqProvider> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  GroqProvider create(Ref ref) {
    return groqAi(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GroqProvider value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GroqProvider>(value),
    );
  }
}

String _$groqAiHash() => r'c3769d8658e9bc2db03d45be7ab0496dc1e51442';

@ProviderFor(deepSeekLlm)
const deepSeekLlmProvider = DeepSeekLlmProvider._();

final class DeepSeekLlmProvider extends $FunctionalProvider<DeepSeekProvider,
    DeepSeekProvider, DeepSeekProvider> with $Provider<DeepSeekProvider> {
  const DeepSeekLlmProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'deepSeekLlmProvider',
          isAutoDispose: false,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$deepSeekLlmHash();

  @$internal
  @override
  $ProviderElement<DeepSeekProvider> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  DeepSeekProvider create(Ref ref) {
    return deepSeekLlm(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(DeepSeekProvider value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<DeepSeekProvider>(value),
    );
  }
}

String _$deepSeekLlmHash() => r'1e79a250f079dd4d1c6a23515b3398bb4e954579';

@ProviderFor(edgeTts)
const edgeTtsProvider = EdgeTtsProvider._();

final class EdgeTtsProvider extends $FunctionalProvider<EdgeTTSProvider,
    EdgeTTSProvider, EdgeTTSProvider> with $Provider<EdgeTTSProvider> {
  const EdgeTtsProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'edgeTtsProvider',
          isAutoDispose: false,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$edgeTtsHash();

  @$internal
  @override
  $ProviderElement<EdgeTTSProvider> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  EdgeTTSProvider create(Ref ref) {
    return edgeTts(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(EdgeTTSProvider value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<EdgeTTSProvider>(value),
    );
  }
}

String _$edgeTtsHash() => r'99ef0dafe7cf495652d1227d137afe1f769572d9';

@ProviderFor(pollinationsImage)
const pollinationsImageProvider = PollinationsImageProvider._();

final class PollinationsImageProvider extends $FunctionalProvider<
    PollinationsProvider,
    PollinationsProvider,
    PollinationsProvider> with $Provider<PollinationsProvider> {
  const PollinationsImageProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'pollinationsImageProvider',
          isAutoDispose: false,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$pollinationsImageHash();

  @$internal
  @override
  $ProviderElement<PollinationsProvider> $createElement(
          $ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  PollinationsProvider create(Ref ref) {
    return pollinationsImage(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PollinationsProvider value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PollinationsProvider>(value),
    );
  }
}

String _$pollinationsImageHash() => r'028ff289b606d7c00206bf9f65546ad490a35aee';

@ProviderFor(quotaTracker)
const quotaTrackerProvider = QuotaTrackerProvider._();

final class QuotaTrackerProvider extends $FunctionalProvider<
        AsyncValue<QuotaTracker>, QuotaTracker, FutureOr<QuotaTracker>>
    with $FutureModifier<QuotaTracker>, $FutureProvider<QuotaTracker> {
  const QuotaTrackerProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'quotaTrackerProvider',
          isAutoDispose: false,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$quotaTrackerHash();

  @$internal
  @override
  $FutureProviderElement<QuotaTracker> $createElement(
          $ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<QuotaTracker> create(Ref ref) {
    return quotaTracker(ref);
  }
}

String _$quotaTrackerHash() => r'150fe724ebac11b680ac6da1718a3c9c04237653';

@ProviderFor(aiCache)
const aiCacheProvider = AiCacheProvider._();

final class AiCacheProvider
    extends $FunctionalProvider<AsyncValue<AICache>, AICache, FutureOr<AICache>>
    with $FutureModifier<AICache>, $FutureProvider<AICache> {
  const AiCacheProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'aiCacheProvider',
          isAutoDispose: false,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$aiCacheHash();

  @$internal
  @override
  $FutureProviderElement<AICache> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<AICache> create(Ref ref) {
    return aiCache(ref);
  }
}

String _$aiCacheHash() => r'e3117bc1e593c0d441dac508026211e7df07f065';

@ProviderFor(aiRouter)
const aiRouterProvider = AiRouterProvider._();

final class AiRouterProvider extends $FunctionalProvider<AsyncValue<AIRouter>,
        AIRouter, FutureOr<AIRouter>>
    with $FutureModifier<AIRouter>, $FutureProvider<AIRouter> {
  const AiRouterProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'aiRouterProvider',
          isAutoDispose: false,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$aiRouterHash();

  @$internal
  @override
  $FutureProviderElement<AIRouter> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<AIRouter> create(Ref ref) {
    return aiRouter(ref);
  }
}

String _$aiRouterHash() => r'0efa04853d5cb56825affb4b80fe665c9bbe8cd9';
