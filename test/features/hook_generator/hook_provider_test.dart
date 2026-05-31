import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shorts_ai/features/auth/models/user.dart';
import 'package:shorts_ai/features/auth/providers/current_user_provider.dart';
import 'package:shorts_ai/features/hook_generator/providers/hook_provider.dart';
import 'package:shorts_ai/features/hook_generator/services/ai_hook_service.dart';
import 'package:shorts_ai/shared/models/script.dart';

void main() {
  test('updates input state and enforces max 3 selected styles', () {
    final container = _container(user: _premiumUser);
    addTearDown(container.dispose);

    final notifier = container.read(hookGeneratorProvider.notifier)
      ..setTopic('cara bikin konten edukasi')
      ..setNiche('Education')
      ..setLanguage(HookLanguage.bilingual)
      ..toggleStyle(HookStyle.statement)
      ..toggleStyle(HookStyle.shock)
      ..toggleStyle(HookStyle.story)
      ..toggleStyle(HookStyle.curiosity);

    final state = container.read(hookGeneratorProvider);

    expect(state.topic, 'cara bikin konten edukasi');
    expect(state.niche, 'Education');
    expect(state.language, HookLanguage.bilingual);
    expect(state.styles, hasLength(3));
    expect(state.styles, isNot(contains(HookStyle.curiosity)));
    expect(state.errorMessage, 'Maksimal pilih 3 style hook.');
    expect(notifier, isA<HookGeneratorNotifier>());
  });

  test('mock generate returns 5 hook results', () async {
    final container = _container(user: _premiumUser);
    addTearDown(container.dispose);

    final notifier = container.read(hookGeneratorProvider.notifier)
      ..setTopic('tips jualan digital')
      ..toggleStyle(HookStyle.statement);

    final generated = await notifier.generate();
    final state = container.read(hookGeneratorProvider);

    expect(generated, isTrue);
    expect(state.results, hasLength(5));
    expect(state.results.first.text, contains('tips jualan digital'));
    expect(state.generationsToday, 1);
  });

  test('copy and favorite actions update hook state', () async {
    final container = _container(user: _premiumUser);
    addTearDown(container.dispose);

    final notifier = container.read(hookGeneratorProvider.notifier)
      ..setTopic('konten growth');

    await notifier.generate();
    final hook = container.read(hookGeneratorProvider).results.first;

    notifier.copyHook(hook.id);
    notifier.favoriteHook(hook);

    var state = container.read(hookGeneratorProvider);
    expect(state.copiedHookId, hook.id);
    expect(state.favoriteHooks.single.id, hook.id);

    notifier.favoriteHook(hook);
    state = container.read(hookGeneratorProvider);
    expect(state.favoriteHooks, isEmpty);
  });

  test('free tier blocks generation after 3 daily runs', () async {
    final container = _container(user: _freeUser);
    addTearDown(container.dispose);

    final notifier = container.read(hookGeneratorProvider.notifier)
      ..setTopic('rutinitas creator pemula');

    expect(await notifier.generate(), isTrue);
    expect(await notifier.generate(), isTrue);
    expect(await notifier.generate(), isTrue);
    expect(await notifier.generate(), isFalse);

    final state = container.read(hookGeneratorProvider);
    expect(state.generationsToday, freeHookGenerationLimit);
    expect(state.upgradePromptVisible, isTrue);
    expect(state.errorMessage, contains('Limit harian Free'));
  });
}

ProviderContainer _container({required User user}) {
  return ProviderContainer(
    overrides: [
      currentUserProvider.overrideWithValue(user),
      aiHookServiceProvider.overrideWithValue(_FakeAiHookService()),
    ],
  );
}

final _freeUser = User(
  id: 'free-user',
  email: 'free@autoshort.id',
  tier: SubscriptionTier.free,
  createdAt: DateTime(2026),
);

final _premiumUser = User(
  id: 'premium-user',
  email: 'premium@autoshort.id',
  tier: SubscriptionTier.premium,
  createdAt: DateTime(2026),
);

class _FakeAiHookService extends AiHookService {
  @override
  Future<List<HookOption>> generate({
    required String topic,
    required List<HookStyle> styles,
    required String niche,
    required HookLanguage language,
    String? customStylePrompt,
  }) async {
    return List<HookOption>.generate(
      5,
      (index) => HookOption(
        id: 'hook_$index',
        text: '$topic hook variant ${index + 1}',
        style: styles.isEmpty ? HookStyle.statement : styles.first,
        score: (55 + index * 8).toDouble(),
      ),
    );
  }
}
