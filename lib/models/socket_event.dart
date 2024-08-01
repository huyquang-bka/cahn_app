class SocketEvent {
  final String name;
  final String time;
  final String image; // base64 encoded string
  final int cameraId;
  final int? key;
  String? cameraName;

  SocketEvent({
    required this.name,
    required this.time,
    required this.image,
    required this.cameraId,
    required this.key,
    this.cameraName,
  });

  factory SocketEvent.fromJson(Map<String, dynamic> json) {
    return SocketEvent(
      name: json['name'],
      time: json['time'],
      image: json['image'],
      cameraId: json['cameraId'],
      key: json['key'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'time': time,
      'image': image,
      'cameraId': cameraId,
      'key': key,
    };
  }
}