import 'dart:convert';
import 'package:cahn_app/configs/api_route.dart';
import 'package:cahn_app/models/config.dart';
import 'package:cahn_app/networks/http.dart';
import 'package:cahn_app/pages/screen/event/event_field.dart';
import 'package:cahn_app/pages/screen/event/filter_field.dart';
import 'package:flutter/material.dart';
import 'package:cahn_app/models/area.dart';
import 'package:cahn_app/models/camera.dart';
import 'package:cahn_app/models/event.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EventScreen extends StatefulWidget {
  const EventScreen({super.key});

  @override
  State<EventScreen> createState() => _EventScreenState();
}

class _EventScreenState extends State<EventScreen> {
  CustomHttpClient client = CustomHttpClient();
  List<Area> areas = [];
  List<Camera> cameras = [];
  List<Event> events = [];
  Config? config;

  @override
  void initState() {
    super.initState();
    _initialize();
  }

  Future<void> _initialize() async {
    await loadConfig();
    if (config != null) {
      await fetchCameraAndArea();
    }
  }

  Future<void> loadConfig() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? configPref = prefs.getString('config');
    if (configPref != null) {
      config = Config.fromString(configPref);
      print("Config loaded: ${config?.baseUrl}");
    }
  }

  Future<void> fetchCameraAndArea() async {
    // Fetch data from API
    print("Fetching data from host: ${config?.baseUrl}");
    List<Future<dynamic>> futures = [
      client.get("${config?.baseUrl}$uriGetArea"),
      client.get("${config?.baseUrl}$uriGetCamera"),
    ];
    List<dynamic> results = await Future.wait(futures);

    List<dynamic> areaData = jsonDecode(results[0].body);
    List<dynamic> cameraData = jsonDecode(results[1].body);

    setState(() {
      areas = areaData.map((area) => Area.fromJson(area)).toList();
      cameras = cameraData.map((camera) => Camera.fromJson(camera)).toList();
    });
    
  }

  void onSearch() {
    print("Searching...");
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          // Filter Field
          FilterField(areas: areas, cameras: cameras, onSearch: onSearch),
          // Event List
          EventField(events: events),
        ],
      ),
    );
  }
}
