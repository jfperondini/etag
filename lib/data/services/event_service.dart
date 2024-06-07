import 'package:etag/data/mocks/event_mock.dart';
import 'package:etag/data/services/generic_service.dart';

import 'package:etag/domain/model/event_model.dart';

class EventService extends GenericService<EventModel> {
  EventService(super.repository);

  @override
  Future<List<Map<String, dynamic>>> getRecordsFromService() async {
    return eventMock;
  }
}
