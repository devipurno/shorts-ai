import 'package:dio/dio.dart';

import '../../models/thumbnail.dart';
import '../thumbnail_repository.dart';
import 'api_repository_helpers.dart';

class ApiThumbnailRepository implements ThumbnailRepository {
  ApiThumbnailRepository({Dio? dio})
      : _client = ApiResourceClient<Thumbnail>(
          path: '/thumbnails',
          fromJson: Thumbnail.fromJson,
          toJson: (thumbnail) => thumbnail.toJson(),
          idOf: (thumbnail) => thumbnail.id,
          dio: dio,
        );

  final ApiResourceClient<Thumbnail> _client;

  @override
  Future<List<Thumbnail>> getAll({String? projectId}) {
    return _client.getAll(query: {'project_id': projectId});
  }

  @override
  Future<Thumbnail?> getById(String id) => _client.getById(id);

  @override
  Future<Thumbnail> create(Thumbnail thumbnail) => _client.create(thumbnail);

  @override
  Future<Thumbnail> update(Thumbnail thumbnail) => _client.update(thumbnail);

  @override
  Future<void> delete(String id) => _client.delete(id);

  @override
  Stream<List<Thumbnail>> watch({String? projectId}) async* {
    yield await getAll(projectId: projectId);
  }
}
