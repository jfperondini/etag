import 'package:etag/cors/repository/repository.dart';
import 'package:etag/domain/model/category/product/option_model.dart';
import 'package:etag/domain/model/category/product_model.dart';
import 'package:flutter/material.dart';

class ProductController extends ChangeNotifier {
  final Repository<ProductModel> repositoryProduct;
  final Repository<OptionModel> repositoryOption;

  List<ProductModel> listProduct = [];

  ProductController(this.repositoryProduct, this.repositoryOption);

  getListProduct({required int valueCollum}) async {
    listProduct = await repositoryProduct.searchLike(
      nameCollum: 'idCategory',
      valueCollum: valueCollum.toString(),
    );
    notifyListeners();
  }

  clearListProduct() {
    listProduct = [];
    notifyListeners();
  }
}
