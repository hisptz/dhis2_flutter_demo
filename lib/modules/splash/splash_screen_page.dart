import 'dart:async';

import 'package:dhis2_demo_app/core/components/circular_loader.dart';
import 'package:dhis2_demo_app/core/constants/app_constants.dart';
import 'package:dhis2_demo_app/modules/login/login_page.dart';
import 'package:flutter/material.dart';

class SplashScreenPage extends StatefulWidget {
  const SplashScreenPage({super.key});

  @override
  State<SplashScreenPage> createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  late bool loading;

  void setLoadingState(bool state) {
    setState(() {
      loading = state;
    });
  }

  @override
  void initState() {
    setLoadingState(true);
    Timer(const Duration(seconds: 2), () {
      // TODO check login status
      setLoadingState(false);
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
