import 'package:etag/cors/repository/repository.dart';
import 'package:etag/domain/model/category/product_model.dart';
import 'package:etag/domain/model/ordered/ordered_item_model.dart';
import 'package:etag/domain/model/ordered_model.dart';
import 'package:etag/ui/controller/home_controller.dart';
import 'package:flutter/material.dart';

class OrderedControler extends ChangeNotifier {
  final Repository<OrderedModel> repositoryOrdered;
  final Repository<OrderedItemModel> repositoryOrderedItem;
  final HomeController homeController;

  OrderedModel? orderedSelect;

  OrderedControler(this.repositoryOrdered, this.repositoryOrderedItem, this.homeController);

  setOrdered() {
    OrderedModel newOrderedModel = OrderedModel(
      idEvent: homeController.eventSelect?.idEvent ?? 0,
      valueTotal: 0.00,
      listOrderedItem: orderedSelect?.listOrderedItem ?? [],
    );
    orderedSelect = newOrderedModel;
    notifyListeners();
  }

  setOrderedService() async {
    await repositoryOrdered.insert(model: orderedSelect ?? OrderedModel.empty());
    notifyListeners();
  }

  setOrderedItem({
    required ProductModel productModel,
  }) {
    OrderedItemModel newOrderItem = OrderedItemModel.newOrderItem(
      quantity: 1,
      productModel: productModel,
    );
    int? index = orderedSelect?.listOrderedItem.indexWhere(
      (e) => e.productModel.idProduct == newOrderItem.productModel.idProduct,
    );
    (index != null && index != -1)
        ? orderedSelect?.listOrderedItem[index].quantity += newOrderItem.quantity
        : orderedSelect = orderedSelect?.copyWith(
            listOrderedItem: List.from(orderedSelect?.listOrderedItem ?? [])..add(newOrderItem),
          );
    List<OrderedItemModel> listOrderedItem = orderedSelect?.listOrderedItem ?? [];
    orderedSelect?.valueTotal = listOrderedItem.map((e) => e.valueItem * e.quantity).fold(0.00, (v, e) => v + e);
    notifyListeners();
  }

  setOrderedItemService() async {
    for (final orderItem in orderedSelect?.listOrderedItem ?? []) {
      await repositoryOrderedItem.insert(model: orderItem);
    }
    notifyListeners();
  }

  increaseQuantity(int index) {
    orderedSelect?.listOrderedItem[index].quantity++;
    int quantity = orderedSelect?.listOrderedItem[index].quantity ?? 0;
    double value = orderedSelect?.listOrderedItem[index].productModel.value ?? 0.00;
    orderedSelect?.listOrderedItem[index].valueItem = (value * quantity);
    orderedSelect?.valueTotal = orderedSelect!.listOrderedItem.map((e) => e.valueItem).fold(0.00, (value, element) => value + element);
    notifyListeners();
  }

  decreaseQuantity(int index) {
    int? quantity = orderedSelect?.listOrderedItem[index].quantity;
    if (quantity != null && quantity > 1) {
      orderedSelect?.listOrderedItem[index].quantity--;
      int quantity = orderedSelect?.listOrderedItem[index].quantity ?? 0;
      double value = orderedSelect?.listOrderedItem[index].productModel.value ?? 0.00;
      orderedSelect?.listOrderedItem[index].valueItem = (value * quantity);
      orderedSelect?.valueTotal = orderedSelect!.listOrderedItem.map((e) => e.valueItem).fold(0.00, (value, element) => value + element);
      notifyListeners();
    } else {
      orderedSelect?.listOrderedItem.removeAt(index);
      orderedSelect?.valueTotal = 0.00;
      notifyListeners();
    }
  }

  clearOrder() {
    orderedSelect = OrderedModel.empty();
    notifyListeners();
  }
}
