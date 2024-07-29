import 'dart:convert';

class Event {
  String eventId;
  String personId;
  DateTime accessDate;
  int deviceId;
  String image;
  String? video;
  String? fullname;
  String? personCode;
  double? scoreMatch;
  DateTime syncDatetime;
  int areaId;
  int status;
  int deviceType;
  int checkCar;
  bool isDelete;
  bool isBlackList;
  String? gender;
  int? age;
  String? features;
  double? score;
  bool? isEmployee;
  int isEmployeeOther;
  int eventDeviceType;
  int? faceTerminalId;
  String? faceTerminalName;
  String? faceType;
  String? meetingId;
  int compId;
  String? deptName;
  String areaStr;
  String statusStr;
  String objectStr;
  String accessDateStr;
  String typeStr;
  int checkArea;
  String? guestId;

  Event({
    required this.eventId,
    required this.personId,
    required this.accessDate,
    required this.deviceId,
    required this.image,
    this.video,
    this.fullname,
    this.personCode,
    this.scoreMatch,
    required this.syncDatetime,
    required this.areaId,
    required this.status,
    required this.deviceType,
    required this.checkCar,
    required this.isDelete,
    required this.isBlackList,
    this.gender,
    this.age,
    this.features,
    this.score,
    this.isEmployee,
    required this.isEmployeeOther,
    required this.eventDeviceType,
    this.faceTerminalId,
    this.faceTerminalName,
    this.faceType,
    this.meetingId,
    required this.compId,
    this.deptName,
    required this.areaStr,
    required this.statusStr,
    required this.objectStr,
    required this.accessDateStr,
    required this.typeStr,
    required this.checkArea,
    this.guestId,
  });

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      eventId: json['eventId'],
      personId: json['personId'],
      accessDate: DateTime.parse(json['accessDate']),
      deviceId: json['deviceId'],
      image: json['image'],
      video: json['video'],
      fullname: json['fullname'],
      personCode: json['personCode'],
      scoreMatch: json['scoreMatch'] != null ? json['scoreMatch'].toDouble() : null,
      syncDatetime: DateTime.parse(json['syncDatetime']),
      areaId: json['areaId'],
      status: json['status'],
      deviceType: json['deviceType'],
      checkCar: json['checkCar'],
      isDelete: json['isDelete'],
      isBlackList: json['isBlackList'],
      gender: json['gender'],
      age: json['age'],
      features: json['features'],
      score: json['score'] != null ? json['score'].toDouble() : null,
      isEmployee: json['isEmployee'],
      isEmployeeOther: json['isEmployeeOther'],
      eventDeviceType: json['eventDeviceType'],
      faceTerminalId: json['faceTerminalId'],
      faceTerminalName: json['faceTerminalName'],
      faceType: json['faceType'],
      meetingId: json['meetingId'],
      compId: json['compId'],
      deptName: json['deptName'],
      areaStr: json['areaStr'],
      statusStr: json['statusStr'],
      objectStr: json['objectStr'],
      accessDateStr: json['accessDateStr'],
      typeStr: json['typeStr'],
      checkArea: json['checkArea'],
      guestId: json['guestId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'eventId': eventId,
      'personId': personId,
      'accessDate': accessDate.toIso8601String(),
      'deviceId': deviceId,
      'image': image,
      'video': video,
      'fullname': fullname,
      'personCode': personCode,
      'scoreMatch': scoreMatch,
      'syncDatetime': syncDatetime.toIso8601String(),
      'areaId': areaId,
      'status': status,
      'deviceType': deviceType,
      'checkCar': checkCar,
      'isDelete': isDelete,
      'isBlackList': isBlackList,
      'gender': gender,
      'age': age,
      'features': features,
      'score': score,
      'isEmployee': isEmployee,
      'isEmployeeOther': isEmployeeOther,
      'eventDeviceType': eventDeviceType,
      'faceTerminalId': faceTerminalId,
      'faceTerminalName': faceTerminalName,
      'faceType': faceType,
      'meetingId': meetingId,
      'compId': compId,
      'deptName': deptName,
      'areaStr': areaStr,
      'statusStr': statusStr,
      'objectStr': objectStr,
      'accessDateStr': accessDateStr,
      'typeStr': typeStr,
      'checkArea': checkArea,
      'guestId': guestId,
    };
  }

  static List<Event> listFromJson(String jsonString) {
    final data = jsonDecode(jsonString) as List<dynamic>;
    return data.map((item) => Event.fromJson(item)).toList();
  }

  static String listToJson(List<Event> events) {
    final data = events.map((event) => event.toJson()).toList();
    return jsonEncode(data);
  }
}
