import 'package:etag/domain/model/category/product_model.dart';

class CategoryModel {
  int idCategory;
  String type;
  String deleted;
  List<ProductModel> listProduct;

  CategoryModel({
    required this.idCategory,
    required this.type,
    required this.deleted,
    required this.listProduct,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'idCategory': idCategory,
      'type': type,
      'deleted': deleted,
      'listProduct': listProduct,
    };
  }

  factory CategoryModel.fromJson(Map<String, dynamic> map) {
    return CategoryModel(
      idCategory: map['idCategory'] ?? 0,
      type: map['type'] ?? '',
      deleted: map['deleted'] ?? '',
      listProduct: (map['listProduct'] as List<dynamic>?)?.map((e) => ProductModel.fromJson(e)).toList() ?? [],
    );
  }
}
