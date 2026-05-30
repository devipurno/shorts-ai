import 'package:flutter_riverpod/legacy.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../shared/models/subtitle.dart';
import '../services/ass_exporter.dart';
import '../services/srt_exporter.dart';
import '../services/vtt_exporter.dart';

part 'subtitle_provider.freezed.dart';

final subtitleStudioProvider =
    StateNotifierProvider.family<SubtitleNotifier, SubtitleState, String>(
  (ref, videoId) => SubtitleNotifier(projectId: videoId),
);

enum SubtitleAnimationPreset {
  none('None'),
  fade('Fade'),
  slideUp('Slide Up'),
  bounce('Bounce'),
  typeOn('Type-On'),
  glitch('Glitch'),
  karaokeGlow('Karaoke Glow'),
  wordPop('Word Pop');

  const SubtitleAnimationPreset(this.label);

  final String label;
}

enum SubtitleBackgroundStyle {
  none('None'),
  pill('Pill'),
  box('Box'),
  karaokeHighlight('Karaoke highlight');

  const SubtitleBackgroundStyle(this.label);

  final String label;
}

@freezed
abstract class SubtitleState with _$SubtitleState {
  const factory SubtitleState({
    required String projectId,
    @Default(<SubtitleSegment>[]) List<SubtitleSegment> segments,
    @Default(SubtitleStyle()) SubtitleStyle style,
    @Default(SubtitleAnimationPreset.karaokeGlow)
    SubtitleAnimationPreset animation,
    @Default(SubtitleFormat.ass) SubtitleFormat format,
    @Default(SubtitleBackgroundStyle.karaokeHighlight)
    SubtitleBackgroundStyle backgroundStyle,
    @Default(3) double strokeWidth,
    @Default('#D4AF37') String karaokeColor,
    @Default(0) int currentPositionMs,
    @Default(0) int selectedSegmentIndex,
    String? exportedContent,
  }) = _SubtitleState;
}

class SubtitleNotifier extends StateNotifier<SubtitleState> {
  SubtitleNotifier({required String projectId})
      : super(
          SubtitleState(
            projectId: projectId,
            segments: _splitTranscript(_starterTranscript),
          ),
        );

  static const int wordsPerSegment = 6;
  static const int wordDurationMs = 420;
  static const int segmentGapMs = 140;

  void addSegment(SubtitleSegment segment) {
    final segments = [...state.segments, segment]
      ..sort((left, right) => left.startMs.compareTo(right.startMs));
    state = state.copyWith(segments: segments);
  }

  void updateSegment(int index, SubtitleSegment segment) {
    if (index < 0 || index >= state.segments.length) {
      return;
    }
    final segments = [...state.segments]..[index] = segment;
    state = state.copyWith(segments: segments);
  }

  void deleteSegment(int index) {
    if (index < 0 || index >= state.segments.length) {
      return;
    }
    final segments = [...state.segments]..removeAt(index);
    state = state.copyWith(
      segments: segments,
      selectedSegmentIndex: segments.isEmpty
          ? 0
          : state.selectedSegmentIndex.clamp(0, segments.length - 1),
    );
  }

  void reorderSegments(int oldIndex, int newIndex) {
    if (oldIndex < 0 || oldIndex >= state.segments.length) {
      return;
    }
    final targetIndex = oldIndex < newIndex ? newIndex - 1 : newIndex;
    if (targetIndex < 0 || targetIndex >= state.segments.length) {
      return;
    }
    final segments = [...state.segments];
    final segment = segments.removeAt(oldIndex);
    segments.insert(targetIndex, segment);
    state =
        state.copyWith(segments: segments, selectedSegmentIndex: targetIndex);
  }

  void selectSegment(int index) {
    if (index < 0 || index >= state.segments.length) {
      return;
    }
    state = state.copyWith(
      selectedSegmentIndex: index,
      currentPositionMs: state.segments[index].startMs,
    );
  }

  void setCurrentPosition(int milliseconds) {
    final currentIndex = state.segments.indexWhere(
      (segment) =>
          milliseconds >= segment.startMs && milliseconds <= segment.endMs,
    );
    state = state.copyWith(
      currentPositionMs: milliseconds,
      selectedSegmentIndex:
          currentIndex == -1 ? state.selectedSegmentIndex : currentIndex,
    );
  }

  void setStyle(SubtitleStyle style) {
    state = state.copyWith(style: style);
  }

  void setAnimation(SubtitleAnimationPreset animation) {
    state = state.copyWith(
      animation: animation,
      style: state.style.copyWith(animation: animation.name),
    );
  }

  void setFormat(SubtitleFormat format) {
    state = state.copyWith(format: format);
  }

  void setBackgroundStyle(SubtitleBackgroundStyle value) {
    state = state.copyWith(backgroundStyle: value);
  }

  void setStrokeWidth(double value) {
    state = state.copyWith(strokeWidth: value.clamp(0, 10).toDouble());
  }

  void setKaraokeColor(String value) {
    state = state.copyWith(karaokeColor: value);
  }

  void setWordTiming({
    required int segmentIndex,
    required int wordIndex,
    required int startMs,
    required int endMs,
  }) {
    if (segmentIndex < 0 || segmentIndex >= state.segments.length) {
      return;
    }
    final segment = state.segments[segmentIndex];
    if (wordIndex < 0 ||
        wordIndex >= segment.words.length ||
        endMs <= startMs) {
      return;
    }
    final words = [...segment.words]..[wordIndex] =
          segment.words[wordIndex].copyWith(
        startMs: startMs,
        endMs: endMs,
      );
    updateSegment(segmentIndex, segment.copyWith(words: words));
  }

  void autoSplitFromTranscript(String transcript) {
    state = state.copyWith(
      segments: _splitTranscript(transcript),
      selectedSegmentIndex: 0,
      currentPositionMs: 0,
    );
  }

  String exportFile() {
    final content = switch (state.format) {
      SubtitleFormat.ass => AssExporter.export(
          segments: state.segments,
          style: state.style,
          strokeWidth: state.strokeWidth,
          karaokeColor: state.karaokeColor,
        ),
      SubtitleFormat.srt => SrtExporter.export(state.segments),
      SubtitleFormat.vtt => VttExporter.export(state.segments),
    };
    state = state.copyWith(exportedContent: content);
    return content;
  }

  static List<SubtitleSegment> _splitTranscript(String transcript) {
    final words = transcript
        .split(RegExp(r'\s+'))
        .map((word) => word.trim())
        .where((word) => word.isNotEmpty)
        .toList();
    final segments = <SubtitleSegment>[];
    var cursorMs = 0;

    for (var index = 0; index < words.length; index += wordsPerSegment) {
      final chunk = words.skip(index).take(wordsPerSegment).toList();
      final startMs = cursorMs;
      final chunkWords = <Word>[];
      for (var wordIndex = 0; wordIndex < chunk.length; wordIndex++) {
        final wordStart = startMs + wordIndex * wordDurationMs;
        chunkWords.add(
          Word(
            text: chunk[wordIndex],
            startMs: wordStart,
            endMs: wordStart + wordDurationMs - 40,
          ),
        );
      }
      final endMs = startMs + chunk.length * wordDurationMs;
      segments.add(
        SubtitleSegment(
          startMs: startMs,
          endMs: endMs,
          text: chunk.join(' '),
          words: chunkWords,
        ),
      );
      cursorMs = endMs + segmentGapMs;
    }

    return segments;
  }
}

const _starterTranscript =
    'Buat shorts viral dalam menit bukan jam dengan AutoShort. '
    'Edit subtitle karaoke premium dan export cepat untuk Reels.';
