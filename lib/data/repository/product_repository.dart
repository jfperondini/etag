import 'package:etag/cors/repository/repository_sqlite.dart';
import 'package:etag/domain/model/category/product_model.dart';

class ProductRepository extends RepositorySqlite<ProductModel> {
  @override
  ProductModel convertJsonToModel(Map<String, dynamic> map) {
    return ProductModel.fromJson(map);
  }

  @override
  Map<String, dynamic> convertModelToJson(ProductModel model) {
    return model.toJson();
  }

  @override
  String get tableName => 'product';

  @override
  String get idColumnName => 'idProduct';
}
