import '../models/subtitle.dart';

abstract class SubtitleRepository {
  Future<List<Subtitle>> getAll({String? projectId});

  Future<Subtitle?> getById(String id);

  Future<Subtitle> create(Subtitle subtitle);

  Future<Subtitle> update(Subtitle subtitle);

  Future<void> delete(String id);

  Stream<List<Subtitle>> watch({String? projectId});
}
