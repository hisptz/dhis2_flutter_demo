import 'package:dhis2_demo_app/modules/home/constants/program_type_constants.dart';
import 'package:dhis2_demo_app/modules/home/models/program_stage.dart';
import 'package:dhis2_demo_app/modules/home/models/tracked_entity_attribute.dart';

class Program {
  String id;
  String name;
  String programType;
  List<ProgramStage> programStages;
  List<TrackedEntityAttribute> programAttributes;

  Program({
    required this.id,
    required this.name,
    required this.programType,
    this.programAttributes = const [],
    this.programStages = const [],
  });

  factory Program.fromJson(dynamic json) {
    List<ProgramStage> programStages = [];
    List<TrackedEntityAttribute> programTrackedEntityAttributes = [];

    for (var programStage in (json['programStages'] ?? [])) {
      programStages.add(ProgramStage.fromJson(programStage));
    }

    for (var programTrackedEntityAttribute
        in (json['programTrackedEntityAttributes'] ?? [])) {
      programTrackedEntityAttributes.add(TrackedEntityAttribute.fromJson(
          programTrackedEntityAttribute['trackedEntityAttribute']));
    }

    return Program(
      id: json['id'] ?? '',
      name: json['displayName'] ?? '',
      programType: json['programType'] == 'WITHOUT_REGISTRATION'
          ? ProgramTypeConstants.event
          : json['programType'] == 'WITH_REGISTRATION'
              ? ProgramTypeConstants.tracker
              : 'N/A',
      programStages: programStages,
      programAttributes: programTrackedEntityAttributes,
    );
  }

  @override
  String toString() {
    return name;
  }
}
