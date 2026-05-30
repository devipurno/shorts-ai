import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_radius.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared/models/subtitle.dart';
import '../providers/subtitle_provider.dart';

class StylePreview extends StatelessWidget {
  const StylePreview({
    super.key,
    required this.segment,
    required this.style,
    required this.animation,
    required this.backgroundStyle,
    required this.strokeWidth,
    required this.karaokeColor,
    this.currentPositionMs = 0,
  });

  final SubtitleSegment? segment;
  final SubtitleStyle style;
  final SubtitleAnimationPreset animation;
  final SubtitleBackgroundStyle backgroundStyle;
  final double strokeWidth;
  final String karaokeColor;
  final int currentPositionMs;

  @override
  Widget build(BuildContext context) {
    final text = segment?.text ?? 'AutoShort subtitle preview';
    final alignment = _alignment(style.position);

    return Container(
      key: const Key('subtitle-style-preview'),
      height: 220,
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppRadius.lg),
        gradient: const LinearGradient(
          colors: [AppColors.surface2, AppColors.obsidianDark],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        border: Border.all(color: AppColors.surface3),
      ),
      child: Stack(
        children: [
          const Positioned.fill(
            child: Center(
              child: Icon(
                Icons.movie_filter_rounded,
                color: AppColors.textTertiary,
                size: 48,
              ),
            ),
          ),
          Align(
            alignment: alignment,
            child: _SubtitleText(
              text: text,
              segment: segment,
              currentPositionMs: currentPositionMs,
              style: style,
              animation: animation,
              backgroundStyle: backgroundStyle,
              strokeWidth: strokeWidth,
              karaokeColor: karaokeColor,
            ),
          ),
        ],
      ),
    );
  }

  Alignment _alignment(String position) {
    return switch (position) {
      'top_left' => Alignment.topLeft,
      'top_center' || 'top' => Alignment.topCenter,
      'top_right' => Alignment.topRight,
      'center_left' => Alignment.centerLeft,
      'center' => Alignment.center,
      'center_right' => Alignment.centerRight,
      'bottom_left' => Alignment.bottomLeft,
      'bottom_center' || 'bottom' => Alignment.bottomCenter,
      'bottom_right' => Alignment.bottomRight,
      _ => Alignment.bottomCenter,
    };
  }
}

class _SubtitleText extends StatelessWidget {
  const _SubtitleText({
    required this.text,
    required this.segment,
    required this.currentPositionMs,
    required this.style,
    required this.animation,
    required this.backgroundStyle,
    required this.strokeWidth,
    required this.karaokeColor,
  });

  final String text;
  final SubtitleSegment? segment;
  final int currentPositionMs;
  final SubtitleStyle style;
  final SubtitleAnimationPreset animation;
  final SubtitleBackgroundStyle backgroundStyle;
  final double strokeWidth;
  final String karaokeColor;

  @override
  Widget build(BuildContext context) {
    final fontColor = colorFromHex(style.fontColor);
    final strokeColor = colorFromHex(style.strokeColor);
    final activeColor = colorFromHex(karaokeColor);
    final activeWordIndex = _activeWordIndex(segment, currentPositionMs);
    final baseStyle = TextStyle(
      fontFamily: _fontFamily(style.fontFamily),
      fontSize: style.fontSize.clamp(12, 72),
      fontWeight: FontWeight.w800,
      color: fontColor,
      height: 1.05,
    );

    Widget child = Stack(
      alignment: Alignment.center,
      children: [
        if (strokeWidth > 0)
          Text(
            text,
            textAlign: TextAlign.center,
            style: baseStyle.copyWith(
              foreground: Paint()
                ..style = PaintingStyle.stroke
                ..strokeWidth = strokeWidth
                ..color = strokeColor,
            ),
          ),
        RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            children: _wordSpans(
              baseStyle: baseStyle,
              activeColor: activeColor,
              activeWordIndex: activeWordIndex,
            ),
          ),
        ),
      ],
    );

    child = Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      child: child,
    );

    child = DecoratedBox(
      decoration: _backgroundDecoration(backgroundStyle, activeColor),
      child: child,
    );

    return AnimatedScale(
      scale: animation == SubtitleAnimationPreset.wordPop ? 1.04 : 1,
      duration: const Duration(milliseconds: 260),
      child: child,
    );
  }

  List<InlineSpan> _wordSpans({
    required TextStyle baseStyle,
    required Color activeColor,
    required int activeWordIndex,
  }) {
    final words = segment?.words ?? [];
    if (words.isEmpty) {
      return [TextSpan(text: text, style: baseStyle)];
    }
    return [
      for (var index = 0; index < words.length; index++)
        TextSpan(
          text: '${words[index].text}${index == words.length - 1 ? '' : ' '}',
          style: baseStyle.copyWith(
            color: index == activeWordIndex ? activeColor : baseStyle.color,
            shadows: index == activeWordIndex &&
                    animation == SubtitleAnimationPreset.karaokeGlow
                ? [
                    Shadow(
                      color: activeColor.withValues(alpha: 0.75),
                      blurRadius: 18,
                    ),
                  ]
                : null,
          ),
        ),
    ];
  }

  BoxDecoration _backgroundDecoration(
    SubtitleBackgroundStyle style,
    Color activeColor,
  ) {
    return switch (style) {
      SubtitleBackgroundStyle.none => const BoxDecoration(),
      SubtitleBackgroundStyle.pill => BoxDecoration(
          color: AppColors.glassBlack,
          borderRadius: BorderRadius.circular(AppRadius.pill),
        ),
      SubtitleBackgroundStyle.box => BoxDecoration(
          color: AppColors.glassBlack,
          borderRadius: BorderRadius.circular(AppRadius.md),
          border: Border.all(color: AppColors.glassWhite),
        ),
      SubtitleBackgroundStyle.karaokeHighlight => BoxDecoration(
          color: activeColor.withValues(alpha: 0.14),
          borderRadius: BorderRadius.circular(AppRadius.md),
          border: Border.all(color: activeColor.withValues(alpha: 0.6)),
        ),
    };
  }

  int _activeWordIndex(SubtitleSegment? segment, int currentPositionMs) {
    final words = segment?.words ?? [];
    if (words.isEmpty) {
      return -1;
    }
    final index = words.indexWhere(
      (word) =>
          currentPositionMs >= word.startMs && currentPositionMs <= word.endMs,
    );
    return index == -1 ? 0 : index;
  }

  String? _fontFamily(String value) {
    if (value == 'Roboto Black') {
      return 'Roboto';
    }
    if (value == 'Montserrat Bold') {
      return 'Montserrat';
    }
    return value;
  }
}

Color colorFromHex(String hex) {
  final clean = hex.replaceAll('#', '');
  if (clean.length != 6) {
    return AppColors.textPrimary;
  }
  return Color(int.parse('FF$clean', radix: 16));
}

String colorToHex(Color color) {
  final value = color.toARGB32() & 0xFFFFFF;
  return '#${value.toRadixString(16).padLeft(6, '0').toUpperCase()}';
}

TextStyle previewLabelStyle(Color color) {
  return AppTypography.labelSmall.copyWith(color: color);
}
