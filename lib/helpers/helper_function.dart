import 'dart:convert';

import 'package:cahn_app/configs/api_route.dart';
import 'package:cahn_app/models/area.dart';
import 'package:cahn_app/models/camera.dart';
import 'package:cahn_app/models/config.dart';
import 'package:cahn_app/networks/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

//helper function
String findNameById(int id, List<dynamic> items) {
  String name = "Không xác định";
  for (dynamic item in items) {
    if (item.id == id) {
      name = item.name!;
      break;
    }
  }
  // print("name by id: $name");
  return name;
}

int findIdByName(String name, List<dynamic> items) {
  int id = 0;
  for (dynamic item in items) {
    if (item.name == name) {
      id = item.id!;
      break;
    }
  }
  return id;
}

int findCompanyIdByName(String name, List<dynamic> items) {
  dynamic item = items.firstWhere((element) => element.name == name);
  return item.idCompany!;
}

String convertToUtf8(String text) {
  final List<int> bytes = text.toString().codeUnits;
  return utf8.decode(bytes);
}


String convertDateToUrlEncoded(String dateString) {
  // First, replace the space with '%20'
  String spaceSeparated = dateString.replaceAll(' ', '%20');
  // Finally, replace the colon with '%3A'
  return spaceSeparated.replaceAll(':', '%3A');
}

Future<Config> loadConfig() async {
    //set config to shared preferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? configString = prefs.getString('config');
    print("configString: $configString");
    Config loadedConfig = Config.fromString(configString);
    return loadedConfig;
  }

Future<List<dynamic>> fetchCameraAndArea(CustomHttpClient client, Config? config) async {
    // Fetch data from API
    List<Area> fetchAreas = [];
    List<Camera> fetchCameras = [];

    List<Future<dynamic>> futures = [
      client.get("${config?.baseUrl}$uriGetArea"),
      client.get("${config?.baseUrl}$uriGetCamera"),
    ];
    // try
    // {
      List<dynamic> results = await Future.wait(futures);
      List<dynamic> areaData = jsonDecode(results[0].body);
      List<dynamic> cameraData = jsonDecode(results[1].body)["data"];
      fetchAreas = areaData.map((area) => Area.fromJson(area)).toList();
      fetchCameras = cameraData.map((camera) => Camera.fromJson(camera)).toList();
    // }
    // catch (e) {
    //   print("Error from fetch camera: $e");
    // }
    return [fetchAreas, fetchCameras];
  }