import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../core/error_reporter.dart';
import '../../../core/utils/logger.dart';
import '../../../shared/models/script.dart';
import '../../../shared/repositories/providers.dart';
import '../../auth/models/user.dart';
import '../../auth/providers/current_user_provider.dart';
import '../services/ai_hook_service.dart';

part 'hook_provider.freezed.dart';

final hookGeneratorProvider =
    StateNotifierProvider<HookGeneratorNotifier, HookGeneratorState>((ref) {
  return HookGeneratorNotifier(
    ref: ref,
    service: ref.watch(aiHookServiceProvider),
    errorReporter: ref.watch(errorReporterProvider),
  );
});

const hookNiches = <String>[
  'Lifestyle',
  'Tech',
  'Food',
  'Fitness',
  'Finance',
  'Education',
  'Entertainment',
];

const freeHookGenerationLimit = 3;
const standardHookGenerationLimit = 10;

@freezed
abstract class HookGeneratorState with _$HookGeneratorState {
  const factory HookGeneratorState({
    @Default('') String topic,
    @Default(<HookStyle>[]) List<HookStyle> styles,
    @Default('Lifestyle') String niche,
    @Default(HookLanguage.id) HookLanguage language,
    @Default('') String customStylePrompt,
    @Default(false) bool isGenerating,
    @Default(<HookOption>[]) List<HookOption> results,
    @Default(<HookOption>[]) List<HookOption> favoriteHooks,
    @Default(0) int generationsToday,
    DateTime? generationDay,
    String? copiedHookId,
    String? usedHookId,
    String? errorMessage,
    @Default(false) bool upgradePromptVisible,
  }) = _HookGeneratorState;
}

class HookGeneratorNotifier extends StateNotifier<HookGeneratorState> {
  HookGeneratorNotifier({
    required Ref ref,
    required AiHookService service,
    required ErrorReporter errorReporter,
  })  : _ref = ref,
        _service = service,
        _errorReporter = errorReporter,
        super(const HookGeneratorState(styles: [HookStyle.question]));

  final Ref _ref;
  final AiHookService _service;
  final ErrorReporter _errorReporter;

  User? get _user => _ref.read(currentUserProvider);
  SubscriptionTier get _tier => _user?.tier ?? SubscriptionTier.free;

  void setTopic(String value) {
    state = state.copyWith(topic: value, errorMessage: null);
  }

  void toggleStyle(HookStyle style) {
    final allowed = allowedStylesForTier(_tier);
    if (!allowed.contains(style)) {
      state = state.copyWith(
        errorMessage: 'Upgrade untuk membuka style ${hookStyleLabel(style)}.',
        upgradePromptVisible: true,
      );
      return;
    }

    final styles = [...state.styles];
    if (styles.contains(style)) {
      styles.remove(style);
    } else {
      if (styles.length >= 3) {
        state = state.copyWith(
          errorMessage: 'Maksimal pilih 3 style hook.',
          upgradePromptVisible: false,
        );
        return;
      }
      styles.add(style);
    }

    state = state.copyWith(
      styles: List<HookStyle>.unmodifiable(styles),
      errorMessage: null,
      upgradePromptVisible: false,
    );
  }

  void setNiche(String value) {
    state = state.copyWith(niche: value, errorMessage: null);
  }

  void setLanguage(HookLanguage value) {
    state = state.copyWith(language: value, errorMessage: null);
  }

  void setCustomStylePrompt(String value) {
    state = state.copyWith(customStylePrompt: value, errorMessage: null);
  }

  Future<bool> generate() async {
    final topic = state.topic.trim();
    if (topic.isEmpty) {
      state = state.copyWith(
        errorMessage: 'Topik video wajib diisi.',
        upgradePromptVisible: false,
      );
      return false;
    }

    final normalized = _normalizeGenerationWindow(state);
    state = normalized;

    final limit = generationLimitForTier(_tier);
    if (limit != null && normalized.generationsToday >= limit) {
      state = normalized.copyWith(
        errorMessage:
            'Limit harian ${tierLabel(_tier)} sudah habis. Upgrade untuk generate lebih banyak.',
        upgradePromptVisible: true,
      );
      return false;
    }

    state = state.copyWith(
      isGenerating: true,
      errorMessage: null,
      upgradePromptVisible: false,
    );

    try {
      final results = await _service.generate(
        topic: topic,
        styles: state.styles,
        niche: state.niche,
        language: state.language,
        customStylePrompt:
            canUseCustomStyle(_tier) ? state.customStylePrompt : null,
      );

      state = state.copyWith(
        isGenerating: false,
        results: List<HookOption>.unmodifiable(results),
        generationsToday: state.generationsToday + 1,
        generationDay: _today(),
      );
      return true;
    } catch (error, stackTrace) {
      AppLogger.e(
        'Hook generation failed',
        tag: 'HookGenerator',
        error: error,
        stackTrace: stackTrace,
      );
      _errorReporter.captureException(
        error,
        stackTrace: stackTrace,
        hint: 'hook_generation',
      );
      state = state.copyWith(
        isGenerating: false,
        errorMessage: 'Gagal generate hook. Coba lagi.',
        upgradePromptVisible: false,
      );
      return false;
    }
  }

  void copyHook(String hookId) {
    state = state.copyWith(copiedHookId: hookId, errorMessage: null);
  }

  Future<void> useHook(String projectId, {String? hookId}) async {
    final hook = _findHook(hookId ?? state.results.firstOrNull?.id);
    if (hook == null) {
      state = state.copyWith(errorMessage: 'Hook belum dipilih.');
      return;
    }

    final repository = _ref.read(scriptRepositoryProvider);
    final existingScripts = await repository.getAll(projectId: projectId);
    final now = DateTime.now().toUtc();
    final script = existingScripts.firstOrNull;

    if (script == null) {
      await repository.create(
        Script(
          id: 'script_${projectId}_${now.microsecondsSinceEpoch}',
          projectId: projectId,
          content: hook.text,
          hookOptions: [hook],
          selectedHookId: hook.id,
          language: state.language.name,
          durationEstimate: 30,
          aiModelUsed: 'mock-ai-hook-service',
          generatedAt: now,
        ),
      );
    } else {
      final hookOptions = [
        hook,
        ...script.hookOptions.where((item) => item.id != hook.id),
      ];
      await repository.update(
        script.copyWith(
          content: hook.text,
          hookOptions: hookOptions,
          selectedHookId: hook.id,
          language: state.language.name,
          generatedAt: now,
        ),
      );
    }

    state = state.copyWith(usedHookId: hook.id, errorMessage: null);
  }

  void favoriteHook(HookOption hook) {
    final favorites = [...state.favoriteHooks];
    final index = favorites.indexWhere((item) => item.id == hook.id);
    if (index == -1) {
      favorites.add(hook);
    } else {
      favorites.removeAt(index);
    }

    state = state.copyWith(
      favoriteHooks: List<HookOption>.unmodifiable(favorites),
      errorMessage: null,
    );
  }

  void deleteFavoriteHook(String hookId) {
    state = state.copyWith(
      favoriteHooks: List<HookOption>.unmodifiable(
        state.favoriteHooks.where((hook) => hook.id != hookId),
      ),
    );
  }

  void dismissUpgradePrompt() {
    state = state.copyWith(upgradePromptVisible: false);
  }

  HookOption? _findHook(String? hookId) {
    if (hookId == null) {
      return null;
    }

    return [
      ...state.results,
      ...state.favoriteHooks,
    ].where((hook) => hook.id == hookId).firstOrNull;
  }

  HookGeneratorState _normalizeGenerationWindow(HookGeneratorState value) {
    final currentDay = _today();
    final previous = value.generationDay;
    if (previous == null || !_isSameDay(previous, currentDay)) {
      return value.copyWith(generationDay: currentDay, generationsToday: 0);
    }
    return value;
  }

  DateTime _today() {
    final now = DateTime.now();
    return DateTime(now.year, now.month, now.day);
  }

  bool _isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }
}

List<HookStyle> allowedStylesForTier(SubscriptionTier tier) {
  return switch (tier) {
    SubscriptionTier.free => const [
        HookStyle.question,
        HookStyle.statement,
        HookStyle.shock,
      ],
    SubscriptionTier.standard ||
    SubscriptionTier.premium ||
    SubscriptionTier.lifetime =>
      HookStyle.values,
  };
}

int? generationLimitForTier(SubscriptionTier tier) {
  return switch (tier) {
    SubscriptionTier.free => freeHookGenerationLimit,
    SubscriptionTier.standard => standardHookGenerationLimit,
    SubscriptionTier.premium || SubscriptionTier.lifetime => null,
  };
}

bool canUseCustomStyle(SubscriptionTier tier) {
  return tier == SubscriptionTier.premium || tier == SubscriptionTier.lifetime;
}

String tierLabel(SubscriptionTier tier) {
  return switch (tier) {
    SubscriptionTier.free => 'Free',
    SubscriptionTier.standard => 'Standard',
    SubscriptionTier.premium => 'Premium',
    SubscriptionTier.lifetime => 'Lifetime',
  };
}

String hookStyleLabel(HookStyle style) {
  return switch (style) {
    HookStyle.question => 'Question',
    HookStyle.statement => 'Statement',
    HookStyle.shock => 'Shock',
    HookStyle.story => 'Story',
    HookStyle.curiosity => 'Curiosity',
  };
}

String hookStyleDescription(HookStyle style) {
  return switch (style) {
    HookStyle.question => 'Pertanyaan pembuka yang bikin audiens ikut mikir.',
    HookStyle.statement => 'Klaim tegas untuk positioning cepat.',
    HookStyle.shock => 'Kontras tinggi untuk pattern interrupt.',
    HookStyle.story => 'Pembuka naratif dengan rasa personal.',
    HookStyle.curiosity => 'Open loop yang bikin penonton ingin tahu lanjut.',
  };
}
