import 'dart:convert';

import 'package:dhis2_demo_app/core/constants/app_constants.dart';
import 'package:dhis2_demo_app/core/services/http_service.dart';
import 'package:dhis2_demo_app/core/utils/app_utils.dart';
import 'package:dhis2_demo_app/modules/home/models/program.dart';

class ProgramService {
  Future<List<Program>> getDHIS2Programs({
    required String username,
    required String password,
  }) async {
    List<Program> programs = [];

    var serverUrl = AppConstants.serverUrl;
    var apiUrl = 'api/programs.json';
    var queryParameters = {
      'fields':
          'id,displayName,displayShortName,created,lastUpdated,programType,programStages[id,displayName,programStageDataElements[dataElement[id,displayName,valueType],compulsory]],programTrackedEntityAttributes[mandatory,trackedEntityAttribute[id,displayName,valueType]]',
      'paging': 'false',
    };

    HttpService http = HttpService(
      username: username,
      password: password,
      serverUrl: serverUrl,
    );

    try {
      var response =
          await http.httpGet(apiUrl, queryParameters: queryParameters);
      if (response.statusCode == 200) {
        var body = json.decode(response.body);
        for (var program in (body['programs'] ?? [])) {
          programs.add(Program.fromJson(program));
        }
      } else if (response.statusCode >= 400) {
        Map body = json.decode(response.body);
        String message =
            '${body['message'] ?? 'Failed to login to $serverUrl'}';
        AppUtils.showToastMessage(message: message);
      }
    } catch (e) {
      AppUtils.showToastMessage(message: e.toString());
    }
    return programs;
  }

  Future<void> uploadProgramSummaryToDataStore({
    required String username,
    required String password,
    required dynamic data,
  }) async {
    AppUtils.showToastMessage(
      message: 'saving program summary in data store!',
    );

    String dataStoreKey = 'dhis2ProgramsEvaluator';
    var serverUrl = AppConstants.serverUrl;
    var apiUrl = 'api/dataStore/$dataStoreKey/${data['id']}';

    HttpService http = HttpService(
      username: username,
      password: password,
      serverUrl: serverUrl,
    );

    var sanitizedData = jsonEncode(data);

    await http.httpPost(apiUrl, sanitizedData).then((response) {
      if (response.statusCode == 200) {
        AppUtils.showToastMessage(
          message: 'Program summary saved in data store!',
        );
      } else {
        var body = json.decode(response.body);
        AppUtils.showToastMessage(
          message: body['message'],
        );
      }
    }).catchError((error) {
      AppUtils.showToastMessage(
        message: error.toString(),
      );
    });
  }
}
