import 'dart:convert';

class Setting {
  final bool? isDarkMode;
  final int? numCamera;
  final List<String>? cameraList;
  final bool saveAccount; 
  

  Setting({this.isDarkMode, this.numCamera, this.cameraList, this.saveAccount=true});

  factory Setting.fromJson(Map<String, dynamic> json) {
    return Setting(
      isDarkMode: json['is_dark_mode'],
      numCamera: json['num_camera'],
      cameraList: json['camera_list'],
      saveAccount: json['save_account'],
    );
  }

  factory Setting.fromString(String? jsonString) {
    return jsonString != null ? Setting.fromJson(jsonDecode(jsonString)) : Setting();
  }

  Map<String, dynamic> toJson() {
    return {
      'is_dark_mode': isDarkMode,
      'num_camera': numCamera,
      'camera_list': cameraList,
      'save_account': saveAccount,
    };
  }

  String encodeToString() {
    return jsonEncode(toJson());
  }
}