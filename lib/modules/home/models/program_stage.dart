import 'package:dhis2_demo_app/modules/home/models/data_element.dart';

class ProgramStage {
  String id;
  String name;
  List<DataElement>? dataElements;

  ProgramStage({
    required this.id,
    required this.name,
    this.dataElements = const [],
  });

  factory ProgramStage.fromJson(dynamic json) {
    List<DataElement> dataElements = [];

    for (var programStageDataElement
        in (json['programStageDataElements'] ?? [])) {
      dataElements
          .add(DataElement.fromJson(programStageDataElement['dataElement']));
    }

    return ProgramStage(
      id: json['id'] ?? '',
      name: json['displayName'] ?? '',
      dataElements: dataElements,
    );
  }

  Map toJson() {
    Map json = {};

    json['id'] = id;
    json['displayName'] = name;
    json['dataElements'] = (dataElements ?? [])
        .map((dataElement) => dataElement.toJson())
        .toList();

    return json;
  }

  @override
  String toString() {
    return name;
  }
}
