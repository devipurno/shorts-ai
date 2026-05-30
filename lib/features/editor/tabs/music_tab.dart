import 'package:audioplayers/audioplayers.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared/widgets/buttons/app_button.dart';
import '../../../shared/widgets/display/app_chip.dart';
import '../providers/editor_provider.dart';

class MusicTab extends StatefulWidget {
  const MusicTab({
    super.key,
    required this.state,
    required this.notifier,
  });

  final EditorState state;
  final EditorNotifier notifier;

  @override
  State<MusicTab> createState() => _MusicTabState();
}

class _MusicTabState extends State<MusicTab> {
  final _player = AudioPlayer();

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final selected = widget.state.musicTrack;

    return ListView(
      key: const Key('editor-tab-music'),
      padding: const EdgeInsets.all(AppSpacing.lg),
      children: [
        Text('Music bed', style: AppTypography.headlineSmall),
        const SizedBox(height: AppSpacing.md),
        for (final track in _mockTracks)
          _MusicTrackTile(
            track: track,
            selected: selected?.id == track.id,
            onTap: () => widget.notifier.setMusic(track),
          ),
        const SizedBox(height: AppSpacing.md),
        AppButton(
          key: const Key('music-upload-button'),
          label: 'Upload Music',
          icon: const Icon(Icons.upload_file_rounded),
          variant: AppButtonVariant.secondary,
          onPressed: () async {
            final result = await FilePicker.pickFiles(
              type: FileType.audio,
            );
            final path = result?.files.single.path;
            if (path != null) {
              widget.notifier.setMusic(
                MusicTrack(
                  id: 'upload-${DateTime.now().microsecondsSinceEpoch}',
                  title: result!.files.single.name,
                  localPath: path,
                ),
              );
            }
          },
        ),
        if (selected != null) ...[
          const SizedBox(height: AppSpacing.lg),
          Text('Volume', style: AppTypography.labelLarge),
          Slider(
            min: 0,
            max: 1,
            value: selected.volume,
            onChanged: (value) async {
              widget.notifier.setMusicVolume(value);
              await _player.setVolume(value);
            },
          ),
          const SizedBox(height: AppSpacing.md),
          Text('Fade', style: AppTypography.labelLarge),
          Wrap(
            spacing: AppSpacing.sm,
            runSpacing: AppSpacing.sm,
            children: [
              for (final fade in MusicFade.values)
                AppChip(
                  label: _fadeLabel(fade),
                  variant: AppChipVariant.selectable,
                  selected: selected.fade == fade,
                  onSelected: (_) => widget.notifier.setMusicFade(fade),
                ),
            ],
          ),
          if (selected.localPath != null) ...[
            const SizedBox(height: AppSpacing.md),
            Text(
              'Local file ready for preview.',
              style: AppTypography.bodySmall.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ],
      ],
    );
  }

  String _fadeLabel(MusicFade fade) {
    return switch (fade) {
      MusicFade.none => 'None',
      MusicFade.fadeIn => 'Fade in',
      MusicFade.fadeOut => 'Fade out',
      MusicFade.fadeInOut => 'In + Out',
    };
  }
}

const _mockTracks = [
  MusicTrack(id: 'future-pop', title: 'Future Pop'),
  MusicTrack(id: 'cinematic-rise', title: 'Cinematic Rise'),
  MusicTrack(id: 'lofi-gold', title: 'Lo-fi Gold'),
];

class _MusicTrackTile extends StatelessWidget {
  const _MusicTrackTile({
    required this.track,
    required this.selected,
    required this.onTap,
  });

  final MusicTrack track;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.sm),
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(AppSpacing.md),
          decoration: BoxDecoration(
            color: selected ? AppColors.goldGlow : AppColors.surface1,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: selected ? AppColors.gold : AppColors.surface3,
            ),
          ),
          child: Row(
            children: [
              Icon(
                selected
                    ? Icons.radio_button_checked_rounded
                    : Icons.radio_button_unchecked_rounded,
                color: selected ? AppColors.gold : AppColors.textTertiary,
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(track.title, style: AppTypography.labelLarge),
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                      'AutoShort library',
                      style: AppTypography.bodySmall.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(
                Icons.graphic_eq_rounded,
                color: AppColors.textTertiary,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
