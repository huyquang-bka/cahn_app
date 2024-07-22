import 'dart:convert';

class Setting {
  final bool? isDarkMode;
  final int? numCamera;
  final List<int>? cameraList;
  

  Setting({this.isDarkMode, this.numCamera, this.cameraList});

  factory Setting.fromJson(Map<String, dynamic> json) {
    return Setting(
      isDarkMode: json['is_dark_mode'],
      numCamera: json['num_camera'],
      cameraList: json['camera_list'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'is_dark_mode': isDarkMode,
      'num_camera': numCamera,
      'camera_list': cameraList,
    };
  }

  String encodeToString() {
    return jsonEncode(toJson());
  }
}

void main()
{
  final Map<String, dynamic> json = {
    'is_dark_mode': true,
    'num_camera': 2,
    'camera_list': [1, 2]
  };
  
  final setting = Setting.fromJson(json);
  final String encoded = setting.encodeToString();
  print(encoded);
}