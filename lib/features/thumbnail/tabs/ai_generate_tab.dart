import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_radius.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared/widgets/buttons/app_button.dart';
import '../../../shared/widgets/cards/app_card.dart';
import '../../../shared/widgets/display/app_chip.dart';
import '../providers/thumbnail_provider.dart';
import '../services/ai_thumbnail_generator.dart';

class AiGenerateTab extends StatefulWidget {
  const AiGenerateTab({
    super.key,
    required this.state,
    required this.notifier,
  });

  final ThumbnailState state;
  final ThumbnailNotifier notifier;

  @override
  State<AiGenerateTab> createState() => _AiGenerateTabState();
}

class _AiGenerateTabState extends State<AiGenerateTab> {
  final _promptController = TextEditingController(
    text: 'Creator shocked by viral moment',
  );
  ThumbnailAiStyle _style = ThumbnailAiStyle.cinematic;

  @override
  void dispose() {
    _promptController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      key: const Key('thumbnail-tab-ai'),
      padding: const EdgeInsets.all(AppSpacing.lg),
      children: [
        TextField(
          key: const Key('thumbnail-ai-prompt'),
          controller: _promptController,
          maxLines: 3,
          decoration: const InputDecoration(labelText: 'Prompt'),
        ),
        const SizedBox(height: AppSpacing.md),
        Wrap(
          spacing: AppSpacing.sm,
          runSpacing: AppSpacing.sm,
          children: [
            for (final style in ThumbnailAiStyle.values)
              AppChip(
                label: style.label,
                variant: AppChipVariant.selectable,
                selected: _style == style,
                onSelected: (_) => setState(() => _style = style),
              ),
          ],
        ),
        const SizedBox(height: AppSpacing.lg),
        AppButton(
          key: const Key('thumbnail-ai-generate'),
          label: 'Generate dengan AI',
          isLoading: widget.state.isGeneratingAi,
          icon: const Icon(Icons.auto_awesome_rounded),
          onPressed: () {
            widget.notifier.generateAI(_promptController.text, _style);
          },
        ),
        const SizedBox(height: AppSpacing.lg),
        if (widget.state.aiResults.isNotEmpty)
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 9 / 16,
              crossAxisSpacing: AppSpacing.sm,
              mainAxisSpacing: AppSpacing.sm,
            ),
            itemCount: widget.state.aiResults.length,
            itemBuilder: (context, index) {
              final result = widget.state.aiResults[index];
              return AppCard(
                padding: EdgeInsets.zero,
                onTap: () => widget.notifier.applyAiResult(result),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(AppRadius.md),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.memory(result.pngBytes, fit: BoxFit.cover),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: ColoredBox(
                          color: AppColors.glassBlack,
                          child: Padding(
                            padding: const EdgeInsets.all(AppSpacing.xs),
                            child: Text(
                              result.label,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: AppTypography.labelSmall,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
      ],
    );
  }
}
