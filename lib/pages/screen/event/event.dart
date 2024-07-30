import 'dart:convert';
import 'package:cahn_app/configs/api_route.dart';
import 'package:cahn_app/models/config.dart';
import 'package:cahn_app/networks/http.dart';
import 'package:cahn_app/pages/screen/event/event_field.dart';
import 'package:cahn_app/pages/screen/event/filter_field.dart';
import 'package:cahn_app/pages/screen/event/pagination_field.dart';
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
  List<Area> areas = [Area(text: "")];
  List<Camera> cameras = [Camera(text: "")];
  List<Event> events = [];
  Config? config;
  String filterString = "";

  //pagination
  int currentPage = 1;
  int itemsPerPage = 10;
  int totalEvent = 0;


  @override
  void initState() {
    super.initState();
    _initialize();
  }

  Future<void> _initialize() async {
    await loadConfig();
    if (config != null) {
      await fetchCameraAndArea();
      await fetchEvent();
    }
  }

  Future<void> loadConfig() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? configPref = prefs.getString('config');
    if (configPref != null) {
      config = Config.fromString(configPref);
    }
  }

  Future<void> fetchCameraAndArea() async {
    // Fetch data from API
    List<Future<dynamic>> futures = [
      client.get("${config?.baseUrl}$uriGetArea"),
      client.get("${config?.baseUrl}$uriGetCamera"),
    ];
    List<dynamic> results = await Future.wait(futures);

    List<dynamic> areaData = jsonDecode(results[0].body);
    List<dynamic> cameraData = jsonDecode(results[1].body);
    List<Area> fetchAreas = areaData.map((area) => Area.fromJson(area)).toList();
    List<Camera> fetchCameras = cameraData.map((camera) => Camera.fromJson(camera)).toList();
    setState(() {
      areas.addAll(fetchAreas);
      cameras.addAll(fetchCameras);
    });
    
  }

  Future<void> fetchEvent() async {
    // Fetch data from API
    String filter = "sortBy=accessDate&sortDesc=true&status=&object=1&page=$currentPage&itemsPerPage=$itemsPerPage&";
    filter += filterString;
    String url = "${config?.baseUrl}$uriGetEvent?$filter";
    print("URL: $url");
    List<Future<dynamic>> futures = [
      client.get(url),
    ];
    List<dynamic> results = await Future.wait(futures);
    Map<dynamic, dynamic> resultJson = jsonDecode(results[0].body);
    List<dynamic> eventData = resultJson['data'];
    List<Event> fetchEvents = eventData.map((event) => Event.fromJson(event)).toList();
    setState(() {
      totalEvent = resultJson['totalRows'];
      events = fetchEvents;
      print("Number of events: ${events.length}");
      print("Total events: $totalEvent");
    });
  }

  void onItemsPerPageChange(int value) {
    setState(() {
      itemsPerPage = value;
    });
  }

  void onCurrentPageChange(int value) {
    setState(() {
      currentPage = value;
    });
  }

  void onSearch(String filterString) {
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
          // pagination with choose number of items per page (10, 20, 50) and page number with next and previous button
          PaginationField(totalEvent: totalEvent),
        ],
      ),
    );
  }
}
