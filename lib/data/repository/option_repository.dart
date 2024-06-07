import 'package:etag/cors/repository/repository_sqlite.dart';
import 'package:etag/domain/model/category/product/option_model.dart';

class OptionRepository extends RepositorySqlite<OptionModel> {
  @override
  OptionModel convertJsonToModel(Map<String, dynamic> map) {
    return OptionModel.fromJson(map);
  }

  @override
  Map<String, dynamic> convertModelToJson(OptionModel model) {
    return model.toJson();
  }

  @override
  String get tableName => 'option';

  @override
  String get idColumnName => 'idOption';
}
