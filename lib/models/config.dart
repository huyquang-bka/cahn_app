import 'dart:convert';

class Config {
  String baseUrl;

  Config({this.baseUrl='http://192.168.1.210:42013'});

  factory Config.fromJson(Map<String, dynamic> json) {
    return Config(
      baseUrl: json['baseUrl'],
    );
  }

  factory Config.fromString(String? jsonString) {
    return jsonString != null ? Config.fromJson(jsonDecode(jsonString)) : Config();
  }

  Map<String, dynamic> toJson() {
    return {
      'baseUrl': baseUrl,
    };
  }
}