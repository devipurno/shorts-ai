import 'package:dio/dio.dart';

import '../../models/brand_kit.dart';
import '../brand_kit_repository.dart';
import 'api_repository_helpers.dart';

class ApiBrandKitRepository implements BrandKitRepository {
  ApiBrandKitRepository({Dio? dio})
      : _client = ApiResourceClient<BrandKit>(
          path: '/brand-kits',
          fromJson: BrandKit.fromJson,
          toJson: (brandKit) => brandKit.toJson(),
          idOf: (brandKit) => brandKit.id,
          dio: dio,
        );

  final ApiResourceClient<BrandKit> _client;

  @override
  Future<BrandKit?> getByUserId(String userId) async {
    final items = await _client.getAll(query: {'user_id': userId});
    return items.firstOrNull;
  }

  @override
  Future<BrandKit?> getById(String id) => _client.getById(id);

  @override
  Future<BrandKit> create(BrandKit brandKit) => _client.create(brandKit);

  @override
  Future<BrandKit> update(BrandKit brandKit) => _client.update(brandKit);

  @override
  Future<void> delete(String id) => _client.delete(id);

  @override
  Stream<BrandKit?> watchByUserId(String userId) async* {
    yield await getByUserId(userId);
  }
}
