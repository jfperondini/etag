import 'package:etag/cors/shared/utils/doube_extesion.dart';
import 'package:etag/domain/model/category/product_model.dart';

class OrderedItemModel {
  int? idOrderedItem;
  double valueItem;
  int quantity;
  ProductModel productModel;

  OrderedItemModel({
    this.idOrderedItem,
    required this.valueItem,
    required this.quantity,
    required this.productModel,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'valueItem': productModel.value,
      'idProduct': productModel.idProduct,
      'quantity': quantity,
    };
  }

  factory OrderedItemModel.fromJson(Map<String, dynamic> map) {
    return OrderedItemModel(
      idOrderedItem: map['idOrderedItem'] ?? 0,
      valueItem: map['valueItem'] ?? 0.00,
      quantity: map['quantity'] ?? 0,
      productModel: ProductModel.fromJson(map['product'] ?? {}),
    );
  }

  factory OrderedItemModel.newOrderItem({
    required int quantity,
    required ProductModel productModel,
  }) {
    double valueItem = (productModel.value * quantity).toPrecision(2);
    return OrderedItemModel(
      quantity: quantity,
      valueItem: valueItem,
      productModel: productModel,
    );
  }
}
