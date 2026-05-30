import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/editor_provider.dart';

final ffmpegServiceProvider = Provider<FfmpegService>((ref) {
  final service = FfmpegService();
  ref.onDispose(service.dispose);
  return service;
});

class FfmpegService {
  final _progressController = StreamController<int>.broadcast();
  bool _cancelled = false;

  Stream<int> get progressStream => _progressController.stream;

  String buildCommand(
    EditorState state, {
    String inputPath = 'input.mp4',
    String outputPath = 'output.mp4',
  }) {
    final start = (state.trimStartMs / 1000).toStringAsFixed(3);
    final end = (state.trimEndMs / 1000).toStringAsFixed(3);
    final filters = <String>[];

    if (state.speed != 1) {
      filters.add('setpts=${(1 / state.speed).toStringAsFixed(3)}*PTS');
    }
    if (state.filter != FilterPreset.none) {
      filters.add(_filterExpression(state.filter));
    }

    final args = <String>[
      '-y',
      '-ss $start',
      '-to $end',
      '-i "$inputPath"',
      if (filters.isNotEmpty) '-vf "${filters.join(',')}"',
      if (state.speed != 1) '-af "atempo=${_safeAtempo(state.speed)}"',
      '-b:v ${state.exportConfig.bitrateMbps}M',
      '-s ${state.exportConfig.resolution.size}',
      '-c:v libx264',
      '-c:a aac',
      '"$outputPath"',
    ];

    return args.join(' ');
  }

  Future<String> processVideo(
    EditorState state, {
    void Function(int progress)? onProgress,
  }) async {
    _cancelled = false;
    for (final progress in [0, 8, 18, 35, 52, 68, 84, 96, 100]) {
      if (_cancelled) {
        throw StateError('Export cancelled');
      }
      _progressController.add(progress);
      onProgress?.call(progress);
      await Future<void>.delayed(const Duration(milliseconds: 90));
    }

    final extension =
        state.exportConfig.format == ExportFormat.mp4 ? 'mp4' : 'mov';
    return 'mock_exports/${state.videoId}_${state.exportConfig.resolution.label.toLowerCase()}.$extension';
  }

  void cancel() {
    _cancelled = true;
  }

  void dispose() {
    _progressController.close();
  }

  String _safeAtempo(double speed) {
    final clamped = speed.clamp(0.5, 2.0).toDouble();
    return clamped.toStringAsFixed(2);
  }

  String _filterExpression(FilterPreset preset) {
    return switch (preset) {
      FilterPreset.none => '',
      FilterPreset.cinematic => 'eq=contrast=1.15:saturation=0.92',
      FilterPreset.vibrant => 'eq=saturation=1.35:contrast=1.05',
      FilterPreset.pastel => 'eq=saturation=0.82:brightness=0.04',
      FilterPreset.mono => 'hue=s=0',
      FilterPreset.vintage =>
        'colorchannelmixer=.9:.1:.1:0:.05:.85:.1:0:.05:.1:.75',
      FilterPreset.cool => 'eq=gamma_b=1.15:saturation=1.05',
      FilterPreset.warm => 'eq=gamma_r=1.12:saturation=1.1',
    };
  }
}
