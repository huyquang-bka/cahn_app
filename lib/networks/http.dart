import 'dart:convert';
import 'package:cahn_app/configs/api_route.dart';
import 'package:cahn_app/models/auth.dart';
import 'package:cahn_app/models/config.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class CustomHttpClient {
  Auth? _auth;
  Config? _config;

  CustomHttpClient() {
    _loadTokens();
  }

  Future<void> _loadTokens() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? authPref = prefs.getString('auth');
    final String? configPref = prefs.getString('config');
    _auth = Auth.fromString(authPref);
    _config = Config.fromString(configPref);
  }

  Future<http.Response> get(String endpoint) async {
    final response = await _getRequestWithToken(endpoint);
    if (response.statusCode == 401) {
      // Token expired, try to refresh it
      final refreshResponse = await _getNewTokenRequest();
      if (refreshResponse.statusCode == 200) {
        final body = jsonDecode(refreshResponse.body);
        Auth newAuth = Auth.fromJson(body);
        newAuth.username = _auth?.username;
        newAuth.password = _auth?.password;
        _auth = newAuth;
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('auth', jsonEncode(_auth));
        // Retry the original request with the new token
        return _getRequestWithToken(endpoint);
      }
    }
    return response;
  }

  Future<http.Response> post(String endpoint, Map<String, dynamic> body) async {
    final response = await _postRequestWithToken(endpoint, body);

    if (response.statusCode == 401) {
      // Token expired, try to refresh it
      final refreshResponse = await _getNewTokenRequest();
      if (refreshResponse.statusCode == 200) {
        final body = jsonDecode(refreshResponse.body);
        Auth newAuth = Auth.fromJson(body);
        newAuth.username = _auth?.username;
        newAuth.password = _auth?.password;
        _auth = newAuth;
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('auth', jsonEncode(_auth));
        // Retry the original request with the new token
        return _postRequestWithToken(endpoint, body);
      }
    }

    return response;
  }

  Future<http.Response> _getRequestWithToken(String endpoint) {
    final url = Uri.parse(endpoint);
    return http.get(url, headers: {
      'Authorization': 'Bearer ${_auth?.accessToken}',
    }).timeout(const Duration(seconds: 5));
  }

  Future<http.Response> _postRequestWithToken(String endpoint, Map<String, dynamic> body) {
    final url = Uri.parse(endpoint);
    return http.post(url, body: body, headers: {
      'Authorization': 'Bearer ${_auth?.accessToken}',
    }).timeout(const Duration(seconds: 5));
  }

  Future<http.Response> _getNewTokenRequest() {
    final url = Uri.parse('${_config?.baseUrl}$uriAuth');
    Map<String, String> payload = _auth!.payloadSignIn();
    print("Payload _getNewTokenRequest: $payload");
    return http.post(url, body: jsonEncode(payload), headers: {
      'Content-Type': 'application/json',
    }).timeout(const Duration(seconds: 10));
  }
}
