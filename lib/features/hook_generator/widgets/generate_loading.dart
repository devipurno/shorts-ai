import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../../core/constants/asset_paths.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_radius.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared/widgets/cards/app_card.dart';

class GenerateLoading extends StatefulWidget {
  const GenerateLoading({super.key});

  @override
  State<GenerateLoading> createState() => _GenerateLoadingState();
}

class _GenerateLoadingState extends State<GenerateLoading> {
  static const _messages = [
    'Analisis topik...',
    'Cari pola viral...',
    'Generate variant...',
  ];

  Timer? _timer;
  int _index = 0;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(milliseconds: 900), (_) {
      if (!mounted) {
        return;
      }
      setState(() => _index = (_index + 1) % _messages.length);
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: AppColors.glassBlack,
      child: Center(
        child: AppCard(
          variant: AppCardVariant.premiumGold,
          padding: const EdgeInsets.all(AppSpacing.xl),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 280),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox.square(
                  dimension: 96,
                  child: Lottie.asset(AssetPaths.splashLoader),
                ),
                const SizedBox(height: AppSpacing.lg),
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 220),
                  child: Text(
                    _messages[_index],
                    key: ValueKey(_messages[_index]),
                    textAlign: TextAlign.center,
                    style: AppTypography.headlineSmall.copyWith(
                      color: AppColors.goldLight,
                    ),
                  ),
                ),
                const SizedBox(height: AppSpacing.sm),
                ClipRRect(
                  borderRadius: BorderRadius.circular(AppRadius.pill),
                  child: const LinearProgressIndicator(
                    minHeight: 5,
                    color: AppColors.gold,
                    backgroundColor: AppColors.surface3,
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
