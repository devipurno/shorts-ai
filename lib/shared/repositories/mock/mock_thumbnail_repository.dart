import 'dart:async';

import '../../../core/errors/app_exception.dart';
import '../../models/thumbnail.dart';
import '../thumbnail_repository.dart';
import 'mock_repository_utils.dart';

/// Public API surface for `MockThumbnailRepository`.
class MockThumbnailRepository implements ThumbnailRepository {
  MockThumbnailRepository({
    MockRepositoryConfig config = const MockRepositoryConfig(),
  }) : _runtime = MockRepositoryRuntime(config) {
    _thumbnails.addAll(_seedThumbnails());
  }

  final MockRepositoryRuntime _runtime;
  final _controller = StreamController<void>.broadcast();
  final _thumbnails = <Thumbnail>[];

  @override
  Future<List<Thumbnail>> getAll({String? projectId}) async {
    await _runtime.simulateNetwork();
    return List<Thumbnail>.unmodifiable(_filter(projectId));
  }

  @override
  Future<Thumbnail?> getById(String id) async {
    await _runtime.simulateNetwork();
    return _thumbnails.where((thumbnail) => thumbnail.id == id).firstOrNull;
  }

  @override
  Future<Thumbnail> create(Thumbnail thumbnail) async {
    await _runtime.simulateNetwork();
    _thumbnails.add(thumbnail);
    _emit();
    return thumbnail;
  }

  @override
  Future<Thumbnail> update(Thumbnail thumbnail) async {
    await _runtime.simulateNetwork();
    final index = _thumbnails.indexWhere((item) => item.id == thumbnail.id);
    if (index == -1) {
      throw const NotFoundException(
        'Thumbnail not found.',
        code: 'thumbnail_not_found',
      );
    }
    _thumbnails[index] = thumbnail;
    _emit();
    return thumbnail;
  }

  @override
  Future<void> delete(String id) async {
    await _runtime.simulateNetwork();
    _thumbnails.removeWhere((thumbnail) => thumbnail.id == id);
    _emit();
  }

  @override
  Stream<List<Thumbnail>> watch({String? projectId}) async* {
    await _runtime.simulateNetwork();
    yield List<Thumbnail>.unmodifiable(_filter(projectId));
    yield* _controller.stream
        .map((_) => List<Thumbnail>.unmodifiable(_filter(projectId)));
  }

  List<Thumbnail> _seedThumbnails() {
    return List<Thumbnail>.generate(8, (index) {
      return Thumbnail(
        id: 'thumbnail_${index + 1}',
        projectId: 'project_${index % 6 + 1}',
        imageUrl: 'https://picsum.photos/seed/thumb-a-$index/1080/1920',
        isVariantA: index.isEven,
        variantBImageUrl: 'https://picsum.photos/seed/thumb-b-$index/1080/1920',
        ctrPrediction: 0.35 + _runtime.nextDouble() * 0.6,
        selectedVariant: index.isEven ? ThumbnailVariant.a : ThumbnailVariant.b,
      );
    });
  }

  List<Thumbnail> _filter(String? projectId) {
    if (projectId == null) {
      return [..._thumbnails];
    }
    return _thumbnails
        .where((thumbnail) => thumbnail.projectId == projectId)
        .toList();
  }

  void _emit() => _controller.add(null);
}
