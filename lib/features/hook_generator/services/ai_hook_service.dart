import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../shared/models/script.dart';

final aiHookServiceProvider = Provider<AiHookService>((ref) {
  return AiHookService();
});

class AiHookService {
  AiHookService({
    Random? random,
    Duration? minimumDelay,
  })  : _random = random ?? Random(),
        _minimumDelay = minimumDelay ?? const Duration(seconds: 2);

  final Random _random;
  final Duration _minimumDelay;

  Future<List<HookOption>> generate({
    required String topic,
    required List<HookStyle> styles,
    required String niche,
    required HookLanguage language,
    String? customStylePrompt,
  }) async {
    final jitter = Duration(milliseconds: _random.nextInt(2000));
    await Future<void>.delayed(_minimumDelay + jitter);

    final normalizedTopic = topic.trim();
    final activeStyles = styles.isEmpty ? [HookStyle.statement] : styles;

    return List<HookOption>.generate(5, (index) {
      final style = activeStyles[index % activeStyles.length];
      final score = 30 + _random.nextInt(66);

      return HookOption(
        id: 'hook_${DateTime.now().microsecondsSinceEpoch}_$index',
        text: _buildHookText(
          topic: normalizedTopic,
          niche: niche,
          style: style,
          language: language,
          customStylePrompt: customStylePrompt,
          index: index,
        ),
        style: style,
        score: score.toDouble(),
      );
    });
  }

  String _buildHookText({
    required String topic,
    required String niche,
    required HookStyle style,
    required HookLanguage language,
    required int index,
    String? customStylePrompt,
  }) {
    final topicLabel = topic.isEmpty ? 'ide video kamu' : topic;
    final customPrompt = customStylePrompt?.trim();
    final customPrefix =
        customPrompt == null || customPrompt.isEmpty ? '' : '$customPrompt: ';

    if (language == HookLanguage.en) {
      return switch (style) {
        HookStyle.question =>
          '${customPrefix}What if $topicLabel is the shortcut your $niche audience has been missing?',
        HookStyle.statement =>
          '${customPrefix}This $niche trick changes how you think about $topicLabel.',
        HookStyle.shock =>
          '${customPrefix}Nobody tells you this about $topicLabel until it is too late.',
        HookStyle.story =>
          '${customPrefix}I tried $topicLabel for ${index + 1} days, and the result surprised me.',
        HookStyle.curiosity =>
          '${customPrefix}The weird reason $topicLabel keeps working is not what you think.',
      };
    }

    if (language == HookLanguage.bilingual) {
      return switch (style) {
        HookStyle.question =>
          '${customPrefix}Pernah kepikiran $topicLabel bisa jadi shortcut? Here is why.',
        HookStyle.statement =>
          '$customPrefix$topicLabel bukan sekadar tren. It is a creator advantage.',
        HookStyle.shock =>
          '${customPrefix}Stop dulu. Kesalahan terbesar di $topicLabel sering tidak terlihat.',
        HookStyle.story =>
          '${customPrefix}Aku coba $topicLabel, and this changed the whole video.',
        HookStyle.curiosity =>
          '${customPrefix}Ada satu detail kecil di $topicLabel yang bikin orang terus nonton.',
      };
    }

    return switch (style) {
      HookStyle.question =>
        '${customPrefix}Bagaimana kalau $topicLabel adalah jalan tercepat untuk audiens $niche?',
      HookStyle.statement =>
        '$customPrefix$topicLabel bisa mengubah cara kamu bikin konten $niche.',
      HookStyle.shock =>
        '${customPrefix}Jangan mulai $topicLabel sebelum tahu satu kesalahan ini.',
      HookStyle.story =>
        '${customPrefix}Aku coba $topicLabel, dan hasilnya jauh di luar dugaan.',
      HookStyle.curiosity =>
        '${customPrefix}Ada alasan tersembunyi kenapa $topicLabel bikin orang berhenti scroll.',
    };
  }
}

enum HookLanguage {
  id('ID'),
  en('EN'),
  bilingual('Bilingual');

  const HookLanguage(this.label);

  final String label;
}
