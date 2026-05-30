import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../providers/thumbnail_provider.dart';

class StickerLayerWidget extends StatelessWidget {
  const StickerLayerWidget({
    super.key,
    required this.layer,
    required this.onChanged,
  });

  final ThumbnailLayer layer;
  final ValueChanged<ThumbnailLayer> onChanged;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: layer.position.dx,
      top: layer.position.dy,
      child: GestureDetector(
        onPanUpdate: (details) {
          onChanged(layer.copyWith(position: layer.position + details.delta));
        },
        child: Transform.rotate(
          angle: layer.rotation,
          child: Transform.scale(
            scale: layer.scale,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Text(
                  layer.sticker,
                  style: TextStyle(
                    fontSize: layer.fontSize,
                    shadows: const [
                      Shadow(
                        color: Colors.black87,
                        blurRadius: 12,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  right: -16,
                  bottom: -16,
                  child: GestureDetector(
                    onPanUpdate: (details) {
                      onChanged(
                        layer.copyWith(
                          scale: (layer.scale + details.delta.dx / 160)
                              .clamp(0.4, 3),
                        ),
                      );
                    },
                    child: Container(
                      width: 24,
                      height: 24,
                      decoration: const BoxDecoration(
                        color: AppColors.gold,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.open_in_full_rounded,
                        color: AppColors.textInverse,
                        size: 14,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
