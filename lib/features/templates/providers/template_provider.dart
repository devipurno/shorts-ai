import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

import '../../../shared/models/project.dart';
import '../../../shared/models/template.dart';
import '../../../shared/repositories/providers.dart';
import '../../auth/models/user.dart';
import '../../auth/providers/current_user_provider.dart';

const templatePageSize = 20;
const templateTrendingThreshold = 1000;
const _fallbackUserId = 'user_1';

final templateCategoryProvider =
    StateProvider<TemplateCategory>((ref) => TemplateCategory.all);

final templateSearchQueryProvider = StateProvider<String>((ref) => '');

final templateListProvider =
    FutureProvider.family<TemplatePage, TemplateFilter>((ref, filter) async {
  final repository = ref.watch(templateRepositoryProvider);
  final templates = await repository.getAll();
  final filtered = applyTemplateFilter(templates, filter);
  final start = filter.page * filter.pageSize;
  final end = (start + filter.pageSize).clamp(0, filtered.length);
  final items = start >= filtered.length
      ? const <Template>[]
      : filtered.sublist(start, end).toList(growable: false);

  return TemplatePage(
    items: items,
    total: filtered.length,
    page: filter.page,
    pageSize: filter.pageSize,
    hasMore: end < filtered.length,
  );
});

final templateDetailProvider = FutureProvider.family<Template?, String>((
  ref,
  templateId,
) {
  return ref.watch(templateRepositoryProvider).getById(templateId);
});

final useTemplateMutationProvider = Provider<UseTemplateMutation>((ref) {
  return UseTemplateMutation(ref);
});

class UseTemplateMutation {
  const UseTemplateMutation(this._ref);

  final Ref _ref;

  Future<String> call(String templateId) async {
    final template =
        await _ref.read(templateRepositoryProvider).getById(templateId);
    if (template == null) {
      throw StateError('Template $templateId not found');
    }

    final now = DateTime.now().toUtc();
    final user = _ref.read(currentUserProvider);
    final project = Project(
      id: 'project_template_${now.microsecondsSinceEpoch}',
      userId: user?.id ?? _fallbackUserId,
      title: '${template.name} Draft',
      description: template.description,
      status: ProjectStatus.draft,
      thumbnailUrl: template.thumbnailUrl,
      duration: template.structure.duration,
      templateId: template.id,
      tags: [
        template.category,
        template.tier.name,
        ...template.structure.hooks.take(2),
      ],
      createdAt: now,
      updatedAt: now,
    );

    final created = await _ref.read(projectRepositoryProvider).create(project);
    return created.id;
  }
}

class TemplateFilter {
  const TemplateFilter({
    required this.category,
    this.query = '',
    this.page = 0,
    this.pageSize = templatePageSize,
  });

  final TemplateCategory category;
  final String query;
  final int page;
  final int pageSize;

  TemplateFilter copyWith({
    TemplateCategory? category,
    String? query,
    int? page,
    int? pageSize,
  }) {
    return TemplateFilter(
      category: category ?? this.category,
      query: query ?? this.query,
      page: page ?? this.page,
      pageSize: pageSize ?? this.pageSize,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is TemplateFilter &&
            other.category == category &&
            other.query == query &&
            other.page == page &&
            other.pageSize == pageSize;
  }

  @override
  int get hashCode => Object.hash(category, query, page, pageSize);
}

class TemplatePage {
  const TemplatePage({
    required this.items,
    required this.total,
    required this.page,
    required this.pageSize,
    required this.hasMore,
  });

  final List<Template> items;
  final int total;
  final int page;
  final int pageSize;
  final bool hasMore;
}

enum TemplateCategory {
  all('All', null),
  trending('Trending', null),
  lifestyle('Lifestyle', 'lifestyle'),
  tech('Tech', 'tech'),
  food('Food', 'food'),
  fitness('Fitness', 'fitness'),
  finance('Finance', 'finance'),
  education('Education', 'education'),
  entertainment('Entertainment', 'entertainment'),
  podcastSplit('Podcast Split', 'podcast_split');

  const TemplateCategory(this.label, this.categoryKey);

  final String label;
  final String? categoryKey;
}

List<Template> applyTemplateFilter(
  List<Template> templates,
  TemplateFilter filter,
) {
  Iterable<Template> result = templates;

  if (filter.category == TemplateCategory.trending) {
    result = result.where(
      (template) => template.timesUsed > templateTrendingThreshold,
    );
  } else if (filter.category.categoryKey != null) {
    result = result.where(
      (template) => template.category == filter.category.categoryKey,
    );
  }

  final query = filter.query.trim().toLowerCase();
  if (query.isNotEmpty) {
    result = result.where((template) {
      final searchable = [
        template.name,
        template.description,
        template.category,
        ...template.structure.hooks,
        ...template.structure.segments,
      ].join(' ').toLowerCase();
      return searchable.contains(query);
    });
  }

  final sorted = result.toList()
    ..sort((a, b) {
      final trending = b.timesUsed.compareTo(a.timesUsed);
      if (filter.category == TemplateCategory.trending && trending != 0) {
        return trending;
      }
      final rating = b.rating.compareTo(a.rating);
      return rating == 0 ? trending : rating;
    });

  return List<Template>.unmodifiable(sorted);
}

bool hasTemplateAccess(User? user, Template template) {
  if (template.tier == TemplateTier.free) {
    return true;
  }

  return switch (user?.tier) {
    SubscriptionTier.premium || SubscriptionTier.lifetime => true,
    _ => false,
  };
}

String templateCategoryLabel(String value) {
  final match = TemplateCategory.values.where((category) {
    return category.categoryKey == value;
  }).firstOrNull;
  if (match != null) {
    return match.label;
  }

  return value
      .split(RegExp(r'[_-]'))
      .where((part) => part.isNotEmpty)
      .map((part) => '${part[0].toUpperCase()}${part.substring(1)}')
      .join(' ');
}
