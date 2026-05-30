import 'package:flutter_test/flutter_test.dart';
import 'package:shorts_ai/features/thumbnail/providers/thumbnail_provider.dart';
import 'package:shorts_ai/features/thumbnail/services/ai_thumbnail_generator.dart';
import 'package:shorts_ai/features/thumbnail/services/ctr_predictor.dart';
import 'package:shorts_ai/shared/models/thumbnail.dart';

void main() {
  test('adds, updates, and removes thumbnail layers', () {
    final notifier = _notifier();

    final textLayer = notifier.addTextLayer(text: 'BIG HOOK');
    expect(notifier.state.variantACanvas.layers, hasLength(1));
    expect(notifier.state.variantACanvas.layers.first.text, 'BIG HOOK');

    notifier.updateLayer(
      textLayer.copyWith(
        text: 'NEW HOOK',
        position: const Offset(30, 40),
      ),
    );
    expect(notifier.state.variantACanvas.layers.first.text, 'NEW HOOK');
    expect(notifier.state.variantACanvas.layers.first.position,
        const Offset(30, 40));

    notifier.removeLayer(textLayer.id);
    expect(notifier.state.variantACanvas.layers, isEmpty);
  });

  test('switches A/B variants and preserves separate canvases', () {
    final notifier = _notifier();

    notifier.addTextLayer(text: 'Variant A');
    notifier.switchVariant(ThumbnailVariant.b);
    notifier.addSticker('🔥');

    expect(notifier.state.selectedVariant, ThumbnailVariant.b);
    expect(notifier.state.variantB, isNotNull);
    expect(notifier.state.variantACanvas.layers.first.text, 'Variant A');
    expect(notifier.state.variantBCanvas.layers.last.sticker, '🔥');

    notifier.selectFinal(ThumbnailVariant.b);
    expect(notifier.state.isSaved, isTrue);
    expect(notifier.state.variantA.selectedVariant, ThumbnailVariant.b);
  });

  test('CTR prediction returns valid scores for A and B', () async {
    final notifier = _notifier();
    notifier.addTextLayer(text: 'Viral Hook');
    notifier.switchVariant(ThumbnailVariant.b);
    notifier.addSticker('⚡');

    await notifier.predictCTR();

    expect(notifier.state.ctrPredictionA, inInclusiveRange(0.3, 0.8));
    expect(notifier.state.ctrPredictionB, inInclusiveRange(0.3, 0.8));
    expect(notifier.state.ctrTips, isNotEmpty);
  });

  test('AI generator returns three placeholder PNG options', () async {
    final notifier = _notifier();

    final results = await notifier.generateAI(
      'creator reacts to viral trend',
      ThumbnailAiStyle.bold,
    );

    expect(results, hasLength(3));
    expect(results.first.pngBytes, isNotEmpty);
    notifier.applyAiResult(results.first);
    expect(notifier.state.variantACanvas.aiImageBytes, isNotNull);
  });
}

ThumbnailNotifier _notifier() {
  return ThumbnailNotifier(
    projectId: 'project_1',
    ctrPredictor: const CtrPredictor(),
    aiGenerator: const AiThumbnailGenerator(),
  );
}
