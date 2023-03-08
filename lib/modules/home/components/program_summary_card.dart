import 'package:dhis2_demo_app/modules/home/constants/program_type_constants.dart';
import 'package:dhis2_demo_app/modules/home/models/program.dart';
import 'package:flutter/material.dart';

class ProgramSummaryCard extends StatelessWidget {
  const ProgramSummaryCard({
    super.key,
    required this.program,
  });

  final Program program;

  @override
  Widget build(BuildContext context) {
    double borderRadius = 8.0;

    return Material(
      type: MaterialType.card,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(borderRadius),
        ),
      ),
      child: _getBody(context),
    );
  }

  Widget _getBody(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _getProgramSummaryItem(
            context,
            label: 'Name',
            value: program.name,
          ),
          _getProgramSummaryItem(
            context,
            label: 'Type',
            value: program.programType,
          ),
          _getProgramSummaryItem(
            context,
            label: 'DHIS2 ID',
            value: program.id,
          ),
          Visibility(
            visible: program.programStages.isNotEmpty &&
                program.programType == ProgramTypeConstants.tracker,
            child: _getProgramSummaryItem(
              context,
              label: 'Number of stages',
              value: '${program.programStages.length}',
            ),
          ),
          Visibility(
            visible: program.programStages.isNotEmpty &&
                program.programType == ProgramTypeConstants.event,
            child: _getProgramSummaryItem(
              context,
              label: 'Number of Data elements',
              value: '${program.programStages.first.dataElements?.length}',
            ),
          ),
          Visibility(
            visible: program.programAttributes.isNotEmpty &&
                program.programType == ProgramTypeConstants.tracker,
            child: _getProgramSummaryItem(
              context,
              label: 'Number of attributes',
              value: '${program.programAttributes.length}',
            ),
          ),
        ],
      ),
    );
  }

  Widget _getProgramSummaryItem(
    BuildContext context, {
    required String label,
    required String value,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4.0),
      child: RichText(
        text: TextSpan(
          text: '$label: ',
          style: DefaultTextStyle.of(context).style,
          children: [
            TextSpan(
              text: value,
              style: const TextStyle(
                fontWeight: FontWeight.w900,
              ),
            )
          ],
        ),
      ),
    );
  }
}
