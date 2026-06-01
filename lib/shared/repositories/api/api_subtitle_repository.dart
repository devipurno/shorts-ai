import 'package:dio/dio.dart';

import '../../models/subtitle.dart';
import '../subtitle_repository.dart';
import 'api_repository_helpers.dart';

/// Public API surface for `ApiSubtitleRepository`.
class ApiSubtitleRepository implements SubtitleRepository {
  ApiSubtitleRepository({Dio? dio})
      : _client = ApiResourceClient<Subtitle>(
          path: '/subtitles',
          fromJson: Subtitle.fromJson,
          toJson: (subtitle) => subtitle.toJson(),
          idOf: (subtitle) => subtitle.id,
          dio: dio,
        );

  final ApiResourceClient<Subtitle> _client;

  @override
  Future<List<Subtitle>> getAll({String? projectId}) {
    return _client.getAll(query: {'project_id': projectId});
  }

  @override
  Future<Subtitle?> getById(String id) => _client.getById(id);

  @override
  Future<Subtitle> create(Subtitle subtitle) => _client.create(subtitle);

  @override
  Future<Subtitle> update(Subtitle subtitle) => _client.update(subtitle);

  @override
  Future<void> delete(String id) => _client.delete(id);

  @override
  Stream<List<Subtitle>> watch({String? projectId}) async* {
    yield await getAll(projectId: projectId);
  }
}
