import 'package:etag/cors/repository/repository.dart';

abstract class GenericService<Model> {
  final Repository<Model> repository;

  GenericService(this.repository);

  Future<List<Map<String, dynamic>>> getRecordsFromService();

  Future<bool> syncTable() async {
    List<Map<String, dynamic>> records = await getRecordsFromService();
    await repository.replaceMany(jsons: records.where((e) => (e['deleted'] ?? "0") == "0").toList());
    await repository.deleteMany(jsons: records.where((e) => (e['deleted'] ?? "0") == "1").toList());
    return true;
  }
}
