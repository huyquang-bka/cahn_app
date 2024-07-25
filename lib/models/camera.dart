import 'dart:convert';

class Camera {
  int id;
  String deviceName;
  String rstpLink;
  int deviceType;
  int compId;
  String lstFeature;
  List<int> listFeature;
  String url;
  List<dynamic>? listPolygon;
  bool isDelete;
  dynamic polygon;
  String areaCode;
  String deviceCode;

  Camera({
    required this.id,
    required this.deviceName,
    required this.rstpLink,
    required this.deviceType,
    required this.compId,
    required this.lstFeature,
    required this.listFeature,
    required this.url,
    this.listPolygon,
    required this.isDelete,
    this.polygon,
    required this.areaCode,
    required this.deviceCode,
  });

  factory Camera.fromJson(Map<String, dynamic> json) {
    return Camera(
      id: json['id'],
      deviceName: json['deviceName'],
      rstpLink: json['rstpLink'],
      deviceType: json['deviceType'],
      compId: json['compId'],
      lstFeature: json['lstFeature'],
      listFeature: List<int>.from(json['listFeature']),
      url: json['url'],
      listPolygon: json['listPolygon'],
      isDelete: json['isDelete'],
      polygon: json['polygon'],
      areaCode: json['areaCode'],
      deviceCode: json['deviceCode'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'deviceName': deviceName,
      'rstpLink': rstpLink,
      'deviceType': deviceType,
      'compId': compId,
      'lstFeature': lstFeature,
      'listFeature': listFeature,
      'url': url,
      'listPolygon': listPolygon,
      'isDelete': isDelete,
      'polygon': polygon,
      'areaCode': areaCode,
      'deviceCode': deviceCode,
    };
  }

  static List<Camera> listFromJson(String jsonString) {
    final data = json.decode(jsonString) as List<dynamic>;
    return data.map((item) => Camera.fromJson(item)).toList();
  }

  static String listToJson(List<Camera> cameras) {
    final data = cameras.map((camera) => camera.toJson()).toList();
    return json.encode(data);
  }
}
