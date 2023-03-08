import 'package:dhis2_demo_app/core/constants/app_constants.dart';
import 'package:dhis2_demo_app/modules/login/models/user.dart';
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
  late List<Map> programs;
  final String title = 'DHIS2 programs explorer';

  List<Map> getPrograms() {
    return [];
  }

  @override
  void initState() {
    programs = [];
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
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: backgroundColor,
          ),
          child: Column(
            children: programs.isEmpty
                ? [
                    Center(
                      child: Container(
                        margin: const EdgeInsets.symmetric(
                            vertical: 50, horizontal: 10),
                        child: const Text(
                          'There are no loaded programs. Please refresh!',
                          style: TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ]
                : [],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: const Icon(Icons.refresh),
        ),
      ),
    );
  }
}
