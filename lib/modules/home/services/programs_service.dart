import 'dart:convert';

import 'package:dhis2_demo_app/core/constants/app_constants.dart';
import 'package:dhis2_demo_app/core/services/http_service.dart';
import 'package:dhis2_demo_app/core/utils/app_utils.dart';
import 'package:dhis2_demo_app/modules/home/models/program.dart';

class ProgramService {
  Future getDHIS2Programs({
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

    var response = await http.httpGet(apiUrl, queryParameters: queryParameters);

    if (response.statusCode == 200) {
      var body = json.decode(response.body);
      for (var program in (body['programs'] ?? [])) {
        programs.add(Program.fromJson(program));
      }
    } else if (response.statusCode >= 400) {
      Map body = json.decode(response.body);
      String message = '${body['message'] ?? 'Failed to login to $serverUrl'}';
      AppUtils.showToastMessage(message: message);
    }

    return programs;
  }
}
