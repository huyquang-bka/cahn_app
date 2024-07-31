import 'dart:convert';

class Config {
  String baseUrl;
  List<dynamic> listCameraId;

  Config({this.baseUrl = 'http://192.168.1.210:42013', this.listCameraId = const []});

  factory Config.fromJson(Map<String, dynamic> json) {
    return Config(
      baseUrl: json['baseUrl'] ?? "http://192.168.1.210:42013",
      listCameraId: json['listCameraId'] ?? [],
    );
  }

  factory Config.fromString(String? jsonString) {
    return jsonString != null ? Config.fromJson(jsonDecode(jsonString)) : Config();
  }

  Map<String, dynamic> toJson() {
    return {
      'baseUrl': baseUrl,
      'listCameraId': listCameraId,
    };
  }

  String encodeToString() {
    return jsonEncode(toJson());
  }
}