import 'dart:async';

import 'package:faker/faker.dart';

import '../../../core/errors/app_exception.dart';
import '../../models/subtitle.dart';
import '../subtitle_repository.dart';
import 'mock_repository_utils.dart';

/// Public API surface for `MockSubtitleRepository`.
class MockSubtitleRepository implements SubtitleRepository {
  MockSubtitleRepository({
    MockRepositoryConfig config = const MockRepositoryConfig(),
  })  : _runtime = MockRepositoryRuntime(config),
        _faker = Faker() {
    _subtitles.addAll(_seedSubtitles());
  }

  final MockRepositoryRuntime _runtime;
  final Faker _faker;
  final _controller = StreamController<void>.broadcast();
  final _subtitles = <Subtitle>[];

  @override
  Future<List<Subtitle>> getAll({String? projectId}) async {
    await _runtime.simulateNetwork();
    return List<Subtitle>.unmodifiable(_filter(projectId));
  }

  @override
  Future<Subtitle?> getById(String id) async {
    await _runtime.simulateNetwork();
    return _subtitles.where((subtitle) => subtitle.id == id).firstOrNull;
  }

  @override
  Future<Subtitle> create(Subtitle subtitle) async {
    await _runtime.simulateNetwork();
    _subtitles.add(subtitle);
    _emit();
    return subtitle;
  }

  @override
  Future<Subtitle> update(Subtitle subtitle) async {
    await _runtime.simulateNetwork();
    final index = _subtitles.indexWhere((item) => item.id == subtitle.id);
    if (index == -1) {
      throw const NotFoundException('Subtitle not found.',
          code: 'subtitle_not_found');
    }
    _subtitles[index] = subtitle;
    _emit();
    return subtitle;
  }

  @override
  Future<void> delete(String id) async {
    await _runtime.simulateNetwork();
    _subtitles.removeWhere((subtitle) => subtitle.id == id);
    _emit();
  }

  @override
  Stream<List<Subtitle>> watch({String? projectId}) async* {
    await _runtime.simulateNetwork();
    yield List<Subtitle>.unmodifiable(_filter(projectId));
    yield* _controller.stream
        .map((_) => List<Subtitle>.unmodifiable(_filter(projectId)));
  }

  List<Subtitle> _seedSubtitles() {
    return List<Subtitle>.generate(6, (index) {
      final words = _faker.lorem.words(4);
      return Subtitle(
        id: 'subtitle_${index + 1}',
        projectId: 'project_${index + 1}',
        language: 'id',
        format: SubtitleFormat.ass,
        segments: [
          SubtitleSegment(
            startMs: 0,
            endMs: 1600,
            text: words.join(' '),
            words: [
              for (var wordIndex = 0; wordIndex < words.length; wordIndex++)
                Word(
                  text: words[wordIndex],
                  startMs: wordIndex * 400,
                  endMs: wordIndex * 400 + 350,
                ),
            ],
          ),
        ],
        style: const SubtitleStyle(fontSize: 42, animation: 'karaoke'),
      );
    });
  }

  List<Subtitle> _filter(String? projectId) {
    if (projectId == null) {
      return [..._subtitles];
    }
    return _subtitles
        .where((subtitle) => subtitle.projectId == projectId)
        .toList();
  }

  void _emit() => _controller.add(null);
}
