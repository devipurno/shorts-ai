import '../models/brand_kit.dart';

abstract class BrandKitRepository {
  Future<BrandKit?> getByUserId(String userId);

  Future<BrandKit?> getById(String id);

  Future<BrandKit> create(BrandKit brandKit);

  Future<BrandKit> update(BrandKit brandKit);

  Future<void> delete(String id);

  Stream<BrandKit?> watchByUserId(String userId);
}
