import 'package:etag/domain/model/ordered/ordered_item_model.dart';

class OrderedModel {
  int? idOrdered;
  int idEvent;
  double valueTotal;
  List<OrderedItemModel> listOrderedItem;

  OrderedModel({
    this.idOrdered,
    required this.idEvent,
    required this.valueTotal,
    required this.listOrderedItem,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'idEvent': idEvent,
      'valueTotal': valueTotal,
    };
  }

  factory OrderedModel.fromJson(Map<String, dynamic> map) {
    return OrderedModel(
      idOrdered: map['idOrdered'] ?? 0,
      idEvent: map['idEvent'] ?? 0,
      valueTotal: map['valueTotal'] ?? 0.00,
      listOrderedItem: (map['listOrderItem'] as List<dynamic>?)?.map((e) => OrderedItemModel.fromJson(e)).toList() ?? [],
    );
  }

  factory OrderedModel.empty() {
    return OrderedModel.fromJson({});
  }

  OrderedModel copyWith({
    int? idOrdered,
    int? idEvent,
    double? valueTotal,
    List<OrderedItemModel>? listOrderedItem,
  }) {
    return OrderedModel(
      idOrdered: idOrdered ?? this.idOrdered,
      idEvent: idEvent ?? this.idEvent,
      valueTotal: valueTotal ?? this.valueTotal,
      listOrderedItem: listOrderedItem ?? this.listOrderedItem,
    );
  }
}
