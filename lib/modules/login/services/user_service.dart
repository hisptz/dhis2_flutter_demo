import 'dart:convert';

import 'package:dhis2_demo_app/core/services/http_service.dart';
import 'package:dhis2_demo_app/core/services/preference_service.dart';
import 'package:dhis2_demo_app/core/utils/app_utils.dart';
import 'package:dhis2_demo_app/modules/login/models/user.dart';

class UserService {
  static const passwordPreferenceKey = 'current_password';
  static const usernamePreferenceKey = 'current_username';

  Future<User?> login({
    required String username,
    required String password,
    required String serverUrl,
  }) async {
    User? user;
    try {
      var url = 'api/me.json';
      var queryParameters = {
        'fields':
            'id,name,email,gender,phoneNumber,introduction,jobTitle,birthday,nationality,employer,education,interests,languages,userCredentials[userRoles[name]],organisationUnits[id],userGroups[name],authorities,dataSets,programs'
      };
      HttpService http = HttpService(
        username: username,
        password: password,
        serverUrl: serverUrl,
      );
      var response = await http.httpGet(url, queryParameters: queryParameters);
      if (response.statusCode == 200) {
        user = User.fromJson(
          json.decode(response.body),
          username,
          password,
          serverUrl,
        );
        _setCurrentUserCredentials(
          username: username,
          password: password,
        );
      } else if (response.statusCode >= 400) {
        Map body = json.decode(response.body);
        String message =
            '${body['message'] ?? 'Failed to login to $serverUrl'}';
        AppUtils.showToastMessage(message: message);
      }
      return user;
    } catch (error) {
      rethrow;
    }
  }

  _setCurrentUserCredentials({
    required String username,
    required String password,
  }) {
    PreferenceService.setPreferenceValue(usernamePreferenceKey, username);
    PreferenceService.setPreferenceValue(passwordPreferenceKey, password);
  }

  Future<void> logout() async {
    await PreferenceService.removePreferenceKey(usernamePreferenceKey);
    await PreferenceService.removePreferenceKey(passwordPreferenceKey);
  }

  Future<Map<String, dynamic>> getCurrentUserCredentials() async {
    var username =
        await PreferenceService.getPreferenceValue(usernamePreferenceKey);
    var password =
        await PreferenceService.getPreferenceValue(passwordPreferenceKey);

    return username == null || password == null
        ? {}
        : {
            'username': username,
            'password': password,
          };
  }
}
