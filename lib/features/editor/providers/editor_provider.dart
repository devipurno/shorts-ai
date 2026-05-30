import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../shared/models/project.dart';
import '../../../shared/repositories/providers.dart';
import '../../auth/models/user.dart';
import '../services/ffmpeg_service.dart';

part 'editor_provider.freezed.dart';

final editorProjectProvider =
    FutureProvider.family<Project?, String>((ref, videoId) {
  return ref.watch(projectRepositoryProvider).getById(videoId);
});

final editorProvider =
    StateNotifierProvider.family<EditorNotifier, EditorState, String>(
  (ref, videoId) {
    final service = ref.watch(ffmpegServiceProvider);
    return EditorNotifier(videoId: videoId, ffmpegService: service);
  },
);

enum EditorToolTab {
  trim('Trim'),
  split('Split'),
  speed('Speed'),
  music('Music'),
  watermark('Watermark'),
  filter('Filter'),
  export('Export');

  const EditorToolTab(this.label);

  final String label;
}

enum MusicFade { none, fadeIn, fadeOut, fadeInOut }

enum WatermarkType { text, logo }

enum WatermarkPosition {
  topLeft,
  topCenter,
  topRight,
  centerLeft,
  center,
  centerRight,
  bottomLeft,
  bottomCenter,
  bottomRight,
}

enum FilterPreset {
  none('None'),
  cinematic('Cinematic'),
  vibrant('Vibrant'),
  pastel('Pastel'),
  mono('Mono'),
  vintage('Vintage'),
  cool('Cool'),
  warm('Warm');

  const FilterPreset(this.label);

  final String label;
}

enum ExportResolution {
  p720('720p', '1280x720', false),
  p1080('1080p', '1920x1080', false),
  p4k('4K', '3840x2160', true);

  const ExportResolution(this.label, this.size, this.premiumLocked);

  final String label;
  final String size;
  final bool premiumLocked;
}

enum ExportFormat {
  mp4('MP4'),
  mov('MOV');

  const ExportFormat(this.label);

  final String label;
}

@freezed
abstract class EditorState with _$EditorState {
  const factory EditorState({
    required String videoId,
    @Default('') String videoUrl,
    @Default(0) int trimStartMs,
    @Default(60000) int trimEndMs,
    @Default(<int>[]) List<int> splits,
    @Default(1.0) double speed,
    MusicTrack? musicTrack,
    @Default(WatermarkConfig()) WatermarkConfig watermark,
    @Default(FilterPreset.none) FilterPreset filter,
    @Default(ExportConfig()) ExportConfig exportConfig,
    @Default(false) bool isExporting,
    @Default(0) int exportProgress,
    String? outputPath,
    String? errorMessage,
  }) = _EditorState;
}

@freezed
abstract class MusicTrack with _$MusicTrack {
  const factory MusicTrack({
    required String id,
    required String title,
    String? localPath,
    @Default(0.7) double volume,
    @Default(MusicFade.none) MusicFade fade,
  }) = _MusicTrack;
}

@freezed
abstract class WatermarkConfig with _$WatermarkConfig {
  const factory WatermarkConfig({
    @Default(WatermarkType.text) WatermarkType type,
    @Default('AutoShort') String text,
    String? logoPath,
    @Default(WatermarkPosition.bottomRight) WatermarkPosition position,
    @Default(0.72) double opacity,
    @Default(0.18) double size,
    @Default(Color(0xFFFFFFFF)) Color color,
  }) = _WatermarkConfig;
}

@freezed
abstract class ExportConfig with _$ExportConfig {
  const factory ExportConfig({
    @Default(ExportResolution.p1080) ExportResolution resolution,
    @Default(12) int bitrateMbps,
    @Default(ExportFormat.mp4) ExportFormat format,
  }) = _ExportConfig;
}

class EditorNotifier extends StateNotifier<EditorState> {
  EditorNotifier({
    required String videoId,
    required FfmpegService ffmpegService,
  })  : _ffmpegService = ffmpegService,
        super(EditorState(videoId: videoId));

  final FfmpegService _ffmpegService;

  static const minTrimDurationMs = 1000;

  void setVideoUrl(String value) {
    state = state.copyWith(videoUrl: value, errorMessage: null);
  }

  bool setTrim({int? startMs, int? endMs}) {
    final nextStart = startMs ?? state.trimStartMs;
    final nextEnd = endMs ?? state.trimEndMs;
    if (nextStart < 0 || nextEnd - nextStart < minTrimDurationMs) {
      state = state.copyWith(
        errorMessage: 'Trim minimal 1 detik dan start harus sebelum end.',
      );
      return false;
    }

    state = state.copyWith(
      trimStartMs: nextStart,
      trimEndMs: nextEnd,
      splits: state.splits
          .where((split) => split > nextStart && split < nextEnd)
          .toList(),
      errorMessage: null,
    );
    return true;
  }

  bool addSplit(int markerMs) {
    if (markerMs <= state.trimStartMs || markerMs >= state.trimEndMs) {
      state = state.copyWith(errorMessage: 'Split harus berada di area trim.');
      return false;
    }

    final markers = {...state.splits, markerMs}.toList()..sort();
    state = state.copyWith(splits: markers, errorMessage: null);
    return true;
  }

  void removeSplit(int markerMs) {
    state = state.copyWith(
      splits: state.splits.where((split) => split != markerMs).toList(),
      errorMessage: null,
    );
  }

  void setSpeed(double value) {
    state = state.copyWith(
      speed: value.clamp(0.25, 4.0).toDouble(),
      errorMessage: null,
    );
  }

  void setMusic(MusicTrack? track) {
    state = state.copyWith(musicTrack: track, errorMessage: null);
  }

  void setMusicVolume(double value) {
    final current = state.musicTrack;
    if (current == null) {
      return;
    }
    state = state.copyWith(
      musicTrack: current.copyWith(volume: value.clamp(0, 1).toDouble()),
      errorMessage: null,
    );
  }

  void setMusicFade(MusicFade fade) {
    final current = state.musicTrack;
    if (current == null) {
      return;
    }
    state = state.copyWith(
      musicTrack: current.copyWith(fade: fade),
      errorMessage: null,
    );
  }

  void setWatermark(WatermarkConfig value) {
    state = state.copyWith(watermark: value, errorMessage: null);
  }

  void setFilter(FilterPreset value) {
    state = state.copyWith(filter: value, errorMessage: null);
  }

  bool setExportResolution(
    ExportResolution resolution,
    SubscriptionTier tier,
  ) {
    final allowed = !resolution.premiumLocked ||
        tier == SubscriptionTier.premium ||
        tier == SubscriptionTier.lifetime;
    if (!allowed) {
      state = state.copyWith(
        errorMessage: 'Export 4K hanya tersedia untuk Premium.',
      );
      return false;
    }

    state = state.copyWith(
      exportConfig: state.exportConfig.copyWith(resolution: resolution),
      errorMessage: null,
    );
    return true;
  }

  void setExportBitrate(int bitrateMbps) {
    state = state.copyWith(
      exportConfig: state.exportConfig.copyWith(
        bitrateMbps: bitrateMbps.clamp(4, 80),
      ),
      errorMessage: null,
    );
  }

  void setExportFormat(ExportFormat format) {
    state = state.copyWith(
      exportConfig: state.exportConfig.copyWith(format: format),
      errorMessage: null,
    );
  }

  Future<String?> export() async {
    state = state.copyWith(
      isExporting: true,
      exportProgress: 0,
      outputPath: null,
      errorMessage: null,
    );

    try {
      final outputPath = await _ffmpegService.processVideo(
        state,
        onProgress: (progress) {
          state = state.copyWith(exportProgress: progress);
        },
      );
      state = state.copyWith(
        isExporting: false,
        exportProgress: 100,
        outputPath: outputPath,
      );
      return outputPath;
    } catch (error) {
      state = state.copyWith(
        isExporting: false,
        errorMessage: 'Export gagal: $error',
      );
      return null;
    }
  }
}
