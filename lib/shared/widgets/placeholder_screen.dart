import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_radius.dart';
import '../../core/theme/app_spacing.dart';
import '../../routing/routes.dart';

class PlaceholderScreen extends StatelessWidget {
  const PlaceholderScreen({
    super.key,
    required this.name,
    this.detail,
  });

  final String name;
  final String? detail;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: AppColors.obsidian,
      appBar: AppBar(
        title: const Text('AutoShort'),
      ),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.xl),
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: AppColors.surface1,
                borderRadius: BorderRadius.circular(AppRadius.lg),
                border: Border.all(color: AppColors.glassWhite),
              ),
              child: Padding(
                padding: const EdgeInsets.all(AppSpacing.xl),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 54,
                      height: 54,
                      decoration: const BoxDecoration(
                        color: AppColors.goldGlow,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.auto_awesome,
                        color: AppColors.gold,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.lg),
                    Text(
                      name,
                      key: Key('placeholder-$name'),
                      textAlign: TextAlign.center,
                      style: textTheme.headlineLarge?.copyWith(
                        color: AppColors.gold,
                      ),
                    ),
                    if (detail != null) ...[
                      const SizedBox(height: AppSpacing.sm),
                      Text(
                        detail!,
                        textAlign: TextAlign.center,
                        style: textTheme.bodySmall,
                      ),
                    ],
                    const SizedBox(height: AppSpacing.xl),
                    OutlinedButton.icon(
                      onPressed: () {
                        if (context.canPop()) {
                          context.pop();
                        } else {
                          context.go(AppRoutes.home);
                        }
                      },
                      icon: const Icon(Icons.arrow_back),
                      label: const Text('Back'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({super.key, this.error});

  final Object? error;

  @override
  Widget build(BuildContext context) {
    return PlaceholderScreen(
      name: 'Error',
      detail: error?.toString() ?? 'Route not found',
    );
  }
}
