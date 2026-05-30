import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../shared/models/thumbnail.dart';
import '../services/ai_thumbnail_generator.dart';
import '../services/ctr_predictor.dart';

part 'thumbnail_provider.freezed.dart';

final thumbnailEditorProvider =
    StateNotifierProvider.family<ThumbnailNotifier, ThumbnailState, String>(
  (ref, videoId) => ThumbnailNotifier(
    projectId: videoId,
    ctrPredictor: ref.watch(ctrPredictorProvider),
    aiGenerator: ref.watch(aiThumbnailGeneratorProvider),
  ),
);

enum ThumbnailEditorTool {
  frame('Frame Picker'),
  text('Text'),
  sticker('Sticker'),
  color('Color'),
  aiGenerate('AI Generate'),
  ctrPredict('CTR Predict'),
  save('Save');

  const ThumbnailEditorTool(this.label);

  final String label;
}

enum ThumbnailCanvasAspect {
  portrait('9:16', 9 / 16),
  square('1:1', 1);

  const ThumbnailCanvasAspect(this.label, this.ratio);

  final String label;
  final double ratio;
}

enum ThumbnailLayerType { text, sticker }

@freezed
abstract class ThumbnailState with _$ThumbnailState {
  const factory ThumbnailState({
    required String projectId,
    required Thumbnail variantA,
    Thumbnail? variantB,
    @Default(ThumbnailVariant.a) ThumbnailVariant selectedVariant,
    @Default(ThumbnailCanvasData()) ThumbnailCanvasData variantACanvas,
    @Default(ThumbnailCanvasData()) ThumbnailCanvasData variantBCanvas,
    double? ctrPredictionA,
    double? ctrPredictionB,
    @Default(<String>[]) List<String> ctrTips,
    @Default(<AiThumbnailResult>[]) List<AiThumbnailResult> aiResults,
    @Default(false) bool isGeneratingAi,
    @Default(false) bool isPredictingCtr,
    @Default(false) bool isSaved,
  }) = _ThumbnailState;
}

@freezed
abstract class ThumbnailCanvasData with _$ThumbnailCanvasData {
  const factory ThumbnailCanvasData({
    @Default(ThumbnailCanvasAspect.portrait) ThumbnailCanvasAspect aspect,
    @Default('frame_1') String baseFrameId,
    @Default('Frame 1') String baseFrameLabel,
    @Default(<ThumbnailLayer>[]) List<ThumbnailLayer> layers,
    @Default(Color(0x00000000)) Color colorOverlay,
    @Default(0) double overlayOpacity,
    @Default(0) double gradientIndex,
    String? aiImageLabel,
    Uint8List? aiImageBytes,
  }) = _ThumbnailCanvasData;
}

@freezed
abstract class ThumbnailLayer with _$ThumbnailLayer {
  const factory ThumbnailLayer({
    required String id,
    required ThumbnailLayerType type,
    @Default('Headline') String text,
    @Default('🔥') String sticker,
    @Default(Offset(120, 220)) Offset position,
    @Default(1) double scale,
    @Default(0) double rotation,
    @Default(48) double fontSize,
    @Default('Impact') String fontFamily,
    @Default(Color(0xFFFFFFFF)) Color color,
    @Default(Color(0xFF0B0C10)) Color strokeColor,
    @Default(true) bool shadow,
  }) = _ThumbnailLayer;
}

class ThumbnailNotifier extends StateNotifier<ThumbnailState> {
  ThumbnailNotifier({
    required String projectId,
    required CtrPredictor ctrPredictor,
    required AiThumbnailGenerator aiGenerator,
  })  : _ctrPredictor = ctrPredictor,
        _aiGenerator = aiGenerator,
        super(
          ThumbnailState(
            projectId: projectId,
            variantA: Thumbnail(
              id: 'thumbnail-$projectId-a',
              projectId: projectId,
              isVariantA: true,
            ),
          ),
        );

  final CtrPredictor _ctrPredictor;
  final AiThumbnailGenerator _aiGenerator;

  ThumbnailCanvasData get selectedCanvas => _canvasFor(state.selectedVariant);

  void switchVariant(ThumbnailVariant variant) {
    if (variant == ThumbnailVariant.b && state.variantB == null) {
      saveAsVariantB();
    }
    state = state.copyWith(selectedVariant: variant);
  }

  void setAspect(ThumbnailCanvasAspect aspect) {
    _updateCanvas(selectedCanvas.copyWith(aspect: aspect));
  }

  void setBaseFrame(String id, String label) {
    _updateCanvas(
      selectedCanvas.copyWith(baseFrameId: id, baseFrameLabel: label),
    );
  }

  ThumbnailLayer addTextLayer({String text = 'VIRAL MOMENT'}) {
    final layer = ThumbnailLayer(
      id: _newId('text'),
      type: ThumbnailLayerType.text,
      text: text,
      position: const Offset(120, 210),
    );
    _updateCanvas(
        selectedCanvas.copyWith(layers: [...selectedCanvas.layers, layer]));
    return layer;
  }

  ThumbnailLayer addSticker(String sticker) {
    final layer = ThumbnailLayer(
      id: _newId('sticker'),
      type: ThumbnailLayerType.sticker,
      sticker: sticker,
      position: const Offset(220, 340),
      fontSize: 56,
    );
    _updateCanvas(
        selectedCanvas.copyWith(layers: [...selectedCanvas.layers, layer]));
    return layer;
  }

  void updateLayer(ThumbnailLayer layer) {
    final layers = [
      for (final current in selectedCanvas.layers)
        if (current.id == layer.id) layer else current,
    ];
    _updateCanvas(selectedCanvas.copyWith(layers: layers));
  }

  void removeLayer(String id) {
    _updateCanvas(
      selectedCanvas.copyWith(
        layers: selectedCanvas.layers.where((layer) => layer.id != id).toList(),
      ),
    );
  }

  void setColorOverlay(Color color, double opacity) {
    _updateCanvas(
      selectedCanvas.copyWith(
        colorOverlay: color,
        overlayOpacity: opacity.clamp(0, 0.75).toDouble(),
      ),
    );
  }

  void setGradient(double index) {
    _updateCanvas(selectedCanvas.copyWith(gradientIndex: index));
  }

  Future<List<AiThumbnailResult>> generateAI(
    String prompt,
    ThumbnailAiStyle style,
  ) async {
    state = state.copyWith(isGeneratingAi: true);
    final results = await _aiGenerator.generate(prompt: prompt, style: style);
    state = state.copyWith(isGeneratingAi: false, aiResults: results);
    return results;
  }

  void applyAiResult(AiThumbnailResult result) {
    _updateCanvas(
      selectedCanvas.copyWith(
        aiImageBytes: result.pngBytes,
        aiImageLabel: result.label,
      ),
    );
  }

  Future<void> predictCTR() async {
    state = state.copyWith(isPredictingCtr: true);
    final predictionA = await _ctrPredictor.predictCtr(
      state.variantA,
      state.variantACanvas,
    );
    final canvasB =
        state.variantB == null ? state.variantACanvas : state.variantBCanvas;
    final predictionB = await _ctrPredictor.predictCtr(
      state.variantB ?? state.variantA.copyWith(isVariantA: false),
      canvasB,
    );
    state = state.copyWith(
      isPredictingCtr: false,
      ctrPredictionA: predictionA.score,
      ctrPredictionB: predictionB.score,
      ctrTips: predictionA.score >= predictionB.score
          ? predictionA.tips
          : predictionB.tips,
      variantA: state.variantA.copyWith(ctrPrediction: predictionA.score),
      variantB: (state.variantB ?? state.variantA.copyWith(isVariantA: false))
          .copyWith(ctrPrediction: predictionB.score),
    );
  }

  void saveAsVariantB() {
    state = state.copyWith(
      variantB: state.variantB ??
          Thumbnail(
            id: 'thumbnail-${state.projectId}-b',
            projectId: state.projectId,
            isVariantA: false,
            selectedVariant: ThumbnailVariant.b,
          ),
      variantBCanvas:
          state.variantB == null ? state.variantACanvas : state.variantBCanvas,
    );
  }

  void selectFinal(ThumbnailVariant variant) {
    state = state.copyWith(
      selectedVariant: variant,
      isSaved: true,
      variantA: state.variantA.copyWith(selectedVariant: variant),
      variantB: state.variantB?.copyWith(selectedVariant: variant),
    );
  }

  ThumbnailCanvasData _canvasFor(ThumbnailVariant variant) {
    return variant == ThumbnailVariant.a
        ? state.variantACanvas
        : state.variantBCanvas;
  }

  void _updateCanvas(ThumbnailCanvasData canvas) {
    state = state.selectedVariant == ThumbnailVariant.a
        ? state.copyWith(variantACanvas: canvas, isSaved: false)
        : state.copyWith(variantBCanvas: canvas, isSaved: false);
  }

  String _newId(String prefix) {
    return '$prefix-${DateTime.now().microsecondsSinceEpoch}';
  }
}
