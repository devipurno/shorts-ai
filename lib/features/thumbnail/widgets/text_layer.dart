import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../providers/thumbnail_provider.dart';

class TextLayerWidget extends StatelessWidget {
  const TextLayerWidget({
    super.key,
    required this.layer,
    required this.onChanged,
    required this.onEditRequested,
  });

  final ThumbnailLayer layer;
  final ValueChanged<ThumbnailLayer> onChanged;
  final VoidCallback onEditRequested;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: layer.position.dx,
      top: layer.position.dy,
      child: GestureDetector(
        onPanUpdate: (details) {
          onChanged(layer.copyWith(position: layer.position + details.delta));
        },
        onDoubleTap: onEditRequested,
        child: Transform.rotate(
          angle: layer.rotation,
          child: Transform.scale(
            scale: layer.scale,
            alignment: Alignment.center,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Text(
                  layer.text,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: layer.fontFamily,
                    fontSize: layer.fontSize,
                    fontWeight: FontWeight.w900,
                    foreground: Paint()
                      ..style = PaintingStyle.stroke
                      ..strokeWidth = 4
                      ..color = layer.strokeColor,
                  ),
                ),
                Text(
                  layer.text,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: layer.fontFamily,
                    fontSize: layer.fontSize,
                    fontWeight: FontWeight.w900,
                    color: layer.color,
                    shadows: layer.shadow
                        ? const [
                            Shadow(
                              color: Colors.black87,
                              offset: Offset(0, 3),
                              blurRadius: 8,
                            ),
                          ]
                        : null,
                  ),
                ),
                _Handle(
                  alignment: Alignment.topRight,
                  icon: Icons.rotate_right_rounded,
                  onDrag: (delta) {
                    onChanged(layer.copyWith(
                        rotation: layer.rotation + delta.dx / 120));
                  },
                ),
                _Handle(
                  alignment: Alignment.bottomRight,
                  icon: Icons.open_in_full_rounded,
                  onDrag: (delta) {
                    onChanged(
                      layer.copyWith(
                        scale: (layer.scale + delta.dx / 180).clamp(0.35, 2.4),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Handle extends StatelessWidget {
  const _Handle({
    required this.alignment,
    required this.icon,
    required this.onDrag,
  });

  final Alignment alignment;
  final IconData icon;
  final ValueChanged<Offset> onDrag;

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Align(
        alignment: alignment,
        child: GestureDetector(
          onPanUpdate: (details) => onDrag(details.delta),
          child: Container(
            width: 24,
            height: 24,
            decoration: const BoxDecoration(
              color: AppColors.gold,
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: AppColors.textInverse, size: 14),
          ),
        ),
      ),
    );
  }
}
