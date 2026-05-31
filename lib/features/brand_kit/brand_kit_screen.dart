import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_typography.dart';
import '../../shared/widgets/buttons/icon_button.dart';
import '../../shared/widgets/cards/app_card.dart';
import '../../shared/widgets/feedback/app_loader.dart';
import '../../shared/widgets/feedback/error_state.dart';
import '../../shared/widgets/navigation/app_appbar.dart';
import '../auth/models/user.dart';
import '../auth/providers/current_user_provider.dart';
import 'providers/brand_kit_provider.dart';
import 'services/palette_service.dart';
import 'widgets/color_picker_card.dart';
import 'widgets/font_picker_dropdown.dart';
import 'widgets/logo_uploader.dart';
import 'widgets/palette_preset_strip.dart';
import 'widgets/video_uploader.dart';

class BrandKitScreen extends ConsumerWidget {
  const BrandKitScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bootstrap = ref.watch(brandKitBootstrapProvider);
    final state = ref.watch(brandKitProvider);
    final notifier = ref.read(brandKitProvider.notifier);
    final tier = ref.watch(currentUserProvider)?.tier ?? SubscriptionTier.free;

    ref.listen(brandKitProvider, (previous, next) {
      if (previous?.errorMessage != next.errorMessage &&
          next.errorMessage != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(next.errorMessage!)),
        );
      }
    });

    return Scaffold(
      key: const Key('brand-kit-screen'),
      backgroundColor: AppColors.obsidian,
      appBar: AppAppBar(
        title: 'Brand Kit',
        actions: [
          AppIconButton(
            tooltip: 'Save',
            icon: state.isSaving
                ? const SizedBox.square(
                    dimension: 18,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : Icon(
                    state.isDirty ? Icons.save_rounded : Icons.check_rounded),
            onPressed: state.isSaving
                ? null
                : () async {
                    await notifier.save();
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Brand kit saved.')),
                      );
                    }
                  },
          ),
        ],
      ),
      body: bootstrap.when(
        loading: () => const Center(child: AppLoader()),
        error: (error, stackTrace) => ErrorState(
          title: 'Brand Kit tidak bisa dibuka',
          message: 'Coba refresh screen ini.',
          onRetry: () => ref.invalidate(brandKitBootstrapProvider),
        ),
        data: (_) => _BrandKitContent(
          state: state,
          tier: tier,
          notifier: notifier,
        ),
      ),
    );
  }
}

class _BrandKitContent extends ConsumerWidget {
  const _BrandKitContent({
    required this.state,
    required this.tier,
    required this.notifier,
  });

  final BrandKitState state;
  final SubscriptionTier tier;
  final BrandKitNotifier notifier;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final palettes = ref.watch(paletteServiceProvider).presets;
    final canEditMark = canEditWatermark(tier);
    final canUseVideo = canUseBrandVideo(tier);

    return ListView(
      padding: const EdgeInsets.all(AppSpacing.lg),
      children: [
        _TierSummary(tier: tier, state: state),
        const SizedBox(height: AppSpacing.md),
        _Section(
          title: 'Logo',
          initiallyExpanded: true,
          child: LogoUploader(
            title: 'Logo asset',
            assetUrl: state.logoUrl,
            onPick: () async => notifier.setLogo(await _pickImagePath()),
            onRemove: () => notifier.setLogo(null),
          ),
        ),
        _Section(
          title: 'Colors',
          child: Column(
            children: [
              ColorPickerCard(
                label: 'Primary',
                color: state.primaryColor,
                onChanged: notifier.setPrimaryColor,
              ),
              const SizedBox(height: AppSpacing.sm),
              ColorPickerCard(
                label: 'Secondary',
                color: state.secondaryColor,
                onChanged: notifier.setSecondaryColor,
              ),
              const SizedBox(height: AppSpacing.sm),
              ColorPickerCard(
                label: 'Accent',
                color: state.accentColor,
                onChanged: notifier.setAccentColor,
              ),
              const SizedBox(height: AppSpacing.lg),
              PalettePresetStrip(
                palettes: palettes,
                selectedName: state.selectedPaletteName,
                onSelected: notifier.setPalette,
              ),
            ],
          ),
        ),
        _Section(
          title: 'Typography',
          child: Column(
            children: [
              FontPickerDropdown(
                label: 'Primary font',
                value: state.primaryFont,
                onChanged: notifier.setPrimaryFont,
              ),
              const SizedBox(height: AppSpacing.md),
              FontPickerDropdown(
                label: 'Secondary font',
                value: state.secondaryFont,
                onChanged: notifier.setSecondaryFont,
              ),
            ],
          ),
        ),
        _Section(
          title: 'Watermark',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              LogoUploader(
                title: canEditMark
                    ? 'Watermark image'
                    : 'Watermark image - wajib aktif untuk Free',
                assetUrl: state.watermarkUrl ?? 'AutoShort default watermark',
                onPick: () async =>
                    notifier.setWatermark(await _pickImagePath()),
                onRemove: () => notifier.setWatermark(null),
                locked: !canEditMark,
              ),
              const SizedBox(height: AppSpacing.lg),
              Text('Position', style: AppTypography.labelLarge),
              const SizedBox(height: AppSpacing.sm),
              _WatermarkGrid(
                selected: state.watermarkPosition,
                locked: !canEditMark,
                onSelected: notifier.setWatermarkPosition,
              ),
              const SizedBox(height: AppSpacing.lg),
              _SliderRow(
                label: 'Opacity',
                value: state.watermarkOpacity,
                locked: !canEditMark,
                onChanged: notifier.setWatermarkOpacity,
              ),
              _SliderRow(
                label: 'Size',
                value: state.watermarkSize,
                locked: !canEditMark,
                onChanged: notifier.setWatermarkSize,
              ),
            ],
          ),
        ),
        _Section(
          title: 'Intro Video',
          child: VideoUploader(
            title: 'Intro Video',
            videoUrl: state.introVideoUrl,
            locked: !canUseVideo,
            onPick: () async => notifier.setIntroVideo(await _pickVideoPath()),
            onRemove: () => notifier.setIntroVideo(null),
          ),
        ),
        _Section(
          title: 'Outro Video',
          child: VideoUploader(
            title: 'Outro Video',
            videoUrl: state.outroVideoUrl,
            locked: !canUseVideo,
            onPick: () async => notifier.setOutroVideo(await _pickVideoPath()),
            onRemove: () => notifier.setOutroVideo(null),
          ),
        ),
        const SizedBox(height: AppSpacing.huge),
      ],
    );
  }
}

class _TierSummary extends StatelessWidget {
  const _TierSummary({
    required this.tier,
    required this.state,
  });

  final SubscriptionTier tier;
  final BrandKitState state;

  @override
  Widget build(BuildContext context) {
    final limit = brandKitLimitForTier(tier);
    final limitText = limit == null
        ? '${tierLabel(tier)}: unlimited brand kits'
        : '${tierLabel(tier)}: ${state.brandKitCount}/$limit brand kit';

    return AppCard(
      variant: tier == SubscriptionTier.free
          ? AppCardVariant.flat
          : AppCardVariant.premiumGold,
      child: Row(
        children: [
          const Icon(Icons.auto_awesome_rounded, color: AppColors.gold),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Text(
              limitText,
              style: AppTypography.labelLarge.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
          ),
          if (state.isDirty)
            Text(
              'Draft',
              style:
                  AppTypography.labelSmall.copyWith(color: AppColors.warning),
            ),
        ],
      ),
    );
  }
}

class _Section extends StatelessWidget {
  const _Section({
    required this.title,
    required this.child,
    this.initiallyExpanded = false,
  });

  final String title;
  final Widget child;
  final bool initiallyExpanded;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.md),
      child: AppCard(
        padding: EdgeInsets.zero,
        child: Theme(
          data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
          child: ExpansionTile(
            initiallyExpanded: initiallyExpanded,
            tilePadding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.lg,
              vertical: AppSpacing.xs,
            ),
            childrenPadding: const EdgeInsets.fromLTRB(
              AppSpacing.lg,
              0,
              AppSpacing.lg,
              AppSpacing.lg,
            ),
            iconColor: AppColors.gold,
            collapsedIconColor: AppColors.gold,
            title: Text(title, style: AppTypography.headlineSmall),
            children: [child],
          ),
        ),
      ),
    );
  }
}

class _WatermarkGrid extends StatelessWidget {
  const _WatermarkGrid({
    required this.selected,
    required this.locked,
    required this.onSelected,
  });

  final WatermarkPosition selected;
  final bool locked;
  final ValueChanged<WatermarkPosition> onSelected;

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 3,
      mainAxisSpacing: AppSpacing.sm,
      crossAxisSpacing: AppSpacing.sm,
      childAspectRatio: 2.4,
      children: [
        for (final position in WatermarkPosition.values)
          OutlinedButton(
            key: Key('watermark-position-${position.value}'),
            onPressed: locked ? null : () => onSelected(position),
            style: OutlinedButton.styleFrom(
              foregroundColor:
                  selected == position ? AppColors.textInverse : AppColors.gold,
              backgroundColor:
                  selected == position ? AppColors.gold : AppColors.surface2,
              side: BorderSide(
                color:
                    selected == position ? AppColors.gold : AppColors.surface3,
              ),
            ),
            child: Text(
              position.label,
              overflow: TextOverflow.ellipsis,
              style: AppTypography.labelSmall,
            ),
          ),
      ],
    );
  }
}

class _SliderRow extends StatelessWidget {
  const _SliderRow({
    required this.label,
    required this.value,
    required this.locked,
    required this.onChanged,
  });

  final String label;
  final double value;
  final bool locked;
  final ValueChanged<double> onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 72,
          child: Text(label, style: AppTypography.labelMedium),
        ),
        Expanded(
          child: Slider(
            value: value,
            min: 0,
            max: 1,
            activeColor: AppColors.gold,
            onChanged: locked ? null : onChanged,
          ),
        ),
        Text(
          '${(value * 100).round()}%',
          style: AppTypography.bodySmall.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }
}

Future<String?> _pickImagePath() async {
  final picker = ImagePicker();
  final image = await picker.pickImage(source: ImageSource.gallery);
  return image?.path;
}

Future<String?> _pickVideoPath() async {
  final result = await FilePicker.pickFiles(
    type: FileType.video,
  );
  return result?.files.single.path;
}
