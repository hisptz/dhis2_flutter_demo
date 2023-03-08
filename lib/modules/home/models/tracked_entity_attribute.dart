class TrackedEntityAttribute {
  String id;
  String name;
  String valueType;

  TrackedEntityAttribute({
    required this.id,
    required this.name,
    required this.valueType,
  });

  factory TrackedEntityAttribute.fromJson(dynamic json) {
    return TrackedEntityAttribute(
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
