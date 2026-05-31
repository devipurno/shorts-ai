import 'dart:async';

import '../../models/template.dart';
import '../template_repository.dart';
import 'mock_repository_utils.dart';

class MockTemplateRepository implements TemplateRepository {
  MockTemplateRepository({
    MockRepositoryConfig config = const MockRepositoryConfig(),
  }) : _runtime = MockRepositoryRuntime(config) {
    _templates.addAll(_seedTemplates());
  }

  final MockRepositoryRuntime _runtime;
  final _controller = StreamController<void>.broadcast();
  final _templates = <Template>[];

  @override
  Future<List<Template>> getAll() async {
    await _runtime.simulateNetwork();
    return List<Template>.unmodifiable(_templates);
  }

  @override
  Future<Template?> getById(String id) async {
    await _runtime.simulateNetwork();
    return _templates.where((template) => template.id == id).firstOrNull;
  }

  @override
  Future<List<Template>> getByCategory(String category) async {
    await _runtime.simulateNetwork();
    return List<Template>.unmodifiable(
      _templates.where((template) => template.category == category),
    );
  }

  @override
  Stream<List<Template>> watchAll() async* {
    await _runtime.simulateNetwork();
    yield List<Template>.unmodifiable(_templates);
    yield* _controller.stream
        .map((_) => List<Template>.unmodifiable(_templates));
  }

  List<Template> _seedTemplates() {
    return [
      for (var index = 0; index < _templateCatalog.length; index++)
        _templateCatalog[index].toTemplate(index),
    ];
  }
}

class _TemplateSeed {
  const _TemplateSeed({
    required this.name,
    required this.category,
    required this.description,
    required this.duration,
    required this.rating,
    required this.timesUsed,
    required this.difficulty,
    this.tier = TemplateTier.free,
    this.hooks = const ['hook', 'payoff'],
    this.segments = const ['hook', 'body', 'cta'],
    this.transitions = const ['cut', 'zoom'],
    this.music = const ['cinematic-rise'],
  });

  final String name;
  final String category;
  final String description;
  final int duration;
  final double rating;
  final int timesUsed;
  final TemplateDifficulty difficulty;
  final TemplateTier tier;
  final List<String> hooks;
  final List<String> segments;
  final List<String> transitions;
  final List<String> music;

  Template toTemplate(int index) {
    return Template(
      id: 'template_${index + 1}',
      name: name,
      description: description,
      category: category,
      thumbnailUrl:
          'https://picsum.photos/seed/autoshort-template-$index/720/1280',
      previewVideoUrl: 'https://cdn.autoshort.test/templates/$index.mp4',
      structure: TemplateStructure(
        duration: duration,
        hooks: hooks,
        segments: segments,
        transitions: transitions,
        music: music,
      ),
      difficulty: difficulty,
      tier: tier,
      timesUsed: timesUsed,
      rating: rating,
    );
  }
}

const _templateCatalog = <_TemplateSeed>[
  _TemplateSeed(
    name: 'Trending Viral Hook',
    category: 'entertainment',
    description: 'High-retention hook format with fast payoff and CTA.',
    duration: 35,
    rating: 4.9,
    timesUsed: 1800,
    difficulty: TemplateDifficulty.easy,
    hooks: ['shock opener', 'promise', 'save this'],
  ),
  _TemplateSeed(
    name: 'Tech Review Sprint',
    category: 'tech',
    description: 'Clean product review with spec cards and verdict.',
    duration: 50,
    rating: 4.8,
    timesUsed: 1400,
    difficulty: TemplateDifficulty.medium,
    hooks: ['worth it', 'hidden feature', 'quick review'],
    segments: ['hook', 'specs', 'pros', 'cons', 'verdict'],
  ),
  _TemplateSeed(
    name: 'Podcast Split Interview',
    category: 'podcast_split',
    description: 'Two-speaker split layout with active-speaker highlight.',
    duration: 75,
    rating: 4.9,
    timesUsed: 1250,
    difficulty: TemplateDifficulty.advanced,
    tier: TemplateTier.premium,
    hooks: ['hot take', 'debate moment', 'quote pull'],
    segments: ['speaker 1', 'speaker 2', 'banter', 'payoff'],
    transitions: ['split-screen', 'active-speaker-zoom'],
    music: ['calm-conversation'],
  ),
  _TemplateSeed(
    name: 'Lifestyle Day Recap',
    category: 'lifestyle',
    description: 'Daily vlog recap with soft pacing and moment captions.',
    duration: 45,
    rating: 4.5,
    timesUsed: 930,
    difficulty: TemplateDifficulty.easy,
  ),
  _TemplateSeed(
    name: 'Food Recipe Steps',
    category: 'food',
    description: 'Ingredient callouts, recipe steps, and serve reveal.',
    duration: 45,
    rating: 4.6,
    timesUsed: 870,
    difficulty: TemplateDifficulty.easy,
    segments: ['ingredients', 'prep', 'cook', 'serve'],
  ),
  _TemplateSeed(
    name: 'Fitness Form Fix',
    category: 'fitness',
    description: 'Exercise demo with rep counter and form correction.',
    duration: 40,
    rating: 4.4,
    timesUsed: 760,
    difficulty: TemplateDifficulty.easy,
  ),
  _TemplateSeed(
    name: 'Finance Mistake',
    category: 'finance',
    description: 'Personal finance mistake, correction, and simple action.',
    duration: 50,
    rating: 4.7,
    timesUsed: 830,
    difficulty: TemplateDifficulty.medium,
    hooks: ['money mistake', 'avoid this', 'simple fix'],
  ),
  _TemplateSeed(
    name: 'Education Myth Bust',
    category: 'education',
    description: 'Fact-based explanation with diagram-ready beats.',
    duration: 55,
    rating: 4.7,
    timesUsed: 920,
    difficulty: TemplateDifficulty.medium,
    hooks: ['did you know', 'myth bust', 'simple explain'],
  ),
  _TemplateSeed(
    name: 'Entertainment Reaction',
    category: 'entertainment',
    description: 'Quick reaction template with comic timing.',
    duration: 30,
    rating: 4.3,
    timesUsed: 690,
    difficulty: TemplateDifficulty.medium,
    transitions: ['snap-zoom', 'shake'],
  ),
  _TemplateSeed(
    name: 'Podcast Split Dakwah',
    category: 'podcast_split',
    description: 'Podcast split for reflective two-person conversations.',
    duration: 80,
    rating: 4.8,
    timesUsed: 980,
    difficulty: TemplateDifficulty.advanced,
    tier: TemplateTier.premium,
    hooks: ['reminder', 'dialog turn', 'reflection'],
    segments: ['speaker 1', 'speaker 2', 'lesson', 'dua'],
    transitions: ['split-screen', 'soft-fade'],
    music: ['soft-halal'],
  ),
  _TemplateSeed(
    name: 'Lifestyle GRWM',
    category: 'lifestyle',
    description: 'Get-ready-with-me flow with product labels.',
    duration: 42,
    rating: 4.2,
    timesUsed: 510,
    difficulty: TemplateDifficulty.easy,
  ),
  _TemplateSeed(
    name: 'Tech Hidden Feature',
    category: 'tech',
    description: 'One hidden feature, proof, and quick tutorial.',
    duration: 36,
    rating: 4.4,
    timesUsed: 620,
    difficulty: TemplateDifficulty.easy,
  ),
  _TemplateSeed(
    name: 'Food Street Review',
    category: 'food',
    description: 'Street-food review with price, taste, and verdict.',
    duration: 44,
    rating: 4.3,
    timesUsed: 580,
    difficulty: TemplateDifficulty.easy,
  ),
  _TemplateSeed(
    name: 'Fitness Quick Burn',
    category: 'fitness',
    description: 'No-equipment workout for quick engagement.',
    duration: 38,
    rating: 4.5,
    timesUsed: 650,
    difficulty: TemplateDifficulty.easy,
  ),
  _TemplateSeed(
    name: 'Finance Budget Hack',
    category: 'finance',
    description: 'Budget framework with clean number overlays.',
    duration: 48,
    rating: 4.4,
    timesUsed: 740,
    difficulty: TemplateDifficulty.medium,
  ),
  _TemplateSeed(
    name: 'Education Visual Essay',
    category: 'education',
    description: 'Thoughtful explainer with evidence and takeaway.',
    duration: 80,
    rating: 4.6,
    timesUsed: 480,
    difficulty: TemplateDifficulty.advanced,
    tier: TemplateTier.premium,
  ),
  _TemplateSeed(
    name: 'Entertainment Storytime',
    category: 'entertainment',
    description: 'Storytime pacing with conflict and punchline.',
    duration: 60,
    rating: 4.4,
    timesUsed: 790,
    difficulty: TemplateDifficulty.medium,
  ),
  _TemplateSeed(
    name: 'Lifestyle Travel Pin',
    category: 'lifestyle',
    description: 'Location pin, scenic reveal, and save-worthy CTA.',
    duration: 46,
    rating: 4.5,
    timesUsed: 670,
    difficulty: TemplateDifficulty.medium,
  ),
  _TemplateSeed(
    name: 'Tech App Walkthrough',
    category: 'tech',
    description: 'Screen recording walkthrough with numbered captions.',
    duration: 52,
    rating: 4.3,
    timesUsed: 530,
    difficulty: TemplateDifficulty.medium,
  ),
  _TemplateSeed(
    name: 'Food Before After',
    category: 'food',
    description: 'Before, process, and final food reveal.',
    duration: 34,
    rating: 4.2,
    timesUsed: 430,
    difficulty: TemplateDifficulty.easy,
  ),
  _TemplateSeed(
    name: 'Fitness Challenge',
    category: 'fitness',
    description: 'Challenge format with timer and result reveal.',
    duration: 45,
    rating: 4.3,
    timesUsed: 560,
    difficulty: TemplateDifficulty.medium,
  ),
  _TemplateSeed(
    name: 'Finance Sales Funnel',
    category: 'finance',
    description: 'Problem, solution, proof, and CTA for offers.',
    duration: 50,
    rating: 4.5,
    timesUsed: 520,
    difficulty: TemplateDifficulty.advanced,
    tier: TemplateTier.premium,
  ),
  _TemplateSeed(
    name: 'Education Idea Drop',
    category: 'education',
    description: 'Single surprising idea with dramatic reveal.',
    duration: 30,
    rating: 4.7,
    timesUsed: 880,
    difficulty: TemplateDifficulty.medium,
  ),
  _TemplateSeed(
    name: 'Entertainment Hook Stack',
    category: 'entertainment',
    description: 'Three hook variants stacked in the opening seconds.',
    duration: 35,
    rating: 4.8,
    timesUsed: 940,
    difficulty: TemplateDifficulty.advanced,
    tier: TemplateTier.premium,
  ),
  _TemplateSeed(
    name: 'Lifestyle Brand Montage',
    category: 'lifestyle',
    description: 'Premium montage with gold title cards and subtle motion.',
    duration: 55,
    rating: 4.6,
    timesUsed: 610,
    difficulty: TemplateDifficulty.advanced,
  ),
];
