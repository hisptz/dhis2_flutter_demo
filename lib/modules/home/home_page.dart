import 'package:dhis2_demo_app/core/constants/app_constants.dart';
import 'package:dhis2_demo_app/modules/home/components/program_summary_card.dart';
import 'package:dhis2_demo_app/modules/home/models/program.dart';
import 'package:dhis2_demo_app/modules/home/services/programs_service.dart';
import 'package:dhis2_demo_app/modules/login/models/user.dart';
import 'package:dhis2_demo_app/modules/login/services/user_service.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  final User currentUser;
  const HomePage({
    super.key,
    required this.currentUser,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late List<Program> programs;
  final String title = 'DHIS2 programs explorer';

  Future<void> fetchPrograms() async {
    var currentUser = await UserService().getCurrentUserCredentials();
    List<Program> fetchedPrograms = await ProgramService().getDHIS2Programs(
      username: currentUser['username'],
      password: currentUser['password'],
    );

    setState(() {
      programs = fetchedPrograms.isNotEmpty ? fetchedPrograms : programs;
    });
  }

  @override
  void initState() {
    setState(() {
      programs = [];
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Color backgroundColor = AppConstants.defaultColor.withOpacity(0.25);

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: Text(
          title,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: AppConstants.defaultColor,
        scrolledUnderElevation: 4.0,
        shadowColor: Theme.of(context).shadowColor,
      ),
      body: Scaffold(
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: backgroundColor,
          ),
          child: Scrollbar(
            thumbVisibility: true,
            trackVisibility: true,
            child: ListView(
              children: programs.isEmpty
                  ? [
                      Center(
                        child: Container(
                          margin: const EdgeInsets.symmetric(
                              vertical: 48, horizontal: 8),
                          child: const Text(
                            'There are no loaded programs. Please refresh!',
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    ]
                  : programs
                      .map(
                        (program) => Container(
                          margin: const EdgeInsets.symmetric(vertical: 4.0),
                          child: ProgramSummaryCard(
                            program: program,
                          ),
                        ),
                      )
                      .toList(),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            fetchPrograms();
          },
          child: const Icon(Icons.refresh),
        ),
      ),
    );
  }
}
