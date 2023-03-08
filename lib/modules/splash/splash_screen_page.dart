import 'dart:async';

import 'package:dhis2_demo_app/core/components/circular_loader.dart';
import 'package:dhis2_demo_app/core/constants/app_constants.dart';
import 'package:dhis2_demo_app/core/utils/app_utils.dart';
import 'package:dhis2_demo_app/modules/home/pages/home_page.dart';
import 'package:dhis2_demo_app/modules/login/login_page.dart';
import 'package:dhis2_demo_app/modules/login/services/user_service.dart';
import 'package:flutter/material.dart';

class SplashScreenPage extends StatefulWidget {
  const SplashScreenPage({super.key});

  @override
  State<SplashScreenPage> createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  bool loading = true;

  void setLoadingState(bool state) {
    setState(() {
      loading = state;
    });
  }

  @override
  void initState() {
    Timer(const Duration(milliseconds: 500), () {
      checkForCurrentUser();
    });

    super.initState();
  }

  void onNavigateToLogin(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => const LoginPage(),
      ),
    );
  }

  void checkForCurrentUser() async {
    var currentUser = await UserService().getCurrentUserCredentials();
    if (currentUser.isEmpty) {
      setLoadingState(false);
    } else {
      AppUtils.showToastMessage(message: 'Verifying user account!');
      UserService()
          .login(
        username: currentUser['username'],
        password: currentUser['password'],
        serverUrl: AppConstants.serverUrl,
      )
          .then((loggedInUser) {
        if (loggedInUser != null) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (_) => HomePage(
                currentUser: loggedInUser,
              ),
            ),
          );
        } else {
          setLoadingState(false);
        }
      }).catchError((error) {
        setLoadingState(false);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: AppConstants.defaultColor,
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(
                  bottom: 10.0,
                  top: height / 2.5,
                ),
                child: Column(
                  children: [
                    Text(
                      'Welcome to the DHIS2 demo app.',
                      style: const TextStyle().copyWith(
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                          fontSize: 18.0),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Let\'s explore the available Programs!',
                      style: const TextStyle()
                          .copyWith(color: Colors.white, fontSize: 12.0),
                    ),
                  ],
                ),
              ),
              Visibility(
                visible: loading,
                child: Container(
                  margin: const EdgeInsets.symmetric(
                    vertical: 10.0,
                  ),
                  child: const Center(
                    child: CircularLoader(),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: loading
          ? null
          : FloatingActionButton.extended(
              onPressed: () => onNavigateToLogin(context),
              label: const Text('Login'),
              icon: const Icon(Icons.login),
              backgroundColor: Colors.white,
              foregroundColor: AppConstants.defaultColor,
            ),
    );
  }
}
