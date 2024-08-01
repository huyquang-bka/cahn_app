import 'dart:convert';

class Config {
  String websocketUrl;
  String baseUrl;
  List<dynamic> listCameraId;

  Config({this.websocketUrl = 'ws://192.168.1.195:6299', this.baseUrl = 'http://192.168.1.210:42013', this.listCameraId = const []});

  factory Config.fromJson(Map<String, dynamic> json) {
    return Config(
      websocketUrl: json['websocketUrl'] ?? "ws://192.168.1.195:6299",
      baseUrl: json['baseUrl'] ?? "http://192.168.1.210:42013",
      listCameraId: json['listCameraId'] ?? [],
    );
  }

  factory Config.fromString(String? jsonString) {
    return jsonString != null ? Config.fromJson(jsonDecode(jsonString)) : Config();
  }

  Map<String, dynamic> toJson() {
    return {
      'websocketUrl': websocketUrl,
      'baseUrl': baseUrl,
      'listCameraId': listCameraId,
    };
  }

  String encodeToString() {
    return jsonEncode(toJson());
  }
}