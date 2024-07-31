import 'dart:convert';
import 'package:cahn_app/configs/api_route.dart';
import 'package:cahn_app/helpers/helper_function.dart';
import 'package:cahn_app/models/config.dart';
import 'package:cahn_app/networks/http.dart';
import 'package:cahn_app/pages/screen/event/event_field.dart';
import 'package:cahn_app/pages/screen/event/filter_field.dart';
import 'package:cahn_app/pages/screen/event/pagination_field.dart';
import 'package:flutter/material.dart';
import 'package:cahn_app/models/area.dart';
import 'package:cahn_app/models/camera.dart';
import 'package:cahn_app/models/event.dart';

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
  bool isEventFieldLoading = false;

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
    await loadConfig().then((value) => config = value);
    if (config != null) {
      await loadAreaAndCamera();
      await fetchEvent();
    }
  }


  Future<void> loadAreaAndCamera() async {
    List<dynamic> results = await fetchCameraAndArea(client, config);
    setState(() {
      areas.addAll(results[0]);
      cameras.addAll(results[1]);
    });
  }

  Future<void> fetchEvent() async {
    setState(() {
      isEventFieldLoading = true;
    });
    // Fetch data from API
    String filter = "sortBy=accessDate&sortDesc=true&status=&object=1&page=$currentPage&itemsPerPage=$itemsPerPage&";
    filter += filterString;
    String url = "${config?.baseUrl}$uriGetEvent?$filter";
    print("URL: $url");
    List<Future<dynamic>> futures = [
      client.get(url),
    ];
    try{
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
    catch(e){
      print("Error: $e");
    }
    setState(() {
      isEventFieldLoading = false;
    });
  }

  void onItemsPerPageChange(int value) {
    setState(() {
      itemsPerPage = value;
      currentPage = 1;
    });
    fetchEvent();
  }

  void onCurrentPageChange(int value) {
    setState(() {
      currentPage = value;
    });
    fetchEvent();
  }

  void onSearch(String filterString) {
    this.filterString = filterString;
    currentPage = 1;
    fetchEvent();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          // Filter Field
          Expanded(flex: 3, child: FilterField(areas: areas, cameras: cameras, onSearch: onSearch)),
          // Event List
          Expanded(flex: 8, 
          child: isEventFieldLoading ? const Center(child: CircularProgressIndicator()) : EventField(events: events, fromIndex: (currentPage - 1) * itemsPerPage)
          ),
          // pagination with choose number of items per page (10, 20, 50) and page number with next and previous button
          Expanded(flex: 1, child: PaginationField(totalEvent: totalEvent, currentPage: currentPage, itemsPerPage: itemsPerPage, onCurrentPageChanged: onCurrentPageChange, onItemsPerPageChanged: onItemsPerPageChange)),
        ],
      ),
    );
  }
}
