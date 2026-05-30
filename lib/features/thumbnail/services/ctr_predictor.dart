import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../shared/models/thumbnail.dart';
import '../providers/thumbnail_provider.dart';

final ctrPredictorProvider = Provider<CtrPredictor>((ref) {
  return const CtrPredictor();
});

class CtrPrediction {
  const CtrPrediction({
    required this.score,
    required this.tips,
  });

  final double score;
  final List<String> tips;
}

class CtrPredictor {
  const CtrPredictor();

  Future<CtrPrediction> predictCtr(
    Thumbnail thumbnail,
    ThumbnailCanvasData canvas,
  ) async {
    await Future<void>.delayed(const Duration(milliseconds: 260));

    final textLayers =
        canvas.layers.where((layer) => layer.type == ThumbnailLayerType.text);
    final stickerLayers = canvas.layers
        .where((layer) => layer.type == ThumbnailLayerType.sticker);
    final textBoost = min(textLayers.length, 3) * 0.07;
    final stickerBoost = min(stickerLayers.length, 2) * 0.035;
    final contrastBoost = canvas.overlayOpacity > 0.18 ? 0.08 : 0.02;
    final facePresenceMock = canvas.baseFrameId.hashCode.isEven ? 0.09 : 0.03;
    final aiBoost = canvas.aiImageBytes == null ? 0 : 0.05;
    final variantBoost = thumbnail.isVariantA ? 0.01 : 0.025;
    final score = (0.32 +
            textBoost +
            stickerBoost +
            contrastBoost +
            facePresenceMock +
            aiBoost +
            variantBoost)
        .clamp(0.3, 0.8)
        .toDouble();

    return CtrPrediction(
      score: double.parse(score.toStringAsFixed(2)),
      tips: [
        if (textLayers.isEmpty)
          'Tambahkan headline besar 3-5 kata untuk hook visual.',
        if (canvas.overlayOpacity < 0.18)
          'Naikkan kontras background supaya teks lebih kebaca.',
        if (stickerLayers.isEmpty)
          'Tambahkan satu elemen emosi seperti api, panah, atau ekspresi.',
        'Pertahankan wajah/objek utama dekat rule-of-thirds.',
      ],
    );
  }
}
