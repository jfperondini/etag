class QueryGeneratorModel {
  List<String> listSql;

  QueryGeneratorModel({
    required this.listSql,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'listSql': listSql,
    };
  }

  factory QueryGeneratorModel.fromJson(Map<String, dynamic> map) {
    return QueryGeneratorModel(
      listSql: List<String>.from((map['listSql'] ?? [])),
    );
  }
}
