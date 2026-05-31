import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_radius.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared/models/project.dart';
import '../../../shared/widgets/buttons/app_button.dart';
import '../../../shared/widgets/cards/app_card.dart';
import '../../../shared/widgets/display/app_chip.dart';
import '../../../shared/widgets/feedback/empty_state.dart';
import '../providers/calendar_provider.dart';

class SchedulePostPayload {
  const SchedulePostPayload({
    required this.project,
    required this.scheduledAt,
    required this.platforms,
    required this.caption,
  });

  final Project project;
  final DateTime scheduledAt;
  final Set<CalendarPlatform> platforms;
  final String caption;
}

Future<SchedulePostPayload?> showScheduleModal(
  BuildContext context, {
  required List<Project> projects,
  required DateTime initialDate,
  required bool allowMultiplePlatforms,
}) {
  return showModalBottomSheet<SchedulePostPayload>(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    backgroundColor: AppColors.obsidian,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(AppRadius.xl)),
    ),
    builder: (context) => ScheduleModal(
      projects: projects,
      initialDate: initialDate,
      allowMultiplePlatforms: allowMultiplePlatforms,
    ),
  );
}

class ScheduleModal extends StatefulWidget {
  const ScheduleModal({
    super.key,
    required this.projects,
    required this.initialDate,
    required this.allowMultiplePlatforms,
  });

  final List<Project> projects;
  final DateTime initialDate;
  final bool allowMultiplePlatforms;

  @override
  State<ScheduleModal> createState() => _ScheduleModalState();
}

class _ScheduleModalState extends State<ScheduleModal> {
  late Project? _selectedProject = widget.projects.firstOrNull;
  late DateTime _selectedDate = normalizeCalendarDay(widget.initialDate);
  TimeOfDay _selectedTime = const TimeOfDay(hour: 9, minute: 0);
  Set<CalendarPlatform> _platforms = const {CalendarPlatform.instagram};
  final _captionController = TextEditingController();

  @override
  void dispose() {
    _captionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      heightFactor: 0.94,
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Text('Schedule New', style: AppTypography.headlineSmall),
                const Spacer(),
                IconButton(
                  tooltip: 'Close',
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close_rounded, color: AppColors.gold),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.md),
            Expanded(
              child: widget.projects.isEmpty
                  ? const EmptyState(
                      title: 'Belum ada project siap dijadwalkan',
                      message:
                          'Buat atau publish project dulu sebelum schedule.',
                    )
                  : ListView(
                      children: [
                        _ProjectSelector(
                          projects: widget.projects,
                          selectedProject: _selectedProject,
                          onSelected: (project) {
                            setState(() {
                              _selectedProject = project;
                              if (_captionController.text.trim().isEmpty) {
                                _captionController.text = project.title;
                              }
                            });
                          },
                        ),
                        const SizedBox(height: AppSpacing.lg),
                        _DateTimeSection(
                          selectedDate: _selectedDate,
                          selectedTime: _selectedTime,
                          onPickDate: _pickDate,
                          onPickTime: _pickTime,
                        ),
                        const SizedBox(height: AppSpacing.lg),
                        _PlatformSection(
                          selected: _platforms,
                          allowMultiple: widget.allowMultiplePlatforms,
                          onChanged: (platforms) {
                            setState(() => _platforms = platforms);
                          },
                        ),
                        const SizedBox(height: AppSpacing.lg),
                        TextField(
                          key: const Key('schedule-caption-field'),
                          controller: _captionController,
                          minLines: 2,
                          maxLines: 4,
                          decoration: const InputDecoration(
                            labelText: 'Caption',
                            hintText: 'Caption pendek untuk post ini',
                          ),
                        ),
                      ],
                    ),
            ),
            const SizedBox(height: AppSpacing.md),
            AppButton(
              key: const Key('schedule-submit-button'),
              label: 'Jadwalkan',
              fullWidth: true,
              icon: const Icon(Icons.calendar_month_rounded),
              onPressed: _selectedProject == null ? null : _submit,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      firstDate: DateTime.now().subtract(const Duration(days: 1)),
      lastDate: DateTime.now().add(const Duration(days: 365)),
      initialDate: _selectedDate,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.dark(
              primary: AppColors.gold,
              surface: AppColors.surface2,
              onSurface: AppColors.textPrimary,
            ),
          ),
          child: child ?? const SizedBox.shrink(),
        );
      },
    );

    if (picked != null) {
      setState(() => _selectedDate = normalizeCalendarDay(picked));
    }
  }

  Future<void> _pickTime() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.dark(
              primary: AppColors.gold,
              surface: AppColors.surface2,
              onSurface: AppColors.textPrimary,
            ),
          ),
          child: child ?? const SizedBox.shrink(),
        );
      },
    );

    if (picked != null) {
      setState(() => _selectedTime = picked);
    }
  }

  void _submit() {
    final scheduledAt = DateTime(
      _selectedDate.year,
      _selectedDate.month,
      _selectedDate.day,
      _selectedTime.hour,
      _selectedTime.minute,
    );

    Navigator.pop(
      context,
      SchedulePostPayload(
        project: _selectedProject!,
        scheduledAt: scheduledAt,
        platforms: _platforms,
        caption: _captionController.text,
      ),
    );
  }
}

class _ProjectSelector extends StatelessWidget {
  const _ProjectSelector({
    required this.projects,
    required this.selectedProject,
    required this.onSelected,
  });

  final List<Project> projects;
  final Project? selectedProject;
  final ValueChanged<Project> onSelected;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Project', style: AppTypography.labelLarge),
        const SizedBox(height: AppSpacing.sm),
        for (final project in projects.take(6))
          _ProjectTile(
            project: project,
            selected: selectedProject?.id == project.id,
            onSelected: onSelected,
          ),
      ],
    );
  }
}

class _ProjectTile extends StatelessWidget {
  const _ProjectTile({
    required this.project,
    required this.selected,
    required this.onSelected,
  });

  final Project project;
  final bool selected;
  final ValueChanged<Project> onSelected;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.sm),
      child: AppCard(
        padding: const EdgeInsets.all(AppSpacing.md),
        onTap: () => onSelected(project),
        child: Row(
          children: [
            Icon(
              selected
                  ? Icons.radio_button_checked_rounded
                  : Icons.radio_button_unchecked_rounded,
              color: selected ? AppColors.gold : AppColors.textSecondary,
            ),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: Text(
                project.title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTypography.labelLarge,
              ),
            ),
            Text(
              '${project.duration}s',
              style: AppTypography.bodySmall.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DateTimeSection extends StatelessWidget {
  const _DateTimeSection({
    required this.selectedDate,
    required this.selectedTime,
    required this.onPickDate,
    required this.onPickTime,
  });

  final DateTime selectedDate;
  final TimeOfDay selectedTime;
  final VoidCallback onPickDate;
  final VoidCallback onPickTime;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Date & Time', style: AppTypography.labelLarge),
        const SizedBox(height: AppSpacing.sm),
        Row(
          children: [
            Expanded(
              child: _PickerCard(
                key: const Key('schedule-date-picker'),
                icon: Icons.event_rounded,
                label: DateFormat('EEE, d MMM yyyy').format(selectedDate),
                onTap: onPickDate,
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: _PickerCard(
                key: const Key('schedule-time-picker'),
                icon: Icons.schedule_rounded,
                label: selectedTime.format(context),
                onTap: onPickTime,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _PlatformSection extends StatelessWidget {
  const _PlatformSection({
    required this.selected,
    required this.allowMultiple,
    required this.onChanged,
  });

  final Set<CalendarPlatform> selected;
  final bool allowMultiple;
  final ValueChanged<Set<CalendarPlatform>> onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text('Platforms', style: AppTypography.labelLarge),
            const Spacer(),
            if (!allowMultiple)
              Text(
                '1 akun',
                style: AppTypography.labelSmall.copyWith(
                  color: AppColors.gold,
                ),
              ),
          ],
        ),
        const SizedBox(height: AppSpacing.sm),
        Wrap(
          spacing: AppSpacing.sm,
          runSpacing: AppSpacing.sm,
          children: [
            for (final platform in CalendarPlatform.values)
              AppChip(
                key: Key('schedule-platform-${platform.name}'),
                label: platform.label,
                variant: AppChipVariant.selectable,
                selected: selected.contains(platform),
                onSelected: (checked) {
                  final next = Set<CalendarPlatform>.from(selected);
                  if (checked) {
                    if (!allowMultiple) {
                      next
                        ..clear()
                        ..add(platform);
                    } else {
                      next.add(platform);
                    }
                  } else if (next.length > 1) {
                    next.remove(platform);
                  }
                  onChanged(Set<CalendarPlatform>.unmodifiable(next));
                },
              ),
          ],
        ),
      ],
    );
  }
}

class _PickerCard extends StatelessWidget {
  const _PickerCard({
    super.key,
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      padding: const EdgeInsets.all(AppSpacing.md),
      onTap: onTap,
      child: Row(
        children: [
          Icon(icon, color: AppColors.gold),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppTypography.labelMedium,
            ),
          ),
        ],
      ),
    );
  }
}
