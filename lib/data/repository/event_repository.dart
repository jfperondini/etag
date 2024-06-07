import 'package:etag/cors/repository/repository_sqlite.dart';
import 'package:etag/domain/model/event_model.dart';

class EventRepository extends RepositorySqlite<EventModel> {
  @override
  EventModel convertJsonToModel(Map<String, dynamic> map) {
    return EventModel.fromJson(map);
  }

  @override
  Map<String, dynamic> convertModelToJson(EventModel model) {
    return model.toJson();
  }

  @override
  String get tableName => 'event';

  @override
  String get idColumnName => 'idEvent';
}
