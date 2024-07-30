import 'dart:convert';

class Camera {
  String? id;
  String? value;
  String? text;
  int? filterId;
  String? code;
  bool? isDelete;
  int? compId;
  int? companyId;
  dynamic courseStatus;
  dynamic deptStatus;
  int? status;
  dynamic isDeleted;
  int? areaId;
  dynamic areaType;
  dynamic deptId;
  dynamic fieldId;
  dynamic positionId;
  dynamic fillterDate;
  dynamic startDate;
  dynamic endDate;
  String? deviceCode;
  String? areaCode;

  Camera({
    this.id,
    this.value,
    this.text,
    this.filterId,
    this.code,
    this.isDelete,
    this.compId,
    this.companyId,
    this.courseStatus,
    this.deptStatus,
    this.status,
    this.isDeleted,
    this.areaId,
    this.areaType,
    this.deptId,
    this.fieldId,
    this.positionId,
    this.fillterDate,
    this.startDate,
    this.endDate,
    this.deviceCode,
    this.areaCode,
  });

  factory Camera.fromJson(Map<String, dynamic> json) {
    return Camera(
      id: json['id'],
      value: json['value'],
      text: json['text'],
      filterId: json['filterId'],
      code: json['code'],
      isDelete: json['isDelete'],
      compId: json['compId'],
      companyId: json['companyId'],
      courseStatus: json['courseStatus'],
      deptStatus: json['deptStatus'],
      status: json['status'],
      isDeleted: json['isDeleted'],
      areaId: json['areaId'],
      areaType: json['areaType'],
      deptId: json['deptId'],
      fieldId: json['fieldId'],
      positionId: json['positionId'],
      fillterDate: json['fillterDate'],
      startDate: json['startDate'],
      endDate: json['endDate'],
      deviceCode: json['deviceCode'],
      areaCode: json['areaCode'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'value': value,
      'text': text,
      'filterId': filterId,
      'code': code,
      'isDelete': isDelete,
      'compId': compId,
      'companyId': companyId,
      'courseStatus': courseStatus,
      'deptStatus': deptStatus,
      'status': status,
      'isDeleted': isDeleted,
      'areaId': areaId,
      'areaType': areaType,
      'deptId': deptId,
      'fieldId': fieldId,
      'positionId': positionId,
      'fillterDate': fillterDate,
      'startDate': startDate,
      'endDate': endDate,
      'deviceCode': deviceCode,
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
