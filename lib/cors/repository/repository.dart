abstract class Repository<Model> {
  List<Model> convertJsonToModels(List<Map<String, dynamic>> list) {
    return list.map((e) => convertJsonToModel(e)).toList();
  }

  Model convertJsonToModel(Map<String, dynamic> map);

  Map<String, dynamic> convertModelToJson(Model model);

  Future<List<Model>> getAll();

  Future<List<Model>> searchLike({required String nameCollum, required String valueCollum});

  insert({required Model model});

  delete({required int id});

  replaceMany({required List<Map<String, dynamic>> jsons});

  deleteMany({required List<Map<String, dynamic>> jsons});
}
