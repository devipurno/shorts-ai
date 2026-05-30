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
    return List<Template>.generate(_templateCatalog.length, (index) {
      final item = _templateCatalog[index];
      final premium = index >= 15;
      return Template(
        id: 'template_${index + 1}',
        name: item.name,
        description: item.description,
        category: item.category,
        thumbnailUrl: 'https://picsum.photos/seed/template-$index/640/960',
        previewVideoUrl: 'https://cdn.autoshort.test/templates/$index.mp4',
        structure: TemplateStructure(
          duration: item.duration,
          hooks: item.hooks,
          segments: item.segments,
          transitions: item.transitions,
          music: item.music,
        ),
        difficulty: item.difficulty,
        tier: premium ? TemplateTier.premium : TemplateTier.free,
        timesUsed: item.timesUsed,
        rating: item.rating,
      );
    });
  }
}

class _TemplateSeed {
  const _TemplateSeed({
    required this.name,
    required this.description,
    required this.category,
    required this.duration,
    required this.hooks,
    required this.segments,
    required this.transitions,
    required this.music,
    required this.difficulty,
    required this.timesUsed,
    required this.rating,
  });

  final String name;
  final String description;
  final String category;
  final int duration;
  final List<String> hooks;
  final List<String> segments;
  final List<String> transitions;
  final List<String> music;
  final TemplateDifficulty difficulty;
  final int timesUsed;
  final double rating;
}

const _templateCatalog = <_TemplateSeed>[
  _TemplateSeed(
    name: 'General Hook',
    description: 'Universal hook, payoff, and CTA format for quick shorts.',
    category: 'general',
    duration: 35,
    hooks: ['question', 'shock stat', 'direct promise'],
    segments: ['hook', 'context', 'payoff', 'cta'],
    transitions: ['cut', 'zoom', 'caption-pop'],
    music: ['cinematic-rise'],
    difficulty: TemplateDifficulty.easy,
    timesUsed: 18400,
    rating: 4.7,
  ),
  _TemplateSeed(
    name: 'Tutorial How-To',
    description: 'Step-by-step teaching format with numbered overlays.',
    category: 'education',
    duration: 45,
    hooks: ['problem', 'quick win', 'numbered promise'],
    segments: ['problem', 'step 1', 'step 2', 'result'],
    transitions: ['number-pop', 'jump-cut'],
    music: ['clean-focus'],
    difficulty: TemplateDifficulty.easy,
    timesUsed: 12600,
    rating: 4.6,
  ),
  _TemplateSeed(
    name: 'Listicle Top 5',
    description: 'Fast ranked list format with punchy counter overlays.',
    category: 'listicle',
    duration: 50,
    hooks: ['top five', 'avoid mistake', 'save this'],
    segments: ['intro', 'rank 5', 'rank 4', 'rank 3', 'rank 2', 'rank 1'],
    transitions: ['counter-flip', 'swipe'],
    music: ['upbeat-list'],
    difficulty: TemplateDifficulty.easy,
    timesUsed: 9900,
    rating: 4.5,
  ),
  _TemplateSeed(
    name: 'Quote Motivational',
    description: 'Dramatic quote-focused template for inspirational clips.',
    category: 'motivation',
    duration: 25,
    hooks: ['quote', 'hard truth', 'identity shift'],
    segments: ['quote', 'meaning', 'action'],
    transitions: ['slow-zoom', 'fade'],
    music: ['emotional-pulse'],
    difficulty: TemplateDifficulty.easy,
    timesUsed: 8100,
    rating: 4.4,
  ),
  _TemplateSeed(
    name: 'Story Curhat',
    description: 'First-person narrative with dramatic pacing and reveal.',
    category: 'story',
    duration: 60,
    hooks: ['confession', 'mistake', 'turning point'],
    segments: ['setup', 'conflict', 'reveal', 'lesson'],
    transitions: ['beat-cut', 'push-in'],
    music: ['soft-drama'],
    difficulty: TemplateDifficulty.medium,
    timesUsed: 7600,
    rating: 4.6,
  ),
  _TemplateSeed(
    name: 'Edukasi Knowledge',
    description: 'Fact-based educational flow with diagram-ready segments.',
    category: 'education',
    duration: 55,
    hooks: ['did you know', 'myth bust', 'simple explain'],
    segments: ['fact', 'example', 'why it matters', 'recap'],
    transitions: ['diagram-pop', 'cut'],
    music: ['study-light'],
    difficulty: TemplateDifficulty.medium,
    timesUsed: 9100,
    rating: 4.7,
  ),
  _TemplateSeed(
    name: 'Komedi Reaction',
    description: 'Reaction format with quick cuts and comic punch timing.',
    category: 'reaction',
    duration: 30,
    hooks: ['wait for it', 'reaction', 'unexpected'],
    segments: ['setup', 'reaction', 'punchline'],
    transitions: ['snap-zoom', 'shake'],
    music: ['comic-hit'],
    difficulty: TemplateDifficulty.medium,
    timesUsed: 6900,
    rating: 4.3,
  ),
  _TemplateSeed(
    name: 'News Berita',
    description: 'Urgent news bar and ticker structure for timely content.',
    category: 'news',
    duration: 35,
    hooks: ['breaking', 'what changed', 'impact'],
    segments: ['headline', 'context', 'impact', 'next'],
    transitions: ['ticker', 'hard-cut'],
    music: ['urgent-bed'],
    difficulty: TemplateDifficulty.medium,
    timesUsed: 6200,
    rating: 4.2,
  ),
  _TemplateSeed(
    name: 'Gaming Highlight',
    description: 'Gameplay highlight with score overlay and commentary beats.',
    category: 'gaming',
    duration: 40,
    hooks: ['clutch moment', 'boss fight', 'skill check'],
    segments: ['setup', 'peak action', 'reaction', 'replay'],
    transitions: ['flash', 'replay-freeze'],
    music: ['high-energy'],
    difficulty: TemplateDifficulty.medium,
    timesUsed: 8500,
    rating: 4.5,
  ),
  _TemplateSeed(
    name: 'Cooking Steps',
    description: 'Recipe steps, ingredient callouts, and appetizing pacing.',
    category: 'food',
    duration: 45,
    hooks: ['3 ingredients', 'quick recipe', 'taste reveal'],
    segments: ['ingredients', 'prep', 'cook', 'serve'],
    transitions: ['wipe', 'ingredient-pop'],
    music: ['warm-kitchen'],
    difficulty: TemplateDifficulty.easy,
    timesUsed: 5700,
    rating: 4.4,
  ),
  _TemplateSeed(
    name: 'Beauty Skincare',
    description: 'Before-after split and product label structure.',
    category: 'beauty',
    duration: 35,
    hooks: ['before after', 'skin hack', 'routine'],
    segments: ['problem', 'product', 'application', 'result'],
    transitions: ['soft-wipe', 'before-after'],
    music: ['clean-pop'],
    difficulty: TemplateDifficulty.easy,
    timesUsed: 5400,
    rating: 4.3,
  ),
  _TemplateSeed(
    name: 'Travel Highlight',
    description: 'Location pin, scenic reveal, and vibe-first cuts.',
    category: 'travel',
    duration: 45,
    hooks: ['hidden place', 'cost breakdown', 'must visit'],
    segments: ['arrival', 'best view', 'activity', 'save'],
    transitions: ['map-pin', 'match-cut'],
    music: ['travel-vibe'],
    difficulty: TemplateDifficulty.medium,
    timesUsed: 5900,
    rating: 4.5,
  ),
  _TemplateSeed(
    name: 'Tech Review',
    description: 'Clean product review with specs, pros, and verdict.',
    category: 'tech',
    duration: 50,
    hooks: ['worth it', 'hidden feature', 'quick review'],
    segments: ['hook', 'specs', 'pros', 'cons', 'verdict'],
    transitions: ['spec-card', 'cut'],
    music: ['minimal-tech'],
    difficulty: TemplateDifficulty.medium,
    timesUsed: 7300,
    rating: 4.6,
  ),
  _TemplateSeed(
    name: 'Business Tips',
    description: 'Number-driven business advice with clean chart moments.',
    category: 'business',
    duration: 45,
    hooks: ['money mistake', 'growth tip', 'framework'],
    segments: ['problem', 'framework', 'example', 'cta'],
    transitions: ['chart-pop', 'slide'],
    music: ['corporate-lite'],
    difficulty: TemplateDifficulty.medium,
    timesUsed: 6400,
    rating: 4.4,
  ),
  _TemplateSeed(
    name: 'Fitness Workout',
    description: 'Exercise demo with rep counter and energetic pacing.',
    category: 'fitness',
    duration: 40,
    hooks: ['no gym', 'quick burn', 'form fix'],
    segments: ['demo', 'reps', 'form tip', 'finish'],
    transitions: ['timer-pop', 'cut'],
    music: ['energy-training'],
    difficulty: TemplateDifficulty.easy,
    timesUsed: 6700,
    rating: 4.4,
  ),
  _TemplateSeed(
    name: 'Podcast 2-Speaker Split',
    description: 'Split-frame podcast format for two hosts and speaker turns.',
    category: 'podcast',
    duration: 75,
    hooks: ['hot take', 'debate moment', 'quote pull'],
    segments: ['speaker 1', 'speaker 2', 'banter', 'payoff'],
    transitions: ['split-screen', 'active-speaker-zoom'],
    music: ['calm-conversation'],
    difficulty: TemplateDifficulty.advanced,
    timesUsed: 12500,
    rating: 4.9,
  ),
  _TemplateSeed(
    name: 'Cinematic Storytelling',
    description: 'Film-grain story arc with slow zoom and emotional sound bed.',
    category: 'story',
    duration: 65,
    hooks: ['cinematic open', 'visual mystery', 'emotional arc'],
    segments: ['cold open', 'context', 'turn', 'resolution'],
    transitions: ['film-burn', 'slow-zoom'],
    music: ['cinematic-ambient'],
    difficulty: TemplateDifficulty.advanced,
    timesUsed: 8200,
    rating: 4.8,
  ),
  _TemplateSeed(
    name: 'Hook Stack',
    description: 'Three intro hook variants stacked for rapid retention.',
    category: 'hook',
    duration: 35,
    hooks: ['question', 'contrarian', 'proof'],
    segments: ['hook a', 'hook b', 'hook c', 'winner payoff'],
    transitions: ['hook-snap', 'speed-ramp'],
    music: ['attention-hit'],
    difficulty: TemplateDifficulty.advanced,
    timesUsed: 9300,
    rating: 4.8,
  ),
  _TemplateSeed(
    name: 'Dakwah Islamic',
    description:
        'Respectful Islamic content layout with warm calligraphy mood.',
    category: 'dakwah',
    duration: 55,
    hooks: ['reminder', 'ayat context', 'daily lesson'],
    segments: ['opening', 'dalil', 'reflection', 'dua'],
    transitions: ['soft-fade', 'gold-line'],
    music: ['soft-halal'],
    difficulty: TemplateDifficulty.medium,
    timesUsed: 7100,
    rating: 4.7,
  ),
  _TemplateSeed(
    name: 'Visual Essay',
    description: 'Minimal voiceover layout for abstract and thoughtful topics.',
    category: 'education',
    duration: 80,
    hooks: ['big question', 'pattern', 'reframe'],
    segments: ['question', 'evidence', 'analysis', 'takeaway'],
    transitions: ['minimal-fade', 'diagram'],
    music: ['ambient-focus'],
    difficulty: TemplateDifficulty.advanced,
    timesUsed: 4800,
    rating: 4.6,
  ),
  _TemplateSeed(
    name: 'Sales Funnel',
    description: 'Problem, solution, proof, and CTA with urgency cues.',
    category: 'business',
    duration: 50,
    hooks: ['problem', 'cost of delay', 'offer'],
    segments: ['pain', 'solution', 'proof', 'cta'],
    transitions: ['urgency-card', 'push'],
    music: ['sales-drive'],
    difficulty: TemplateDifficulty.advanced,
    timesUsed: 5200,
    rating: 4.5,
  ),
  _TemplateSeed(
    name: 'Idea Drop',
    description: 'Single surprising idea with dramatic reveal timing.',
    category: 'education',
    duration: 30,
    hooks: ['mind blow', 'one idea', 'shocking fact'],
    segments: ['fact', 'reveal', 'why', 'save'],
    transitions: ['reveal-flash', 'caption-pop'],
    music: ['dramatic-drop'],
    difficulty: TemplateDifficulty.medium,
    timesUsed: 8800,
    rating: 4.7,
  ),
];
