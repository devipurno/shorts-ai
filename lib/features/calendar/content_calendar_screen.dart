import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_radius.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_typography.dart';
import '../../shared/models/project.dart';
import '../../shared/repositories/providers.dart';
import '../../shared/widgets/buttons/fab.dart';
import '../../shared/widgets/cards/app_card.dart';
import '../../shared/widgets/feedback/app_loader.dart';
import '../../shared/widgets/feedback/empty_state.dart';
import '../../shared/widgets/feedback/error_state.dart';
import '../../shared/widgets/navigation/app_appbar.dart';
import '../auth/models/user.dart';
import '../auth/providers/current_user_provider.dart';
import 'providers/calendar_provider.dart';
import 'widgets/calendar_event_dot.dart';
import 'widgets/schedule_modal.dart';
import 'widgets/scheduled_post_card.dart';

class ContentCalendarScreen extends ConsumerWidget {
  const ContentCalendarScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedDay = ref.watch(selectedCalendarDayProvider);
    final focusedDay = ref.watch(focusedCalendarDayProvider);
    final viewMode = ref.watch(calendarViewProvider);
    final posts = ref.watch(scheduledPostsProvider(selectedDay));
    final allPosts = ref.watch(scheduledPostStoreProvider);
    final user = ref.watch(currentUserProvider);

    return Scaffold(
      key: const Key('content-calendar-screen'),
      backgroundColor: AppColors.obsidian,
      appBar: AppAppBar(
        title: 'Content Calendar',
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: AppSpacing.sm),
            child: _ViewToggle(
              value: viewMode,
              onChanged: (value) {
                ref.read(calendarViewProvider.notifier).state = value;
              },
            ),
          ),
        ],
      ),
      floatingActionButton: AppFab(
        label: 'Schedule New',
        icon: const Icon(Icons.add_rounded),
        onPressed: () => _openScheduleModal(context, ref, selectedDay, user),
      ),
      body: SafeArea(
        child: RefreshIndicator(
          color: AppColors.gold,
          backgroundColor: AppColors.surface2,
          onRefresh: () async {
            ref.invalidate(scheduledPostsProvider(selectedDay));
          },
          child: ListView(
            key: const Key('content-calendar-list'),
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.lg,
              AppSpacing.md,
              AppSpacing.lg,
              112,
            ),
            children: [
              _TierSummary(user: user, allPosts: allPosts),
              const SizedBox(height: AppSpacing.md),
              AppCard(
                padding: const EdgeInsets.all(AppSpacing.sm),
                child: TableCalendar<ScheduledPost>(
                  firstDay: DateTime.now().subtract(const Duration(days: 365)),
                  lastDay: DateTime.now().add(const Duration(days: 365)),
                  focusedDay: focusedDay,
                  calendarFormat: viewMode.format,
                  availableCalendarFormats: const {
                    CalendarFormat.month: 'Month',
                    CalendarFormat.week: 'Week',
                  },
                  headerStyle: HeaderStyle(
                    titleCentered: true,
                    formatButtonVisible: false,
                    titleTextStyle: AppTypography.headlineSmall,
                    leftChevronIcon: const Icon(
                      Icons.chevron_left_rounded,
                      color: AppColors.gold,
                    ),
                    rightChevronIcon: const Icon(
                      Icons.chevron_right_rounded,
                      color: AppColors.gold,
                    ),
                  ),
                  daysOfWeekStyle: DaysOfWeekStyle(
                    weekdayStyle: AppTypography.labelSmall.copyWith(
                      color: AppColors.textSecondary,
                    ),
                    weekendStyle: AppTypography.labelSmall.copyWith(
                      color: AppColors.goldLight,
                    ),
                  ),
                  calendarStyle: CalendarStyle(
                    outsideDaysVisible: false,
                    markerDecoration: const BoxDecoration(),
                    todayDecoration: BoxDecoration(
                      color: AppColors.goldGlow,
                      borderRadius: BorderRadius.circular(AppRadius.md),
                      border: Border.all(color: AppColors.gold),
                    ),
                    selectedDecoration: BoxDecoration(
                      color: AppColors.gold,
                      borderRadius: BorderRadius.circular(AppRadius.md),
                    ),
                    defaultTextStyle: AppTypography.bodyMedium,
                    weekendTextStyle: AppTypography.bodyMedium.copyWith(
                      color: AppColors.goldLight,
                    ),
                    selectedTextStyle: AppTypography.labelLarge.copyWith(
                      color: AppColors.textInverse,
                    ),
                    todayTextStyle: AppTypography.labelLarge.copyWith(
                      color: AppColors.goldLight,
                    ),
                  ),
                  selectedDayPredicate: (day) {
                    return isSameCalendarDay(selectedDay, day);
                  },
                  eventLoader: (day) => scheduledPostsForDay(allPosts, day),
                  onDaySelected: (selected, focused) {
                    ref.read(selectedCalendarDayProvider.notifier).state =
                        normalizeCalendarDay(selected);
                    ref.read(focusedCalendarDayProvider.notifier).state =
                        normalizeCalendarDay(focused);
                  },
                  onPageChanged: (focused) {
                    ref.read(focusedCalendarDayProvider.notifier).state =
                        normalizeCalendarDay(focused);
                  },
                  calendarBuilders: CalendarBuilders<ScheduledPost>(
                    markerBuilder: (context, day, events) {
                      if (events.isEmpty) {
                        return null;
                      }
                      return Positioned(
                        bottom: 4,
                        child: CalendarEventDot(
                          compact: true,
                          platforms: events.expand((post) => post.platforms),
                        ),
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.xl),
              _SelectedDayHeader(day: selectedDay),
              const SizedBox(height: AppSpacing.md),
              posts.when(
                loading: () => const SizedBox(
                  height: 168,
                  child: Center(child: AppLoader()),
                ),
                error: (error, stackTrace) => ErrorState(
                  title: 'Schedule belum bisa dimuat',
                  message: 'Tarik untuk refresh atau coba lagi nanti.',
                  onRetry: () =>
                      ref.invalidate(scheduledPostsProvider(selectedDay)),
                ),
                data: (items) {
                  if (items.isEmpty) {
                    return EmptyState(
                      title: 'Tidak ada post terjadwal',
                      message: 'Pilih Schedule New untuk mengisi tanggal ini.',
                      icon: Icons.event_available_rounded,
                      ctaLabel: 'Schedule New',
                      onCtaPressed: () =>
                          _openScheduleModal(context, ref, selectedDay, user),
                    );
                  }

                  return SizedBox(
                    height: 144,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: items.length,
                      separatorBuilder: (_, __) =>
                          const SizedBox(width: AppSpacing.md),
                      itemBuilder: (context, index) {
                        final post = items[index];
                        return ScheduledPostCard(
                          post: post,
                          onEdit: () => _openScheduleModal(
                            context,
                            ref,
                            post.scheduledAt,
                            user,
                          ),
                          onDelete: () {
                            ref
                                .read(scheduledPostStoreProvider.notifier)
                                .delete(post.id);
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Schedule dihapus.'),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _openScheduleModal(
    BuildContext context,
    WidgetRef ref,
    DateTime selectedDay,
    User? user,
  ) async {
    final projects = await ref.read(projectRepositoryProvider).getAll(
          userId: user?.id,
        );
    if (!context.mounted) {
      return;
    }

    final payload = await showScheduleModal(
      context,
      projects: _readyProjects(projects),
      initialDate: selectedDay,
      allowMultiplePlatforms: canUseMultipleCalendarPlatforms(
        user?.tier ?? SubscriptionTier.free,
      ),
    );

    if (payload == null || !context.mounted) {
      return;
    }

    try {
      await ref.read(schedulePostMutationProvider)(
        project: payload.project,
        scheduledAt: payload.scheduledAt,
        platforms: payload.platforms,
        caption: payload.caption,
      );
      ref.read(selectedCalendarDayProvider.notifier).state =
          normalizeCalendarDay(payload.scheduledAt);
      ref.read(focusedCalendarDayProvider.notifier).state =
          normalizeCalendarDay(payload.scheduledAt);
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Post berhasil dijadwalkan.')),
        );
      }
    } on StateError catch (error) {
      if (!context.mounted) {
        return;
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(error.message)),
      );
    }
  }

  List<Project> _readyProjects(List<Project> projects) {
    final ready = projects
        .where((project) {
          return project.status == ProjectStatus.ready ||
              project.status == ProjectStatus.published ||
              project.status == ProjectStatus.draft;
        })
        .take(12)
        .toList(growable: false);
    return ready;
  }
}

class _ViewToggle extends StatelessWidget {
  const _ViewToggle({
    required this.value,
    required this.onChanged,
  });

  final CalendarViewMode value;
  final ValueChanged<CalendarViewMode> onChanged;

  @override
  Widget build(BuildContext context) {
    return SegmentedButton<CalendarViewMode>(
      key: const Key('calendar-view-toggle'),
      segments: [
        for (final mode in CalendarViewMode.values)
          ButtonSegment(
            value: mode,
            label: Text(mode.label),
          ),
      ],
      selected: {value},
      onSelectionChanged: (selection) => onChanged(selection.single),
      showSelectedIcon: false,
      style: ButtonStyle(
        visualDensity: VisualDensity.compact,
        textStyle: WidgetStatePropertyAll(AppTypography.labelSmall),
        foregroundColor: WidgetStateProperty.resolveWith((states) {
          return states.contains(WidgetState.selected)
              ? AppColors.textInverse
              : AppColors.gold;
        }),
        backgroundColor: WidgetStateProperty.resolveWith((states) {
          return states.contains(WidgetState.selected)
              ? AppColors.gold
              : AppColors.surface2;
        }),
        side: const WidgetStatePropertyAll(BorderSide(color: AppColors.gold)),
      ),
    );
  }
}

class _TierSummary extends StatelessWidget {
  const _TierSummary({
    required this.user,
    required this.allPosts,
  });

  final User? user;
  final List<ScheduledPost> allPosts;

  @override
  Widget build(BuildContext context) {
    final tier = user?.tier ?? SubscriptionTier.free;
    final thisMonthCount = scheduledCountForMonth(allPosts, DateTime.now());
    final label = calendarTierLimitLabel(tier);
    final multiAccount = canUseMultipleCalendarPlatforms(tier)
        ? 'Multi-account aktif'
        : '1 platform per schedule';

    return AppCard(
      variant: tier == SubscriptionTier.free
          ? AppCardVariant.flat
          : AppCardVariant.premiumGold,
      child: Row(
        children: [
          const Icon(Icons.auto_awesome_rounded, color: AppColors.gold),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Scheduler ${tier.name.toUpperCase()}',
                    style: AppTypography.labelLarge),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  '$thisMonthCount dipakai bulan ini • $label • $multiAccount',
                  style: AppTypography.bodySmall.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SelectedDayHeader extends StatelessWidget {
  const _SelectedDayHeader({required this.day});

  final DateTime day;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text('Scheduled Posts', style: AppTypography.headlineSmall),
        const Spacer(),
        Text(
          DateFormat('EEE, d MMM').format(day),
          style: AppTypography.labelMedium.copyWith(
            color: AppColors.goldLight,
          ),
        ),
      ],
    );
  }
}
