import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_typography.dart';
import '../../routing/routes.dart';
import '../../shared/models/script.dart';
import '../../shared/widgets/buttons/app_button.dart';
import '../../shared/widgets/buttons/icon_button.dart';
import '../../shared/widgets/cards/app_card.dart';
import '../../shared/widgets/display/app_chip.dart';
import '../../shared/widgets/inputs/text_input.dart';
import '../../shared/widgets/navigation/app_appbar.dart';
import '../auth/models/user.dart';
import '../auth/providers/current_user_provider.dart';
import 'providers/hook_provider.dart';
import 'services/ai_hook_service.dart';
import 'widgets/favorite_hooks_drawer.dart';
import 'widgets/generate_loading.dart';
import 'widgets/hook_card.dart';

class HookGeneratorScreen extends ConsumerStatefulWidget {
  const HookGeneratorScreen({super.key});

  @override
  ConsumerState<HookGeneratorScreen> createState() =>
      _HookGeneratorScreenState();
}

class _HookGeneratorScreenState extends ConsumerState<HookGeneratorScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  late final TextEditingController _topicController;
  late final TextEditingController _customStyleController;

  @override
  void initState() {
    super.initState();
    final state = ref.read(hookGeneratorProvider);
    _topicController = TextEditingController(text: state.topic);
    _customStyleController =
        TextEditingController(text: state.customStylePrompt);
  }

  @override
  void dispose() {
    _topicController.dispose();
    _customStyleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(hookGeneratorProvider, (previous, next) {
      if (previous?.errorMessage != next.errorMessage &&
          next.errorMessage != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(next.errorMessage!),
            action: next.upgradePromptVisible
                ? SnackBarAction(
                    label: 'Upgrade',
                    onPressed: () => context.go(AppRoutes.pricing),
                  )
                : null,
          ),
        );
      }
    });

    final state = ref.watch(hookGeneratorProvider);
    final notifier = ref.read(hookGeneratorProvider.notifier);
    final user = ref.watch(currentUserProvider);
    final tier = user?.tier ?? SubscriptionTier.free;

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: AppColors.obsidian,
      appBar: AppAppBar(
        title: 'AI Hook Generator',
        actions: [
          AppIconButton(
            tooltip: 'Tutorial',
            icon: const Icon(Icons.help_outline_rounded),
            onPressed: _showTutorial,
          ),
          AppIconButton(
            tooltip: 'Favorite hooks',
            icon: const Icon(Icons.star_rounded),
            onPressed: () => _scaffoldKey.currentState?.openEndDrawer(),
          ),
        ],
      ),
      endDrawer: FavoriteHooksDrawer(
        hooks: state.favoriteHooks,
        onDelete: notifier.deleteFavoriteHook,
        onUse: (hook) => _useHook(hook),
      ),
      body: Stack(
        children: [
          SafeArea(
            child: ListView(
              padding: const EdgeInsets.all(AppSpacing.lg),
              children: [
                _SectionTitle(
                  title: '1. Topic',
                  subtitle: 'Ceritakan angle, masalah, atau insight utama.',
                ),
                AppTextInput(
                  key: const Key('hook-topic-input'),
                  controller: _topicController,
                  hint: 'Ceritakan topik video kamu...',
                  minLines: 3,
                  maxLines: 3,
                  textInputAction: TextInputAction.newline,
                  onChanged: notifier.setTopic,
                ),
                const SizedBox(height: AppSpacing.xl),
                _SectionTitle(
                  title: '2. Style',
                  subtitle:
                      'Pilih sampai 3 style. Free membuka 3 style pertama.',
                ),
                _StyleChipGrid(
                  selected: state.styles,
                  tier: tier,
                  onToggle: notifier.toggleStyle,
                ),
                const SizedBox(height: AppSpacing.xl),
                _SectionTitle(
                  title: '3. Niche',
                  subtitle: 'Auto-fill dari profil, tetap bisa diedit.',
                ),
                _NicheDropdown(
                  value: state.niche,
                  onChanged: notifier.setNiche,
                ),
                const SizedBox(height: AppSpacing.xl),
                _SectionTitle(
                  title: '4. Language',
                  subtitle: 'Pilih bahasa output hook.',
                ),
                _LanguageToggle(
                  value: state.language,
                  onChanged: notifier.setLanguage,
                ),
                if (canUseCustomStyle(tier)) ...[
                  const SizedBox(height: AppSpacing.xl),
                  _SectionTitle(
                    title: 'Custom style prompt',
                    subtitle: 'Premium dan Lifetime bisa arahkan tone hook.',
                  ),
                  AppTextInput(
                    key: const Key('hook-custom-style-input'),
                    controller: _customStyleController,
                    hint: 'Contoh: tajam seperti opening TED Talk...',
                    onChanged: notifier.setCustomStylePrompt,
                  ),
                ],
                const SizedBox(height: AppSpacing.xl),
                _TierLimitCard(
                    tier: tier, generationsToday: state.generationsToday),
                const SizedBox(height: AppSpacing.lg),
                AppButton(
                  key: const Key('hook-generate-button'),
                  label: 'Generate 5 Hook',
                  fullWidth: true,
                  size: AppButtonSize.lg,
                  isLoading: state.isGenerating,
                  icon: const Icon(Icons.auto_awesome_rounded),
                  onPressed: state.isGenerating
                      ? null
                      : () =>
                          ref.read(hookGeneratorProvider.notifier).generate(),
                ),
                if (state.results.isNotEmpty) ...[
                  const SizedBox(height: AppSpacing.xxl),
                  Text('Results', style: AppTypography.headlineMedium),
                  const SizedBox(height: AppSpacing.md),
                  ...state.results.map(
                    (hook) => Padding(
                      key: ValueKey('hook-result-${hook.id}'),
                      padding: const EdgeInsets.only(bottom: AppSpacing.md),
                      child: HookCard(
                        hook: hook,
                        isFavorite: state.favoriteHooks
                            .any((favorite) => favorite.id == hook.id),
                        onCopy: () {
                          notifier.copyHook(hook.id);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Hook disalin.')),
                          );
                        },
                        onUse: () => _useHook(hook),
                        onFavorite: () => notifier.favoriteHook(hook),
                      ),
                    ),
                  ),
                ],
                const SizedBox(height: AppSpacing.huge),
              ],
            ),
          ),
          if (state.isGenerating)
            const Positioned.fill(
              child: GenerateLoading(),
            ),
        ],
      ),
    );
  }

  Future<void> _useHook(HookOption hook) async {
    await ref
        .read(hookGeneratorProvider.notifier)
        .useHook('current_project', hookId: hook.id);
    if (!mounted) {
      return;
    }
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Hook diterapkan ke project mock.')),
    );
  }

  void _showTutorial() {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: AppColors.surface2,
      showDragHandle: true,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(AppSpacing.xl),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Cara pakai', style: AppTypography.headlineMedium),
              const SizedBox(height: AppSpacing.md),
              Text(
                'Isi topik, pilih maksimal 3 style, lalu generate 5 hook. '
                'Simpan favorit untuk compare, atau gunakan hook langsung ke project.',
                style: AppTypography.bodyMedium.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: AppSpacing.lg),
              AppButton(
                label: 'Mengerti',
                fullWidth: true,
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle({
    required this.title,
    required this.subtitle,
  });

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.sm),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: AppTypography.headlineSmall),
          const SizedBox(height: AppSpacing.xs),
          Text(
            subtitle,
            style: AppTypography.bodySmall.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}

class _StyleChipGrid extends StatelessWidget {
  const _StyleChipGrid({
    required this.selected,
    required this.tier,
    required this.onToggle,
  });

  final List<HookStyle> selected;
  final SubscriptionTier tier;
  final ValueChanged<HookStyle> onToggle;

  @override
  Widget build(BuildContext context) {
    final allowed = allowedStylesForTier(tier);

    return Wrap(
      spacing: AppSpacing.sm,
      runSpacing: AppSpacing.sm,
      children: [
        for (final style in HookStyle.values)
          AppChip(
            key: Key('hook-style-${style.name}'),
            label: allowed.contains(style)
                ? hookStyleLabel(style)
                : '${hookStyleLabel(style)} Locked',
            variant: AppChipVariant.selectable,
            selected: selected.contains(style),
            onSelected: (_) => onToggle(style),
          ),
      ],
    );
  }
}

class _NicheDropdown extends StatelessWidget {
  const _NicheDropdown({
    required this.value,
    required this.onChanged,
  });

  final String value;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      initialValue: hookNiches.contains(value) ? value : hookNiches.first,
      dropdownColor: AppColors.surface2,
      decoration: const InputDecoration(labelText: 'Niche'),
      items: [
        for (final niche in hookNiches)
          DropdownMenuItem(
            value: niche,
            child: Text(niche),
          ),
      ],
      onChanged: (value) {
        if (value != null) {
          onChanged(value);
        }
      },
    );
  }
}

class _LanguageToggle extends StatelessWidget {
  const _LanguageToggle({
    required this.value,
    required this.onChanged,
  });

  final HookLanguage value;
  final ValueChanged<HookLanguage> onChanged;

  @override
  Widget build(BuildContext context) {
    return SegmentedButton<HookLanguage>(
      segments: [
        for (final language in HookLanguage.values)
          ButtonSegment<HookLanguage>(
            value: language,
            label: Text(language.label),
          ),
      ],
      selected: {value},
      onSelectionChanged: (selection) => onChanged(selection.single),
      style: ButtonStyle(
        foregroundColor: WidgetStateProperty.resolveWith((states) {
          return states.contains(WidgetState.selected)
              ? AppColors.textInverse
              : AppColors.gold;
        }),
        backgroundColor: WidgetStateProperty.resolveWith((states) {
          return states.contains(WidgetState.selected)
              ? AppColors.gold
              : AppColors.surface1;
        }),
      ),
    );
  }
}

class _TierLimitCard extends StatelessWidget {
  const _TierLimitCard({
    required this.tier,
    required this.generationsToday,
  });

  final SubscriptionTier tier;
  final int generationsToday;

  @override
  Widget build(BuildContext context) {
    final limit = generationLimitForTier(tier);
    final text = limit == null
        ? '${tierLabel(tier)}: unlimited generations'
        : '${tierLabel(tier)}: $generationsToday/$limit generations hari ini';

    return AppCard(
      variant: tier == SubscriptionTier.free
          ? AppCardVariant.flat
          : AppCardVariant.premiumGold,
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Row(
        children: [
          Icon(
            limit == null ? Icons.all_inclusive_rounded : Icons.timer_rounded,
            color: AppColors.gold,
          ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Text(
              text,
              style: AppTypography.labelMedium.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
