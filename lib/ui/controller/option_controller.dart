import 'package:etag/cors/repository/repository.dart';
import 'package:etag/domain/model/category/product/option_model.dart';
import 'package:etag/domain/model/category/product_model.dart';
import 'package:flutter/material.dart';

class OptionController extends ChangeNotifier {
  final Repository<OptionModel> repositoryOption;

  ProductModel? productSelect;

  OptionController(this.repositoryOption);

  getListOption({required ProductModel productModel}) async {
    productSelect = productModel;
    productSelect?.listOption = await repositoryOption.searchLike(
      nameCollum: 'idProduct',
      valueCollum: '${productSelect?.idProduct}',
    );
    notifyListeners();
  }

  setOption(int index) {
    productSelect?.listOption.removeWhere((item) => productSelect?.listOption.indexOf(item) != index);
    notifyListeners();
  }
}
