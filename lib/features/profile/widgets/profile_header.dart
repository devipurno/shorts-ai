import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared/widgets/buttons/app_button.dart';
import '../../../shared/widgets/buttons/icon_button.dart';
import '../../../shared/widgets/display/app_avatar.dart';
import '../../../shared/widgets/display/tier_indicator.dart';
import '../../auth/models/user.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({
    super.key,
    required this.user,
    required this.onEditProfile,
    required this.onUpgrade,
  });

  final User user;
  final VoidCallback onEditProfile;
  final VoidCallback onUpgrade;

  @override
  Widget build(BuildContext context) {
    final name =
        user.name?.trim().isNotEmpty == true ? user.name!.trim() : 'Devi';

    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.only(bottom: AppSpacing.xl),
        child: Column(
          key: const Key('profile-header'),
          children: [
            GestureDetector(
              key: const Key('profile-avatar-picker'),
              onTap: () => ImagePicker().pickImage(source: ImageSource.gallery),
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  AppAvatar(
                    imageUrl: user.avatarUrl,
                    initials: _initials(name),
                    size: 92,
                  ),
                  Positioned(
                    right: -2,
                    bottom: -2,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: AppColors.gold,
                        shape: BoxShape.circle,
                        border: Border.all(color: AppColors.obsidian, width: 3),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(6),
                        child: Icon(
                          Icons.camera_alt_rounded,
                          color: AppColors.textInverse,
                          size: 16,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  child: Text(
                    name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTypography.headlineMedium,
                  ),
                ),
                const SizedBox(width: AppSpacing.xs),
                AppIconButton(
                  key: const Key('profile-inline-edit'),
                  tooltip: 'Edit profile',
                  size: 36,
                  icon: const Icon(Icons.edit_rounded),
                  onPressed: onEditProfile,
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.xs),
            Text(
              user.email,
              style: AppTypography.bodyMedium.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TierIndicator(tier: user.tier),
                if (user.tier == SubscriptionTier.free) ...[
                  const SizedBox(width: AppSpacing.sm),
                  TextButton(
                    key: const Key('profile-upgrade-cta'),
                    onPressed: onUpgrade,
                    child: const Text('Upgrade'),
                  ),
                ],
              ],
            ),
            const SizedBox(height: AppSpacing.lg),
            AppButton(
              key: const Key('profile-edit-button'),
              label: 'Edit Profile',
              variant: AppButtonVariant.secondary,
              icon: const Icon(Icons.person_outline_rounded),
              onPressed: onEditProfile,
            ),
          ],
        ),
      ),
    );
  }

  String _initials(String value) {
    final parts = value
        .trim()
        .split(RegExp(r'\s+'))
        .where((part) => part.isNotEmpty)
        .toList();
    if (parts.isEmpty) {
      return 'AS';
    }
    return parts.take(2).map((part) => part.characters.first).join();
  }
}
