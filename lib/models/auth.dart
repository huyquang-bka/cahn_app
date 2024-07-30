import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class Auth {
  final String? accessToken;
  final String? refreshToken;
  final String? fullName;
  final int? companyId;
  final int? userId;
  final String? company;
  String? username;
  String? password;

  Auth({this.accessToken, this.refreshToken, this.fullName, this.companyId, this.userId, this.company, this.username, this.password});

  factory Auth.fromJson(Map<String, dynamic> json) {
    return Auth(
      accessToken: json['access_token'],
      refreshToken: json['refresh_token'],
      fullName: json['fullName'],
      companyId: json['companyId'],
      userId: json['userId'],
      company: json['company'],
      username: json['username'],
      password: json['password'],
    );
  }

  factory Auth.fromString(String? jsonString) {
    return jsonString != null ? Auth.fromJson(jsonDecode(jsonString)) : Auth();
  }

  Map<String, dynamic> toJson() {
    return {
      'access_token': accessToken,
      'refresh_token': refreshToken,
      'fullName': fullName,
      'companyId': companyId,
      'userId': userId,
      'company': company,
      'username': username,
      'password': password,
    };
  }

  String encodeToString() {
    return jsonEncode(toJson());
  }

  void signOut()
  {
    SharedPreferences.getInstance().then((prefs) {
      prefs.remove('auth');
    });
  }
  
  Map<String, String> payloadSignIn()
  { 
    return {
      "username": username!,
      "password": password!,
      "grant_type": "password",
      "client_id": "HVQP_Cloud",
      "client_secret": "1a82f1d60ba6353bb64a8fb4b05e4bc4"
    };
  }
}