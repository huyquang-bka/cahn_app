class Event {
  int? deviceId;
  String? image;
  String? video;
  String? fullname;
  String? gender;
  int? age;
  bool? isEmployee;
  int? isEmployeeOther;
  String? faceTerminalName;
  String? areaStr;
  String accessDateStr;
  String? personCode;
  String typeStr;

  Event({
    required this.deviceId,
    required this.image,
    this.video,
    this.fullname,
    this.gender,
    this.age,
    this.isEmployee,
    required this.isEmployeeOther,
    this.faceTerminalName,
    required this.areaStr,
    required this.accessDateStr,
    required this.personCode,
    required this.typeStr,
  });

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      deviceId: json['deviceId'],
      image: json['image'],
      video: json['video'],
      fullname: json['fullname'],
      gender: json['gender'] == 0 ? "Nữ" : "Nam",
      age: json['age'],
      isEmployee: json['isEmployee'],
      isEmployeeOther: json['isEmployeeOther'],
      faceTerminalName: json['faceTerminalName'],
      areaStr: json['areaStr'],
      accessDateStr: json['accessDateStr'],
      personCode: json['personCode'],
      typeStr: json['typeStr'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'deviceId': deviceId,
      'image': image,
      'video': video,
      'fullname': fullname,
      'gender': gender,
      'age': age,
      'isEmployee': isEmployee,
      'isEmployeeOther': isEmployeeOther,
      'faceTerminalName': faceTerminalName,
      'areaStr': areaStr,
      'accessDateStr': accessDateStr,
      'personCode': personCode,
      'typeStr': typeStr,
    };
  }
}
