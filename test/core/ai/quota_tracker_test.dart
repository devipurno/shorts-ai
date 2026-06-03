import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shorts_ai/core/ai/quota_tracker.dart';
import 'package:shorts_ai/shared/services/preferences_service.dart';

void main() {
  group('QuotaTracker', () {
    late PreferencesService prefs;
    late DateTime Function() clock;

    setUp(() async {
      SharedPreferences.setMockInitialValues({});
      final sp = await SharedPreferences.getInstance();
      prefs = PreferencesService(sp);
      clock = () => DateTime.utc(2026, 6, 3, 10, 0); // 17:00 WIB
    });

    QuotaTracker createTracker({Map<String, int?>? quotas}) {
      return QuotaTracker(
        preferences: prefs,
        now: () => clock(),
        quotas: quotas ?? const {'test_provider': 3, 'unlimited': null},
      );
    }

    test('canUseProvider returns true when under quota', () async {
      final tracker = createTracker();
      expect(await tracker.canUseProvider('test_provider'), isTrue);
    });

    test('canUseProvider returns true for unlimited provider', () async {
      final tracker = createTracker();
      expect(await tracker.canUseProvider('unlimited'), isTrue);
    });

    test('canUseProvider returns true for unknown provider (no quota)',
        () async {
      final tracker = createTracker();
      expect(await tracker.canUseProvider('unknown'), isTrue);
    });

    test('recordUsage increments count and blocks when quota exhausted',
        () async {
      final tracker = createTracker();

      await tracker.recordUsage('test_provider');
      await tracker.recordUsage('test_provider');
      expect(await tracker.canUseProvider('test_provider'), isTrue);

      await tracker.recordUsage('test_provider');
      expect(await tracker.canUseProvider('test_provider'), isFalse);
    });

    test('getRemainingQuota returns correct remaining count', () async {
      final tracker = createTracker();

      expect(await tracker.getRemainingQuota('test_provider'), 3);

      await tracker.recordUsage('test_provider');
      expect(await tracker.getRemainingQuota('test_provider'), 2);

      await tracker.recordUsage('test_provider', amount: 2);
      expect(await tracker.getRemainingQuota('test_provider'), 0);
    });

    test('getRemainingQuota returns null for unlimited provider', () async {
      final tracker = createTracker();
      expect(await tracker.getRemainingQuota('unlimited'), isNull);
    });

    test('getRemainingQuota clamps to zero when over quota', () async {
      final tracker = createTracker();
      await tracker.recordUsage('test_provider', amount: 100);
      expect(await tracker.getRemainingQuota('test_provider'), 0);
    });

    test('resets count on new date (Asia/Bangkok boundary)', () async {
      final tracker = createTracker();
      await tracker.recordUsage('test_provider', amount: 3);
      expect(await tracker.canUseProvider('test_provider'), isFalse);

      // Advance to next day in WIB (UTC+7)
      clock = () => DateTime.utc(2026, 6, 4, 10, 0);
      expect(await tracker.canUseProvider('test_provider'), isTrue);
      expect(await tracker.getRemainingQuota('test_provider'), 3);
    });

    test('persists usage to SharedPreferences and restores', () async {
      final tracker1 = createTracker();
      await tracker1.recordUsage('test_provider', amount: 2);
      expect(await tracker1.getRemainingQuota('test_provider'), 1);

      // Create a new tracker with the same prefs to simulate app restart
      final tracker2 = createTracker();
      expect(await tracker2.getRemainingQuota('test_provider'), 1);
    });

    test('works without preferences (in-memory only)', () async {
      final tracker = QuotaTracker(
        now: clock,
        quotas: const {'test': 5},
      );
      await tracker.recordUsage('test', amount: 3);
      expect(await tracker.getRemainingQuota('test'), 2);
    });

    test('defaultQuotas contains expected providers', () {
      expect(QuotaTracker.defaultQuotas, containsPair('gemini', 1500));
      expect(QuotaTracker.defaultQuotas, containsPair('groq', 6000));
      expect(QuotaTracker.defaultQuotas, containsPair('groq_whisper', 30));
      expect(QuotaTracker.defaultQuotas, containsPair('deepseek', null));
    });
  });
}
