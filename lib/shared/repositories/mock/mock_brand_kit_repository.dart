import 'dart:async';

import '../../../core/errors/app_exception.dart';
import '../../models/brand_kit.dart';
import '../brand_kit_repository.dart';
import 'mock_repository_utils.dart';

class MockBrandKitRepository implements BrandKitRepository {
  MockBrandKitRepository({
    MockRepositoryConfig config = const MockRepositoryConfig(),
  }) : _runtime = MockRepositoryRuntime(config) {
    _brandKits.addAll(_seedBrandKits());
  }

  final MockRepositoryRuntime _runtime;
  final _controller = StreamController<void>.broadcast();
  final _brandKits = <BrandKit>[];

  @override
  Future<BrandKit?> getByUserId(String userId) async {
    await _runtime.simulateNetwork();
    return _findByUserId(userId);
  }

  @override
  Future<BrandKit?> getById(String id) async {
    await _runtime.simulateNetwork();
    return _brandKits.where((brandKit) => brandKit.id == id).firstOrNull;
  }

  @override
  Future<BrandKit> create(BrandKit brandKit) async {
    await _runtime.simulateNetwork();
    _brandKits.add(brandKit);
    _emit();
    return brandKit;
  }

  @override
  Future<BrandKit> update(BrandKit brandKit) async {
    await _runtime.simulateNetwork();
    final index = _brandKits.indexWhere((item) => item.id == brandKit.id);
    if (index == -1) {
      throw const NotFoundException(
        'Brand kit not found.',
        code: 'brand_kit_not_found',
      );
    }
    _brandKits[index] = brandKit;
    _emit();
    return brandKit;
  }

  @override
  Future<void> delete(String id) async {
    await _runtime.simulateNetwork();
    _brandKits.removeWhere((brandKit) => brandKit.id == id);
    _emit();
  }

  @override
  Stream<BrandKit?> watchByUserId(String userId) async* {
    await _runtime.simulateNetwork();
    yield _findByUserId(userId);
    yield* _controller.stream.map((_) => _findByUserId(userId));
  }

  List<BrandKit> _seedBrandKits() {
    return List<BrandKit>.generate(6, (index) {
      return BrandKit(
        id: 'brand_${index + 1}',
        userId: 'user_${index + 1}',
        logoUrl: 'https://picsum.photos/seed/logo-$index/512/512',
        primaryColor: index.isEven ? '#D4AF37' : '#60A5FA',
        secondaryColor: '#0B0C10',
        accentColor: index.isEven ? '#E6C757' : '#4ADE80',
        primaryFont: 'Inter',
        secondaryFont: 'JetBrains Mono',
        watermarkUrl: 'https://picsum.photos/seed/watermark-$index/256/256',
        watermarkPosition: index.isEven ? 'bottom_right' : 'top_left',
        introVideoUrl: 'https://cdn.autoshort.test/brand-$index/intro.mp4',
        outroVideoUrl: 'https://cdn.autoshort.test/brand-$index/outro.mp4',
      );
    });
  }

  BrandKit? _findByUserId(String userId) {
    return _brandKits
        .where((brandKit) => brandKit.userId == userId)
        .firstOrNull;
  }

  void _emit() => _controller.add(null);
}
