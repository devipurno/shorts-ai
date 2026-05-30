import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared/widgets/buttons/app_button.dart';
import '../../../shared/widgets/buttons/icon_button.dart';
import '../../../shared/widgets/display/app_avatar.dart';
import '../../../shared/widgets/inputs/text_input.dart';
import '../../auth/models/user.dart';
import '../providers/profile_provider.dart';

Future<EditProfileState?> showEditProfileModal(
  BuildContext context, {
  required User user,
}) {
  return Navigator.of(context).push<EditProfileState>(
    MaterialPageRoute<EditProfileState>(
      fullscreenDialog: true,
      builder: (context) => EditProfileModal(user: user),
    ),
  );
}

class EditProfileModal extends ConsumerStatefulWidget {
  const EditProfileModal({
    super.key,
    required this.user,
  });

  final User user;

  @override
  ConsumerState<EditProfileModal> createState() => _EditProfileModalState();
}

class _EditProfileModalState extends ConsumerState<EditProfileModal> {
  late final TextEditingController _nameController;
  late final TextEditingController _bioController;
  late final TextEditingController _instagramController;
  late final TextEditingController _youtubeController;
  late final TextEditingController _tiktokController;

  @override
  void initState() {
    super.initState();
    final displayName = widget.user.name?.trim().isNotEmpty == true
        ? widget.user.name!.trim()
        : widget.user.email.split('@').first;

    _nameController = TextEditingController(text: displayName);
    _bioController = TextEditingController();
    _instagramController = TextEditingController();
    _youtubeController = TextEditingController();
    _tiktokController = TextEditingController();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(editProfileProvider.notifier).hydrate(
            name: displayName,
            avatarPath: widget.user.avatarUrl,
          );
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _bioController.dispose();
    _instagramController.dispose();
    _youtubeController.dispose();
    _tiktokController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final form = ref.watch(editProfileProvider);
    final notifier = ref.read(editProfileProvider.notifier);

    return Scaffold(
      key: const Key('edit-profile-modal'),
      backgroundColor: AppColors.obsidian,
      appBar: AppBar(
        backgroundColor: AppColors.obsidian,
        surfaceTintColor: Colors.transparent,
        leading: AppIconButton(
          tooltip: 'Close',
          icon: const Icon(Icons.close_rounded),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text('Edit Profile', style: AppTypography.headlineSmall),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(AppSpacing.lg),
          children: [
            Center(
              child: GestureDetector(
                key: const Key('edit-profile-avatar'),
                onTap: () async {
                  final picked = await ImagePicker().pickImage(
                    source: ImageSource.gallery,
                  );
                  if (picked != null) {
                    notifier.setAvatarPath(picked.path);
                  }
                },
                child: AppAvatar(
                  imageUrl: form.avatarPath,
                  initials: _initials(form.name),
                  size: 96,
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.xl),
            AppTextInput(
              key: const Key('edit-profile-name'),
              controller: _nameController,
              label: 'Display name',
              hint: 'Nama kreator',
              onChanged: notifier.setName,
            ),
            const SizedBox(height: AppSpacing.md),
            AppTextInput(
              key: const Key('edit-profile-bio'),
              controller: _bioController,
              label: 'Bio',
              hint: 'Ceritakan gaya konten kamu',
              minLines: 3,
              maxLines: 5,
              onChanged: notifier.setBio,
            ),
            const SizedBox(height: AppSpacing.md),
            AppTextInput(
              key: const Key('edit-profile-instagram'),
              controller: _instagramController,
              label: 'Instagram',
              hint: '@username',
              prefixIcon: const Icon(Icons.alternate_email_rounded),
              onChanged: notifier.setInstagramHandle,
            ),
            const SizedBox(height: AppSpacing.md),
            AppTextInput(
              key: const Key('edit-profile-youtube'),
              controller: _youtubeController,
              label: 'YouTube',
              hint: '@channel',
              prefixIcon: const Icon(Icons.play_circle_outline_rounded),
              onChanged: notifier.setYoutubeHandle,
            ),
            const SizedBox(height: AppSpacing.md),
            AppTextInput(
              key: const Key('edit-profile-tiktok'),
              controller: _tiktokController,
              label: 'TikTok',
              hint: '@username',
              prefixIcon: const Icon(Icons.music_note_rounded),
              onChanged: notifier.setTiktokHandle,
            ),
            const SizedBox(height: AppSpacing.xl),
            AppButton(
              key: const Key('edit-profile-save'),
              label: 'Simpan Profile',
              fullWidth: true,
              onPressed:
                  form.isValid ? () => Navigator.of(context).pop(form) : null,
            ),
          ],
        ),
      ),
    );
  }

  String _initials(String value) {
    final trimmed = value.trim();
    if (trimmed.isEmpty) {
      return 'AS';
    }
    return trimmed
        .split(RegExp(r'\s+'))
        .take(2)
        .map((part) => part.characters.first)
        .join();
  }
}
