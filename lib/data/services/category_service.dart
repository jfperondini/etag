import 'package:etag/data/mocks/category_mock.dart';
import 'package:etag/data/services/generic_service.dart';
import 'package:etag/domain/model/category_model.dart';

class CategoryService extends GenericService<CategoryModel> {
  CategoryService(super.repository);

  @override
  Future<List<Map<String, dynamic>>> getRecordsFromService() async {
    return categoryMock;
  }
}
