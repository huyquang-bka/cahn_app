import 'package:cahn_app/helpers/helper_function.dart';
import 'package:cahn_app/models/area.dart';
import 'package:cahn_app/models/camera.dart';
import 'package:cahn_app/models/config.dart';
import 'package:cahn_app/networks/http.dart';
import 'package:cahn_app/pages/screen/live/camera_field.dart';
import 'package:cahn_app/pages/screen/live/event_view.dart';
import 'package:flutter/material.dart';

class LiveViewScreen extends StatefulWidget {
  const LiveViewScreen({super.key});

  @override
  State<LiveViewScreen> createState() => _LiveViewScreenState();
}

class _LiveViewScreenState extends State<LiveViewScreen> {
  CustomHttpClient client = CustomHttpClient();
  Config config = Config();
  List<Area> areas = [Area(text: "")];
  List<Camera> cameras = [Camera(text: "")];

  final PageStorageBucket bucket = PageStorageBucket();

  @override
  void initState() {
    super.initState();
    _initialize();
  }

  Future<void> _initialize() async {
    await loadConfig().then((value) {
      config = value;
    });
    await loadAreaAndCamera();
  }

  Future<void> loadAreaAndCamera() async {
    List<dynamic> results = await fetchCameraAndArea(client, config);
    setState(() {
      areas.addAll(results[0]);
      cameras.addAll(results[1]);
    });
  }


  @override
  Widget build(BuildContext context) {
    return PageStorage(
      bucket: bucket,
      child: Row(
        children: [
          // camera field
          Expanded(
            flex: 4,
            child: CameraField(cameras: cameras, areas: areas, client: client, config: config),
            ),
          //event live field
          Expanded(
            flex: 1,
            child: EventView(cameras: cameras, config: config),
            )
        ],
      ),
    );
  }
} 