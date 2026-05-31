import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shorts_ai/features/auth/models/user.dart';
import 'package:shorts_ai/features/auth/providers/current_user_provider.dart';
import 'package:shorts_ai/features/brand_kit/providers/brand_kit_provider.dart';
import 'package:shorts_ai/features/brand_kit/services/palette_service.dart';
import 'package:shorts_ai/shared/models/brand_kit.dart';
import 'package:shorts_ai/shared/repositories/brand_kit_repository.dart';
import 'package:shorts_ai/shared/repositories/providers.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });

  test('save updates brand kit repository', () async {
    final repository = _FakeBrandKitRepository(existing: _brandKit);
    final container = _container(
      user: _premiumUser,
      repository: repository,
    );
    addTearDown(container.dispose);

    final notifier = container.read(brandKitProvider.notifier);
    await notifier.load();

    notifier.setPrimaryColor(const Color(0xFF38BDF8));
    final saved = await notifier.save();

    expect(saved.primaryColor, '#38BDF8');
    expect(repository.updated.single.primaryColor, '#38BDF8');
    expect(container.read(brandKitProvider).isDirty, isFalse);
  });

  test('palette preset applies primary, secondary, and accent colors', () {
    final repository = _FakeBrandKitRepository();
    final container = _container(
      user: _premiumUser,
      repository: repository,
    );
    addTearDown(container.dispose);

    final palette = brandPalettePresets.firstWhere(
      (palette) => palette.name == 'Ocean',
    );

    container.read(brandKitProvider.notifier).setPalette(palette);
    final state = container.read(brandKitProvider);

    expect(state.primaryColor, palette.primary);
    expect(state.secondaryColor, palette.secondary);
    expect(state.accentColor, palette.accent);
    expect(state.selectedPaletteName, 'Ocean');
    expect(state.isDirty, isTrue);
  });

  test('dirty state tracks local edits and resets after save', () async {
    final repository = _FakeBrandKitRepository(existing: _brandKit);
    final container = _container(
      user: _premiumUser,
      repository: repository,
    );
    addTearDown(container.dispose);

    final notifier = container.read(brandKitProvider.notifier);
    await notifier.load();

    expect(container.read(brandKitProvider).isDirty, isFalse);

    notifier.setLogo('C:/tmp/autoshort-logo.png');
    expect(container.read(brandKitProvider).isDirty, isTrue);

    await notifier.save();
    expect(container.read(brandKitProvider).isDirty, isFalse);
  });

  test('tier gates brand kit count, watermark editing, and brand videos', () {
    expect(canCreateAnotherBrandKit(SubscriptionTier.free, 1), isTrue);
    expect(canCreateAnotherBrandKit(SubscriptionTier.free, 2), isFalse);
    expect(canCreateAnotherBrandKit(SubscriptionTier.standard, 3), isTrue);
    expect(canCreateAnotherBrandKit(SubscriptionTier.standard, 4), isFalse);
    expect(canCreateAnotherBrandKit(SubscriptionTier.premium, 99), isTrue);

    expect(canEditWatermark(SubscriptionTier.free), isFalse);
    expect(canEditWatermark(SubscriptionTier.standard), isTrue);

    expect(canUseBrandVideo(SubscriptionTier.standard), isFalse);
    expect(canUseBrandVideo(SubscriptionTier.premium), isTrue);
    expect(canUseBrandVideo(SubscriptionTier.lifetime), isTrue);
  });
}

ProviderContainer _container({
  required User user,
  required BrandKitRepository repository,
}) {
  return ProviderContainer(
    overrides: [
      currentUserProvider.overrideWithValue(user),
      brandKitRepositoryProvider.overrideWithValue(repository),
    ],
  );
}

final _premiumUser = User(
  id: 'premium-user',
  email: 'premium@autoshort.id',
  tier: SubscriptionTier.premium,
  createdAt: DateTime(2026),
);

const _brandKit = BrandKit(
  id: 'brand_1',
  userId: 'premium-user',
  logoUrl: 'logo.png',
  primaryColor: '#D4AF37',
  secondaryColor: '#0B0C10',
  accentColor: '#E6C757',
  primaryFont: 'Inter',
  secondaryFont: 'JetBrains Mono',
);

class _FakeBrandKitRepository implements BrandKitRepository {
  _FakeBrandKitRepository({BrandKit? existing}) : _current = existing;

  BrandKit? _current;
  final created = <BrandKit>[];
  final updated = <BrandKit>[];

  @override
  Future<BrandKit> create(BrandKit brandKit) async {
    created.add(brandKit);
    _current = brandKit;
    return brandKit;
  }

  @override
  Future<void> delete(String id) async {
    if (_current?.id == id) {
      _current = null;
    }
  }

  @override
  Future<BrandKit?> getById(String id) async {
    return _current?.id == id ? _current : null;
  }

  @override
  Future<BrandKit?> getByUserId(String userId) async {
    return _current?.userId == userId ? _current : null;
  }

  @override
  Future<BrandKit> update(BrandKit brandKit) async {
    updated.add(brandKit);
    _current = brandKit;
    return brandKit;
  }

  @override
  Stream<BrandKit?> watchByUserId(String userId) {
    return Stream.value(_current?.userId == userId ? _current : null);
  }
}
