import 'package:etag/cors/repository/repository.dart';
import 'package:etag/domain/model/category/product_model.dart';
import 'package:etag/domain/model/category_model.dart';
import 'package:etag/domain/model/event_model.dart';
import 'package:flutter/material.dart';

class HomeController extends ChangeNotifier {
  final Repository<EventModel> repositoryEvent;
  final Repository<CategoryModel> repositoryCategory;
  final Repository<ProductModel> repositoryProduct;

  EventModel? eventSelect;
  List<CategoryModel> listCategory = [];
  List<ProductModel> listFilterProduct = [];

  HomeController(this.repositoryEvent, this.repositoryCategory, this.repositoryProduct);

  final search = TextEditingController();
  int selectedIndex = 0;

  filterListEvent() async {
    List<EventModel> listFilterEvent = await repositoryEvent.getAll();
    eventSelect = listFilterEvent.first;
    notifyListeners();
  }

  getListCategory() async {
    listCategory = await repositoryCategory.getAll();
    notifyListeners();
  }

  filterListProduct() async {
    if (search.text.isNotEmpty) {
      listFilterProduct = await repositoryProduct.searchLike(
        nameCollum: 'name',
        valueCollum: '%${search.text}%',
      );
    }
    notifyListeners();
  }

  onItemTapped(int index) {
    selectedIndex = index;
    notifyListeners();
  }

  clearSearch() {
    search.text = '';
    notifyListeners();
  }

  clearListFilterProduct() {
    listFilterProduct = [];
    notifyListeners();
  }
}
