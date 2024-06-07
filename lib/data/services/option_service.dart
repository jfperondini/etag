import 'package:etag/data/mocks/option_mock.dart';
import 'package:etag/data/services/generic_service.dart';
import 'package:etag/domain/model/category/product/option_model.dart';

class OptionService extends GenericService<OptionModel> {
  OptionService(super.repository);

  @override
  Future<List<Map<String, dynamic>>> getRecordsFromService() async {
    return optionMock;
  }
}
