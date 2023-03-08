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

  @override
  String toString() {
    return name;
  }
}
