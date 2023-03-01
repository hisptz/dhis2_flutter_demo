import 'package:dhis2_demo_app/core/models/input_field.dart';

class LoginConstants {
  static List<InputField> getLoginFormInputs() {
    return [
      InputField(
        id: 'serverUrl',
        label: 'Server url',
        isReadOnly: true,
        valueType: 'TEXT',
      ),
      InputField(
        id: 'username',
        label: 'Username',
        valueType: 'TEXT',
      ),
      InputField(
        id: 'password',
        label: 'Password',
        valueType: 'PASSWORD',
      ),
    ];
  }
}
