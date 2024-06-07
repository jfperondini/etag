import 'package:etag/data/mocks/query_generator_mock.dart';
import 'package:etag/domain/model/generator_model.dart';

class QueryGeneratorService {
  Future<QueryGeneratorModel> getSqlFromService() async {
    return QueryGeneratorModel(listSql: queryGeneratorMock);
  }
}
