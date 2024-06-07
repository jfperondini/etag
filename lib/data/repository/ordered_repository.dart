import 'package:etag/cors/repository/repository_sqlite.dart';
import 'package:etag/domain/model/ordered_model.dart';

class OrderRepository extends RepositorySqlite<OrderedModel> {
  @override
  OrderedModel convertJsonToModel(Map<String, dynamic> map) {
    return OrderedModel.fromJson(map);
  }

  @override
  Map<String, dynamic> convertModelToJson(OrderedModel model) {
    return model.toJson();
  }

  @override
  String get tableName => 'ordered';

  @override
  String get idColumnName => 'idOrdered';
}
