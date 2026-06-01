import 'package:dio/dio.dart';

import '../../models/script.dart';
import '../script_repository.dart';
import 'api_repository_helpers.dart';

/// Public API surface for `ApiScriptRepository`.
class ApiScriptRepository implements ScriptRepository {
  ApiScriptRepository({Dio? dio})
      : _client = ApiResourceClient<Script>(
          path: '/scripts',
          fromJson: Script.fromJson,
          toJson: (script) => script.toJson(),
          idOf: (script) => script.id,
          dio: dio,
        );

  final ApiResourceClient<Script> _client;

  @override
  Future<List<Script>> getAll({String? projectId}) {
    return _client.getAll(query: {'project_id': projectId});
  }

  @override
  Future<Script?> getById(String id) => _client.getById(id);

  @override
  Future<Script> create(Script script) => _client.create(script);

  @override
  Future<Script> update(Script script) => _client.update(script);

  @override
  Future<void> delete(String id) => _client.delete(id);

  @override
  Stream<List<Script>> watch({String? projectId}) async* {
    yield await getAll(projectId: projectId);
  }
}
