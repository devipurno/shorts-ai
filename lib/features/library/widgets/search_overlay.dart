import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../routing/routes.dart';
import '../../../shared/models/project.dart';
import '../../../shared/widgets/buttons/icon_button.dart';
import '../../../shared/widgets/feedback/empty_state.dart';
import '../../../shared/widgets/feedback/error_state.dart';
import '../../../shared/widgets/inputs/search_input.dart';
import '../providers/library_provider.dart';

class SearchOverlay extends ConsumerStatefulWidget {
  const SearchOverlay({super.key});

  @override
  ConsumerState<SearchOverlay> createState() => _SearchOverlayState();
}

class _SearchOverlayState extends ConsumerState<SearchOverlay> {
  late final TextEditingController _controller;
  final _recentSearches = const ['launch', 'finance', 'tutorial'];

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(
      text: ref.read(librarySearchQueryProvider),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final query = ref.watch(librarySearchQueryProvider).trim();
    final results = ref.watch(libraryProjectsProvider(LibraryTab.all));

    return Scaffold(
      key: const Key('library-search-overlay'),
      backgroundColor: AppColors.obsidian,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  Expanded(
                    child: AppSearchInput(
                      key: const Key('library-search-overlay-input'),
                      controller: _controller,
                      hint: 'Cari project...',
                      onChanged: (value) => ref
                          .read(librarySearchQueryProvider.notifier)
                          .state = value,
                    ),
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  AppIconButton(
                    key: const Key('library-search-close'),
                    tooltip: 'Close search',
                    icon: const Icon(Icons.close_rounded),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.lg),
              if (query.isEmpty) ...[
                Text(
                  'Recent searches',
                  style: AppTypography.labelLarge,
                ),
                const SizedBox(height: AppSpacing.sm),
                Wrap(
                  spacing: AppSpacing.sm,
                  runSpacing: AppSpacing.sm,
                  children: [
                    for (final recent in _recentSearches)
                      ActionChip(
                        label: Text(recent),
                        onPressed: () {
                          _controller.text = recent;
                          ref.read(librarySearchQueryProvider.notifier).state =
                              recent;
                        },
                      ),
                  ],
                ),
              ] else
                Expanded(
                  child: results.when(
                    loading: () => const Center(
                      child: CircularProgressIndicator(color: AppColors.gold),
                    ),
                    error: (error, stackTrace) => const ErrorState(
                      title: 'Search failed.',
                      message: 'Coba ulangi beberapa saat lagi.',
                    ),
                    data: (projects) {
                      if (projects.isEmpty) {
                        return const EmptyState(
                          title: 'Project tidak ditemukan.',
                          message: 'Coba kata kunci lain.',
                          icon: Icons.search_off_rounded,
                        );
                      }

                      return ListView.separated(
                        itemCount: projects.length,
                        separatorBuilder: (context, index) =>
                            const Divider(height: AppSpacing.lg),
                        itemBuilder: (context, index) => _SearchResultTile(
                          project: projects[index],
                          onTap: () {
                            final router = GoRouter.of(context);
                            Navigator.of(context).pop();
                            router.go(AppRoutes.miniEditorPath(
                              projects[index].id,
                            ));
                          },
                        ),
                      );
                    },
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SearchResultTile extends StatelessWidget {
  const _SearchResultTile({
    required this.project,
    required this.onTap,
  });

  final Project project;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      key: Key('library-search-result-${project.id}'),
      onTap: onTap,
      contentPadding: EdgeInsets.zero,
      leading: const CircleAvatar(
        backgroundColor: AppColors.goldGlow,
        child: Icon(Icons.movie_filter_rounded, color: AppColors.gold),
      ),
      title: Text(
        project.title,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: AppTypography.labelLarge,
      ),
      subtitle: Text(
        project.description.isEmpty ? 'No description' : project.description,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: AppTypography.bodySmall.copyWith(
          color: AppColors.textSecondary,
        ),
      ),
      trailing: const Icon(Icons.chevron_right_rounded, color: AppColors.gold),
    );
  }
}
