import 'package:etag/domain/model/category/product/option_model.dart';

class ProductModel {
  int idProduct;
  int idCategory;
  String name;
  String type;
  double value;
  String deleted;
  List<OptionModel> listOption;

  ProductModel({
    required this.idProduct,
    required this.idCategory,
    required this.name,
    required this.type,
    required this.value,
    required this.deleted,
    required this.listOption,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'idProduct': idProduct,
      'idCategory': idCategory,
      'name': name,
      'type': type,
      'value': value,
      'deleted': deleted,
      'listOption': listOption,
    };
  }

  factory ProductModel.fromJson(Map<String, dynamic> map) {
    return ProductModel(
      idProduct: map['idProduct'] ?? 0,
      idCategory: map['idCategory'] ?? 0,
      name: map['name'] ?? '',
      type: map['type'] ?? '',
      value: map['value'] ?? 0.00,
      deleted: map['deleted'] ?? '',
      listOption: (map['listOption'] as List<dynamic>?)?.map((e) => OptionModel.fromJson(e)).toList() ?? [],
    );
  }

  factory ProductModel.empty() {
    return ProductModel.fromJson({});
  }
}
