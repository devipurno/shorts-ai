import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../core/theme/app_colors.dart';
import '../../../shared/models/brand_kit.dart';
import '../../../shared/repositories/providers.dart';
import '../../../shared/services/providers.dart';
import '../../auth/models/user.dart';
import '../../auth/providers/current_user_provider.dart';
import '../services/palette_service.dart';

part 'brand_kit_provider.freezed.dart';

const brandKitDraftKey = 'brand_kit.draft';
const _fallbackUserId = 'user_1';

final brandKitProvider =
    StateNotifierProvider<BrandKitNotifier, BrandKitState>((ref) {
  return BrandKitNotifier(ref: ref);
});

final brandKitBootstrapProvider = FutureProvider<BrandKitState>((ref) async {
  final notifier = ref.watch(brandKitProvider.notifier);
  await notifier.load();
  return ref.watch(brandKitProvider);
});

@freezed
abstract class BrandKitState with _$BrandKitState {
  const factory BrandKitState({
    String? id,
    @Default(_fallbackUserId) String userId,
    String? logoUrl,
    @Default(AppColors.gold) Color primaryColor,
    @Default(AppColors.obsidian) Color secondaryColor,
    @Default(AppColors.goldLight) Color accentColor,
    @Default('Inter') String primaryFont,
    @Default('JetBrains Mono') String secondaryFont,
    String? watermarkUrl,
    @Default(WatermarkPosition.bottomRight) WatermarkPosition watermarkPosition,
    @Default(0.72) double watermarkOpacity,
    @Default(0.18) double watermarkSize,
    String? introVideoUrl,
    String? outroVideoUrl,
    @Default(false) bool isDirty,
    @Default(false) bool isSaving,
    @Default(false) bool isLoaded,
    @Default(1) int brandKitCount,
    String? selectedPaletteName,
    String? errorMessage,
  }) = _BrandKitState;
}

enum WatermarkPosition {
  topLeft('top_left'),
  topCenter('top_center'),
  topRight('top_right'),
  centerLeft('center_left'),
  center('center'),
  centerRight('center_right'),
  bottomLeft('bottom_left'),
  bottomCenter('bottom_center'),
  bottomRight('bottom_right');

  const WatermarkPosition(this.value);

  final String value;

  String get label {
    return value
        .split('_')
        .map((part) => '${part[0].toUpperCase()}${part.substring(1)}')
        .join(' ');
  }

  static WatermarkPosition fromValue(String value) {
    return WatermarkPosition.values.firstWhere(
      (position) => position.value == value,
      orElse: () => WatermarkPosition.bottomRight,
    );
  }
}

class BrandKitNotifier extends StateNotifier<BrandKitState> {
  BrandKitNotifier({required Ref ref})
      : _ref = ref,
        super(const BrandKitState()) {
    _autoSaveTimer = Timer.periodic(const Duration(seconds: 5), (_) {
      if (state.isDirty) {
        unawaited(_saveDraft());
      }
    });
  }

  final Ref _ref;
  Timer? _autoSaveTimer;

  SubscriptionTier get _tier =>
      _ref.read(currentUserProvider)?.tier ?? SubscriptionTier.free;

  @override
  void dispose() {
    _autoSaveTimer?.cancel();
    super.dispose();
  }

  Future<void> load() async {
    final user = _ref.read(currentUserProvider);
    final userId = user?.id ?? _fallbackUserId;
    final repository = _ref.read(brandKitRepositoryProvider);
    final existing = await repository.getByUserId(userId);
    final draft = await _loadDraft();

    if (draft != null && draft.userId == userId) {
      state = draft.copyWith(isLoaded: true);
      return;
    }

    if (existing != null) {
      state = brandKitStateFromBrandKit(existing).copyWith(isLoaded: true);
      return;
    }

    state = BrandKitState(userId: userId, isLoaded: true);
  }

  void setLogo(String? value) {
    state = state.copyWith(logoUrl: value, isDirty: true);
  }

  void setPrimaryColor(Color value) {
    state = state.copyWith(primaryColor: value, isDirty: true);
  }

  void setSecondaryColor(Color value) {
    state = state.copyWith(secondaryColor: value, isDirty: true);
  }

  void setAccentColor(Color value) {
    state = state.copyWith(accentColor: value, isDirty: true);
  }

  void setPalette(BrandPalette palette) {
    state = state.copyWith(
      primaryColor: palette.primary,
      secondaryColor: palette.secondary,
      accentColor: palette.accent,
      selectedPaletteName: palette.name,
      isDirty: true,
    );
  }

  void setPrimaryFont(String value) {
    state = state.copyWith(primaryFont: value, isDirty: true);
  }

  void setSecondaryFont(String value) {
    state = state.copyWith(secondaryFont: value, isDirty: true);
  }

  void setWatermark(String? value) {
    if (!canEditWatermark(_tier)) {
      state = state.copyWith(
        errorMessage: 'Upgrade Standard untuk edit watermark.',
      );
      return;
    }

    state = state.copyWith(watermarkUrl: value, isDirty: true);
  }

  void setWatermarkPosition(WatermarkPosition value) {
    if (!canEditWatermark(_tier)) {
      state = state.copyWith(
        errorMessage: 'Watermark wajib aktif untuk Free tier.',
      );
      return;
    }

    state = state.copyWith(watermarkPosition: value, isDirty: true);
  }

  void setWatermarkOpacity(double value) {
    if (!canEditWatermark(_tier)) {
      state = state.copyWith(
        errorMessage: 'Watermark opacity terkunci di Free tier.',
      );
      return;
    }

    state = state.copyWith(
      watermarkOpacity: value.clamp(0.2, 1),
      isDirty: true,
    );
  }

  void setWatermarkSize(double value) {
    if (!canEditWatermark(_tier)) {
      state = state.copyWith(
        errorMessage: 'Watermark size terkunci di Free tier.',
      );
      return;
    }

    state =
        state.copyWith(watermarkSize: value.clamp(0.08, 0.4), isDirty: true);
  }

  void setIntroVideo(String? value) {
    if (!canUseBrandVideo(_tier)) {
      state = state.copyWith(
        errorMessage: 'Intro video tersedia untuk Premium dan Lifetime.',
      );
      return;
    }

    state = state.copyWith(introVideoUrl: value, isDirty: true);
  }

  void setOutroVideo(String? value) {
    if (!canUseBrandVideo(_tier)) {
      state = state.copyWith(
        errorMessage: 'Outro video tersedia untuk Premium dan Lifetime.',
      );
      return;
    }

    state = state.copyWith(outroVideoUrl: value, isDirty: true);
  }

  Future<BrandKit> save() async {
    if (!canCreateAnotherBrandKit(_tier, state.brandKitCount)) {
      state = state.copyWith(
        errorMessage: 'Limit brand kit ${tierLabel(_tier)} sudah tercapai.',
      );
      throw StateError(state.errorMessage ?? 'Brand kit limit reached.');
    }

    state = state.copyWith(isSaving: true, errorMessage: null);
    final repository = _ref.read(brandKitRepositoryProvider);
    final brandKit = state.toBrandKit();
    final saved = state.id == null
        ? await repository.create(brandKit)
        : await repository.update(brandKit);

    state = brandKitStateFromBrandKit(saved).copyWith(
      isLoaded: true,
      isDirty: false,
      isSaving: false,
      brandKitCount: state.brandKitCount,
      watermarkOpacity: state.watermarkOpacity,
      watermarkSize: state.watermarkSize,
      selectedPaletteName: state.selectedPaletteName,
    );
    await _clearDraft();
    return saved;
  }

  Future<void> _saveDraft() async {
    final preferences = await _ref.read(preferencesServiceProvider.future);
    await preferences.setString(brandKitDraftKey, jsonEncode(state.toDraft()));
  }

  Future<BrandKitState?> _loadDraft() async {
    final preferences = await _ref.read(preferencesServiceProvider.future);
    final raw = preferences.getString(brandKitDraftKey);
    if (raw == null || raw.isEmpty) {
      return null;
    }

    try {
      final json = jsonDecode(raw) as Map<String, dynamic>;
      return BrandKitStateFromDraft.fromJson(json);
    } catch (_) {
      return null;
    }
  }

  Future<void> _clearDraft() async {
    final preferences = await _ref.read(preferencesServiceProvider.future);
    await preferences.remove(brandKitDraftKey);
  }
}

BrandKitState brandKitStateFromBrandKit(BrandKit brandKit) {
  return BrandKitState(
    id: brandKit.id,
    userId: brandKit.userId,
    logoUrl: brandKit.logoUrl,
    primaryColor: colorFromHex(brandKit.primaryColor),
    secondaryColor: colorFromHex(brandKit.secondaryColor),
    accentColor: colorFromHex(brandKit.accentColor),
    primaryFont: brandKit.primaryFont,
    secondaryFont: brandKit.secondaryFont,
    watermarkUrl: brandKit.watermarkUrl,
    watermarkPosition: WatermarkPosition.fromValue(brandKit.watermarkPosition),
    introVideoUrl: brandKit.introVideoUrl,
    outroVideoUrl: brandKit.outroVideoUrl,
  );
}

extension BrandKitStateMapper on BrandKitState {
  BrandKit toBrandKit() {
    return BrandKit(
      id: id ?? 'brand_${DateTime.now().microsecondsSinceEpoch}',
      userId: userId,
      logoUrl: logoUrl,
      primaryColor: colorToHex(primaryColor),
      secondaryColor: colorToHex(secondaryColor),
      accentColor: colorToHex(accentColor),
      primaryFont: primaryFont,
      secondaryFont: secondaryFont,
      watermarkUrl: watermarkUrl,
      watermarkPosition: watermarkPosition.value,
      introVideoUrl: introVideoUrl,
      outroVideoUrl: outroVideoUrl,
    );
  }

  Map<String, dynamic> toDraft() {
    return {
      'id': id,
      'user_id': userId,
      'logo_url': logoUrl,
      'primary_color': colorToHex(primaryColor),
      'secondary_color': colorToHex(secondaryColor),
      'accent_color': colorToHex(accentColor),
      'primary_font': primaryFont,
      'secondary_font': secondaryFont,
      'watermark_url': watermarkUrl,
      'watermark_position': watermarkPosition.value,
      'watermark_opacity': watermarkOpacity,
      'watermark_size': watermarkSize,
      'intro_video_url': introVideoUrl,
      'outro_video_url': outroVideoUrl,
      'selected_palette_name': selectedPaletteName,
    };
  }
}

class BrandKitStateFromDraft {
  static BrandKitState fromJson(Map<String, dynamic> json) {
    return BrandKitState(
      id: json['id'] as String?,
      userId: json['user_id'] as String? ?? _fallbackUserId,
      logoUrl: json['logo_url'] as String?,
      primaryColor: colorFromHex(json['primary_color'] as String?),
      secondaryColor: colorFromHex(json['secondary_color'] as String?),
      accentColor: colorFromHex(json['accent_color'] as String?),
      primaryFont: json['primary_font'] as String? ?? 'Inter',
      secondaryFont: json['secondary_font'] as String? ?? 'JetBrains Mono',
      watermarkUrl: json['watermark_url'] as String?,
      watermarkPosition: WatermarkPosition.fromValue(
        json['watermark_position'] as String? ?? 'bottom_right',
      ),
      watermarkOpacity: (json['watermark_opacity'] as num?)?.toDouble() ?? 0.72,
      watermarkSize: (json['watermark_size'] as num?)?.toDouble() ?? 0.18,
      introVideoUrl: json['intro_video_url'] as String?,
      outroVideoUrl: json['outro_video_url'] as String?,
      selectedPaletteName: json['selected_palette_name'] as String?,
      isDirty: true,
    );
  }
}

Color colorFromHex(String? value) {
  final normalized = (value ?? '#000000').replaceAll('#', '');
  if (normalized.length != 6) {
    return AppColors.gold;
  }
  return Color(int.parse('FF$normalized', radix: 16));
}

String colorToHex(Color color) {
  final value = color.toARGB32() & 0x00FFFFFF;
  return '#${value.toRadixString(16).padLeft(6, '0').toUpperCase()}';
}

int? brandKitLimitForTier(SubscriptionTier tier) {
  return switch (tier) {
    SubscriptionTier.free => 1,
    SubscriptionTier.standard => 3,
    SubscriptionTier.premium || SubscriptionTier.lifetime => null,
  };
}

bool canEditWatermark(SubscriptionTier tier) {
  return tier != SubscriptionTier.free;
}

bool canUseBrandVideo(SubscriptionTier tier) {
  return tier == SubscriptionTier.premium || tier == SubscriptionTier.lifetime;
}

bool canCreateAnotherBrandKit(SubscriptionTier tier, int existingCount) {
  final limit = brandKitLimitForTier(tier);
  return limit == null || existingCount <= limit;
}

String tierLabel(SubscriptionTier tier) {
  return switch (tier) {
    SubscriptionTier.free => 'Free',
    SubscriptionTier.standard => 'Standard',
    SubscriptionTier.premium => 'Premium',
    SubscriptionTier.lifetime => 'Lifetime',
  };
}
