import 'dart:typed_data';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image/image.dart' as img;

final aiThumbnailGeneratorProvider = Provider<AiThumbnailGenerator>((ref) {
  return const AiThumbnailGenerator();
});

enum ThumbnailAiStyle {
  cinematic('Cinematic'),
  vibrant('Vibrant'),
  minimal('Minimal'),
  bold('Bold');

  const ThumbnailAiStyle(this.label);

  final String label;
}

class AiThumbnailResult {
  const AiThumbnailResult({
    required this.id,
    required this.label,
    required this.pngBytes,
    required this.style,
  });

  final String id;
  final String label;
  final Uint8List pngBytes;
  final ThumbnailAiStyle style;
}

class AiThumbnailGenerator {
  const AiThumbnailGenerator();

  Future<List<AiThumbnailResult>> generate({
    required String prompt,
    required ThumbnailAiStyle style,
  }) async {
    await Future<void>.delayed(const Duration(milliseconds: 420));
    final safePrompt = prompt.trim().isEmpty ? 'AutoShort thumbnail' : prompt;
    return [
      for (var index = 0; index < 3; index++)
        AiThumbnailResult(
          id: 'ai-${style.name}-$index',
          label: '${style.label} ${index + 1}: $safePrompt',
          style: style,
          pngBytes: _placeholderPng(
            label: style.label,
            prompt: safePrompt,
            seed: index + style.index,
          ),
        ),
    ];
  }

  Uint8List _placeholderPng({
    required String label,
    required String prompt,
    required int seed,
  }) {
    final image = img.Image(width: 540, height: 960);
    final gold = img.ColorRgb8(212, 175, 55);
    final dark = img.ColorRgb8(11 + seed * 12, 12 + seed * 8, 16 + seed * 14);
    for (final pixel in image) {
      final mix = pixel.y / image.height;
      pixel
        ..r = (dark.r * (1 - mix) + gold.r * mix * 0.75).round()
        ..g = (dark.g * (1 - mix) + gold.g * mix * 0.62).round()
        ..b = (dark.b * (1 - mix) + gold.b * mix * 0.45).round();
    }
    img.fillCircle(
      image,
      x: 420 - seed * 42,
      y: 220 + seed * 72,
      radius: 92,
      color: img.ColorRgba8(212, 175, 55, 90),
    );
    img.drawString(
      image,
      label.toUpperCase(),
      font: img.arial24,
      x: 40,
      y: 740,
      color: img.ColorRgb8(255, 255, 255),
    );
    img.drawString(
      image,
      prompt.length > 26 ? '${prompt.substring(0, 26)}...' : prompt,
      font: img.arial14,
      x: 40,
      y: 786,
      color: img.ColorRgb8(245, 245, 247),
    );
    return Uint8List.fromList(img.encodePng(image));
  }
}
