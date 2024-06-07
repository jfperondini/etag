class OptionModel {
  int idOption;
  int idProduct;
  String name;
  int quantity;
  String deleted;

  OptionModel({
    required this.idOption,
    required this.idProduct,
    required this.name,
    required this.quantity,
    required this.deleted,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'idOption': idOption,
      'idProduct': idProduct,
      'name': name,
      'quantity': quantity,
      'deleted': deleted,
    };
  }

  factory OptionModel.fromJson(Map<String, dynamic> map) {
    return OptionModel(
      idOption: map['idOption'] ?? 0,
      idProduct: map['idProduct'] ?? 0,
      name: map['name'] ?? '',
      quantity: map['quantity'] ?? 0,
      deleted: map['deleted'] ?? '',
    );
  }
}
