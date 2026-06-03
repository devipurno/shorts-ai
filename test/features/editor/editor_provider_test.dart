import 'package:flutter_test/flutter_test.dart';
import 'package:shorts_ai/core/error_reporter.dart';
import 'package:shorts_ai/features/auth/models/user.dart';
import 'package:shorts_ai/features/editor/providers/editor_provider.dart';
import 'package:shorts_ai/features/editor/services/ffmpeg_service.dart';

void main() {
  test('updates trim, split, speed, music, watermark, and filter state', () {
    final notifier = EditorNotifier(
      videoId: 'video_1',
      ffmpegService: FfmpegService(),
      errorReporter: const NoOpErrorReporter(),
    );

    expect(notifier.setTrim(startMs: 1000, endMs: 5000), isTrue);
    expect(notifier.state.trimStartMs, 1000);
    expect(notifier.state.trimEndMs, 5000);

    expect(notifier.addSplit(2500), isTrue);
    notifier.setSpeed(1.5);
    notifier.setMusic(const MusicTrack(id: 'track_1', title: 'Gold Beat'));
    notifier.setMusicVolume(0.42);
    notifier.setMusicFade(MusicFade.fadeInOut);
    notifier.setWatermark(
      const WatermarkConfig(
        text: 'AutoShort Pro',
        position: WatermarkPosition.topRight,
      ),
    );
    notifier.setFilter(FilterPreset.cinematic);

    expect(notifier.state.splits, [2500]);
    expect(notifier.state.speed, 1.5);
    expect(notifier.state.musicTrack?.volume, 0.42);
    expect(notifier.state.musicTrack?.fade, MusicFade.fadeInOut);
    expect(notifier.state.watermark.text, 'AutoShort Pro');
    expect(notifier.state.filter, FilterPreset.cinematic);
  });

  test('rejects invalid trims shorter than one second', () {
    final notifier = EditorNotifier(
      videoId: 'video_1',
      ffmpegService: FfmpegService(),
      errorReporter: const NoOpErrorReporter(),
    );

    final ok = notifier.setTrim(startMs: 5000, endMs: 5500);

    expect(ok, isFalse);
    expect(notifier.state.trimStartMs, 0);
    expect(notifier.state.trimEndMs, 60000);
    expect(notifier.state.errorMessage, contains('Trim minimal 1 detik'));
  });

  test('blocks 4K export for free users and allows premium users', () {
    final notifier = EditorNotifier(
      videoId: 'video_1',
      ffmpegService: FfmpegService(),
      errorReporter: const NoOpErrorReporter(),
    );

    final freeAllowed = notifier.setExportResolution(
      ExportResolution.p4k,
      SubscriptionTier.free,
    );

    expect(freeAllowed, isFalse);
    expect(notifier.state.exportConfig.resolution, ExportResolution.p1080);
    expect(notifier.state.errorMessage, contains('Premium'));

    final premiumAllowed = notifier.setExportResolution(
      ExportResolution.p4k,
      SubscriptionTier.premium,
    );

    expect(premiumAllowed, isTrue);
    expect(notifier.state.exportConfig.resolution, ExportResolution.p4k);
  });

  test('export emits a mock output path and completes progress', () async {
    final notifier = EditorNotifier(
      videoId: 'video_1',
      ffmpegService: FfmpegService(),
      errorReporter: const NoOpErrorReporter(),
    );

    final output = await notifier.export();

    expect(output, contains('mock_exports'));
    expect(notifier.state.isExporting, isFalse);
    expect(notifier.state.exportProgress, 100);
    expect(notifier.state.outputPath, output);
  });
}
