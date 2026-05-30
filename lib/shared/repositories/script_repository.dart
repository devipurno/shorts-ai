import '../models/script.dart';

abstract class ScriptRepository {
  Future<List<Script>> getAll({String? projectId});

  Future<Script?> getById(String id);

  Future<Script> create(Script script);

  Future<Script> update(Script script);

  Future<void> delete(String id);

  Stream<List<Script>> watch({String? projectId});
}
