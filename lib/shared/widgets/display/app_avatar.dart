import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';

class AppAvatar extends StatelessWidget {
  const AppAvatar({
    super.key,
    this.imageUrl,
    this.initials,
    this.size = 44,
  });

  final String? imageUrl;
  final String? initials;
  final double size;

  @override
  Widget build(BuildContext context) {
    final hasImage = imageUrl != null && imageUrl!.isNotEmpty;
    return CircleAvatar(
      radius: size / 2,
      backgroundColor: AppColors.surface3,
      foregroundImage: hasImage ? CachedNetworkImageProvider(imageUrl!) : null,
      child: hasImage
          ? null
          : Text(
              (initials == null || initials!.isEmpty ? 'AS' : initials!)
                  .toUpperCase(),
              style: AppTypography.labelLarge.copyWith(color: AppColors.gold),
            ),
    );
  }
}
