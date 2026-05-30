import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared/widgets/display/app_avatar.dart';
import '../../../shared/widgets/display/tier_indicator.dart';
import '../../auth/models/user.dart';

class GreetingHeader extends StatelessWidget {
  const GreetingHeader({
    super.key,
    required this.name,
    required this.tier,
    required this.hasUnreadNotifications,
    this.avatarUrl,
    this.now,
    this.onProfileTap,
    this.onNotificationsTap,
  });

  final String name;
  final SubscriptionTier tier;
  final bool hasUnreadNotifications;
  final String? avatarUrl;
  final DateTime? now;
  final VoidCallback? onProfileTap;
  final VoidCallback? onNotificationsTap;

  @override
  Widget build(BuildContext context) {
    final firstName = name.trim().isEmpty ? 'Creator' : name.trim();

    return Row(
      children: [
        InkWell(
          key: const Key('home-profile-avatar'),
          onTap: onProfileTap,
          customBorder: const CircleBorder(),
          child: AppAvatar(
            imageUrl: avatarUrl,
            initials: _initials(firstName),
            size: 46,
          ),
        ),
        const SizedBox(width: AppSpacing.md),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '${greetingFor(now ?? DateTime.now())}, $firstName',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTypography.headlineSmall,
              ),
              const SizedBox(height: AppSpacing.xs),
              TierIndicator(tier: tier),
            ],
          ),
        ),
        const SizedBox(width: AppSpacing.sm),
        Stack(
          clipBehavior: Clip.none,
          children: [
            IconButton(
              key: const Key('home-notifications'),
              onPressed: onNotificationsTap,
              tooltip: 'Notifications',
              color: AppColors.textPrimary,
              icon: const Icon(Icons.notifications_none_rounded),
            ),
            if (hasUnreadNotifications)
              Positioned(
                top: 10,
                right: 10,
                child: Container(
                  width: 9,
                  height: 9,
                  decoration: BoxDecoration(
                    color: AppColors.error,
                    borderRadius: BorderRadius.circular(999),
                    border: Border.all(color: AppColors.obsidian, width: 1.5),
                  ),
                ),
              ),
          ],
        ),
      ],
    );
  }

  static String greetingFor(DateTime time) {
    final hour = time.hour;
    if (hour <= 11) {
      return 'Selamat pagi';
    }
    if (hour <= 15) {
      return 'Selamat siang';
    }
    if (hour <= 18) {
      return 'Selamat sore';
    }
    return 'Selamat malam';
  }

  String _initials(String value) {
    final parts = value
        .split(RegExp(r'\s+'))
        .where((part) => part.trim().isNotEmpty)
        .toList();
    if (parts.isEmpty) {
      return 'AS';
    }
    if (parts.length == 1) {
      return parts.first.characters.first;
    }
    return '${parts.first.characters.first}${parts.last.characters.first}';
  }
}
