import 'dart:convert';

class Camera {
  int? id;
  int? compId;
  String? deviceCode;
  String? deviceName;
  String? text;
  String? rtspLink;
  String? url;
  int? deviceType;
  int? status;
  int? areaId;
  String? areaName;
  String? areaCode;

  Camera({
    this.id,
    this.compId,
    this.deviceCode,
    this.deviceName,
    this.text,
    this.rtspLink,
    this.url,
    this.deviceType,
    this.status,
    this.areaId,
    this.areaName,
    this.areaCode,
  });

  factory Camera.fromJson(Map<String, dynamic> json) {
    return Camera(
      id: json['id'],
      compId: json['compId'],
      deviceCode: json['deviceCode'],
      deviceName: json['deviceName'],
      text: json['deviceName'],
      rtspLink: json['rtspLink'],
      url: json['url'],
      deviceType: json['deviceType'],
      status: json['status'],
      areaId: json['areaId'],
      areaName: json['areaName'],
      areaCode: json['areaCode'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'compId': compId,
      'deviceCode': deviceCode,
      'deviceName': deviceName,
      'text': text,
      'rtspLink': rtspLink,
      'url': url,
      'deviceType': deviceType,
      'status': status,
      'areaId': areaId,
      'areaName': areaName,
      'areaCode': areaCode,
    };
  }

  static List<Camera> listFromJson(String jsonString) {
    final data = json.decode(jsonString) as List<dynamic>;
    return data.map((item) => Camera.fromJson(item)).toList();
  }

  static String listToJson(List<Camera> areas) {
    final data = areas.map((area) => area.toJson()).toList();
    return json.encode(data);
  }
}
