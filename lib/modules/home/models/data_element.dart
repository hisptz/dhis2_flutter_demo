class DataElement {
  String id;
  String name;
  String valueType;

  DataElement({
    required this.id,
    required this.name,
    required this.valueType,
  });

  factory DataElement.fromJson(dynamic json) {
    return DataElement(
      id: json['id'] ?? '',
      name: json['displayName'] ?? '',
      valueType: json['valueType'] ?? '',
    );
  }

  Map toJson() {
    Map json = {};

    json['id'] = id;
    json['displayName'] = name;
    json['valueType'] = valueType;

    return json;
  }

  @override
  String toString() {
    return name;
  }
}
