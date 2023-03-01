import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class HttpService {
  final String? username;
  final String? password;
  final String? serverUrl;
  String? basicAuth;

  HttpService({
    required this.username,
    required this.password,
    required this.serverUrl,
  }) {
    basicAuth = base64Encode(utf8.encode('$username:$password'));
  }

  String get domainPath {
    return serverUrl!
        .replaceAll('https://', '')
        .replaceAll('http://', '')
        .split('/')
        .where((domain) => domain != domainHost && domain.isNotEmpty)
        .toList()
        .join('/');
  }

  String get domainHost {
    return serverUrl!
        .replaceAll('https://', '')
        .replaceAll('http://', '')
        .split('/')
        .first;
  }

  Uri getApiUrl(String url, {Map<String, dynamic>? queryParameters}) {
    url = domainPath == '' ? url : '$domainPath/$url';
    return Uri.https(domainHost, url, queryParameters);
  }

  Future<http.Response> httpPost(
    String url,
    body, {
    Map<String, dynamic>? queryParameters,
  }) async {
    Uri apiUrl = getApiUrl(url, queryParameters: queryParameters);
    return http.post(
      apiUrl,
      headers: {
        HttpHeaders.authorizationHeader: 'Basic $basicAuth',
        'Content-Type': 'application/json',
      },
      body: body,
    );
  }

  Future<http.Response> httpPut(
    String url,
    body, {
    Map<String, dynamic>? queryParameters,
  }) async {
    Uri apiUrl = getApiUrl(url, queryParameters: queryParameters);
    return http.put(
      apiUrl,
      headers: {
        HttpHeaders.authorizationHeader: 'Basic $basicAuth',
        'Content-Type': 'application/json',
      },
      body: body,
    );
  }

  Future<http.Response> httpDelete(
    String url, {
    Map<String, dynamic>? queryParameters,
  }) async {
    Uri apiUrl = getApiUrl(url, queryParameters: queryParameters);
    return await http.delete(apiUrl, headers: {
      HttpHeaders.authorizationHeader: 'Basic $basicAuth',
    });
  }

  Future<http.Response> httpGet(
    String url, {
    Map<String, dynamic>? queryParameters,
  }) async {
    Uri apiUrl = getApiUrl(url, queryParameters: queryParameters);
    return await http.get(apiUrl, headers: {
      HttpHeaders.authorizationHeader: 'Basic $basicAuth',
    });
  }

  @override
  String toString() {
    return '$serverUrl => $username : $password';
  }
}
