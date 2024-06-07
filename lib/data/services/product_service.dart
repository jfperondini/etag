import 'package:etag/data/mocks/product_mock.dart';
import 'package:etag/data/services/generic_service.dart';
import 'package:etag/domain/model/category/product_model.dart';

class ProductService extends GenericService<ProductModel> {
  ProductService(super.repository);

  @override
  Future<List<Map<String, dynamic>>> getRecordsFromService() async {
    return productMock;
  }
}
