class Area {
  final String id;
  final String value;
  final String text;
  final int filterId;
  final String code;
  final bool isDelete;
  final int compId;
  final int? companyId;
  final int? courseStatus;
  final int? deptStatus;
  final int status;
  final bool? isDeleted;
  final int areaId;
  final int areaType;
  final int? deptId;
  final int? fieldId;
  final int? positionId;
  final String? fillterDate;
  final String? startDate;
  final String? endDate;
  final String? deviceCode;
  final String? areaCode;

  Area({
    required this.id,
    required this.value,
    required this.text,
    required this.filterId,
    required this.code,
    required this.isDelete,
    required this.compId,
    this.companyId,
    this.courseStatus,
    this.deptStatus,
    required this.status,
    this.isDeleted,
    required this.areaId,
    required this.areaType,
    this.deptId,
    this.fieldId,
    this.positionId,
    this.fillterDate,
    this.startDate,
    this.endDate,
    this.deviceCode,
    this.areaCode,
  });

  factory Area.fromJson(Map<String, dynamic> json)
  {
    return Area(
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
}
