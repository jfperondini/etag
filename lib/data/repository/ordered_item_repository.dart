import 'package:etag/cors/repository/repository_sqlite.dart';
import 'package:etag/domain/model/ordered/ordered_item_model.dart';

class OrderedItemRepository extends RepositorySqlite<OrderedItemModel> {
  @override
  OrderedItemModel convertJsonToModel(Map<String, dynamic> map) {
    return OrderedItemModel.fromJson(map);
  }

  @override
  Map<String, dynamic> convertModelToJson(OrderedItemModel model) {
    return model.toJson();
  }

  @override
  String get tableName => 'orderedItem';

  @override
  String get idColumnName => 'idOrderedItem';
}
