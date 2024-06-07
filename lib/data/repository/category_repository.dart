import 'package:etag/cors/repository/repository_sqlite.dart';
import 'package:etag/domain/model/category_model.dart';

class CategoryRepository extends RepositorySqlite<CategoryModel> {
  @override
  CategoryModel convertJsonToModel(Map<String, dynamic> map) {
    return CategoryModel.fromJson(map);
  }

  @override
  Map<String, dynamic> convertModelToJson(CategoryModel model) {
    return model.toJson();
  }

  @override
  String get tableName => 'category';

  @override
  String get idColumnName => 'idCategory';
}
