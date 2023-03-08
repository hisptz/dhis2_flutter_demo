import 'package:dhis2_demo_app/core/components/circular_loader.dart';
import 'package:dhis2_demo_app/core/components/password_input_field_container.dart';
import 'package:dhis2_demo_app/core/components/text_input_field_container.dart';
import 'package:dhis2_demo_app/core/constants/app_constants.dart';
import 'package:dhis2_demo_app/core/models/input_field.dart';
import 'package:dhis2_demo_app/core/utils/app_utils.dart';
import 'package:dhis2_demo_app/modules/home/pages/home_page.dart';
import 'package:dhis2_demo_app/modules/login/constants/login_constants.dart';
import 'package:dhis2_demo_app/modules/login/models/user.dart';
import 'package:dhis2_demo_app/modules/login/services/user_service.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  Map<String, String> loginFormData = {};
  var inputFields = LoginConstants.getLoginFormInputs();
  late bool loggingIn;

  @override
  void initState() {
    setLoggingInState(false);
    updatedLoginFormData('serverUrl', AppConstants.serverUrl);
    super.initState();
  }

  void setLoggingInState(bool state) {
    setState(() {
      loggingIn = state;
    });
  }

  void onLogIn(BuildContext context) {
    if (inputFields.map((inputField) => inputField.id).every(
          (inputFieldId) => _isValueFilled(inputFieldId),
        )) {
      setLoggingInState(true);
      var username = loginFormData['username'] ?? '';
      var serverUrl = loginFormData['serverUrl'] ?? '';
      var password = loginFormData['password'] ?? '';

      UserService()
          .login(
        username: username,
        password: password,
        serverUrl: serverUrl,
      )
          .then((User? currentUser) {
        if (currentUser != null) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (_) => HomePage(
                currentUser: currentUser,
              ),
            ),
          );
        }
        setLoggingInState(false);
      }).catchError((error) {
        setLoggingInState(false);
        AppUtils.showToastMessage(
          message: error.toString(),
        );
      });
    } else {
      setLoggingInState(false);
      AppUtils.showToastMessage(
        message: 'Make sure all fields are filled!',
      );
    }
  }

  bool _isValueFilled(String id) {
    return (loginFormData[id] ?? '').isNotEmpty;
  }

  void updatedLoginFormData(String key, String value) {
    setState(() {
      loginFormData[key] = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.longestSide;
    return Scaffold(
      backgroundColor: AppConstants.defaultColor,
      body: SafeArea(
        child: Center(
          child: SizedBox(
            height: height / 2,
            child: Center(
              child: Container(
                margin: const EdgeInsets.symmetric(
                  vertical: 25.0,
                  horizontal: 10.0,
                ),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: AppConstants.defaultColor,
                      blurRadius: 5,
                    )
                  ],
                  borderRadius: BorderRadius.all(
                    Radius.circular(5.0),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.all(
                          10.0,
                        ),
                        child: Text(
                          'DHIS2 Demo App login',
                          style: const TextStyle().copyWith(
                            fontWeight: FontWeight.w700,
                            color: AppConstants.defaultColor,
                            fontSize: 18.0,
                          ),
                        ),
                      ),
                      ...LoginConstants.getLoginFormInputs()
                          .map(
                            (InputField inputField) => inputField.valueType ==
                                    'TEXT'
                                ? TextInputFieldContainer(
                                    inputField: inputField,
                                    inputValue: loginFormData[inputField.id],
                                    onInputValueChange: (String value) =>
                                        updatedLoginFormData(
                                      inputField.id,
                                      value,
                                    ),
                                  )
                                : inputField.valueType == 'PASSWORD'
                                    ? PasswordInputFieldContainer(
                                        inputField: inputField,
                                        inputValue:
                                            loginFormData[inputField.id],
                                        onInputValueChange: (String value) =>
                                            updatedLoginFormData(
                                          inputField.id,
                                          value,
                                        ),
                                      )
                                    : Container(),
                          )
                          .toList(),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppConstants.defaultColor,
                          foregroundColor: Colors.white,
                          minimumSize: const Size.fromHeight(50),
                          textStyle: const TextStyle(
                            fontSize: 20,
                          ),
                        ),
                        onPressed: () =>
                            loggingIn == true ? null : onLogIn(context),
                        child: loggingIn == true
                            ? const CircularLoader(
                                size: 2.0,
                              )
                            : const Text('Login'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
