class EventModel {
  int idEvent;
  String name;
  String date;
  String time;
  String deleted;

  EventModel({
    required this.idEvent,
    required this.name,
    required this.date,
    required this.time,
    required this.deleted,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'idEvent': idEvent,
      'name': name,
      'date': date,
      'time': time,
      'deleted': deleted,
    };
  }

  factory EventModel.fromJson(Map<String, dynamic> map) {
    return EventModel(
      idEvent: map['idEvent'] ?? 0,
      name: map['name'] ?? '',
      date: map['date'] ?? '',
      time: map['time'] ?? '',
      deleted: map['deleted'] ?? '',
    );
  }
}
