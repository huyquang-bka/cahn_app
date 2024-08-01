import 'package:cahn_app/configs/config.dart';
import 'package:cahn_app/models/area.dart';
import 'package:cahn_app/models/camera.dart';
import 'package:cahn_app/models/config.dart';
import 'package:cahn_app/networks/http.dart';
import 'package:cahn_app/pages/screen/live/camera_view.dart';
import 'package:flutter/material.dart';

class CameraField extends StatefulWidget {
  const CameraField({super.key, required this.cameras, required this.areas, required this.client, required this.config});
  final CustomHttpClient client;
  final Config config;
  final List<Camera> cameras;
  final List<Area> areas;

  @override
  State<CameraField> createState() => _CameraFieldState();
}

class _CameraFieldState extends State<CameraField> {
  late Config config;
  int currentSelected = 1;

  List<int> getRowCol(int numCamera) {
    if (numCamera == 2)
    {
      return [2, 1];
    }
    else if (numCamera == 4)
    {
      return [2, 2];
    }
    else
    {
      return [1, 1];
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initialize();
  }

  void _initialize() {
    config = Config.fromJson(config.toJson());
    //copy config from widget to local
    setState(() {
      currentSelected = config.listCameraId.length <= 1 ? 1 : 4;
    });
  }

  void onChangeCamera(int index, int cameraId) {
    print("index: $index, cameraId: $cameraId");
  }

  void onSavePressed() {
    //save config to server
  }


  @override
  Widget build(BuildContext context) {
    List<int> rowCol = getRowCol(currentSelected);
    // 1 or 4 cameras, use row and column
    return Column(
      children: [
        //choose number of camera,icon 1 or 4
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // 1 camera
            IconButton(
              icon: const Icon(Icons.filter_1),
              isSelected: currentSelected == 1,
              selectedIcon: const Icon(Icons.filter_1, color: Colors.green),
              onPressed: () {
                setState(() {
                  currentSelected = 1;
                });
              },
            ),
            const SizedBox(width: defaultPadding / 2),
            // 4 cameras
            IconButton(
              icon: const Icon(Icons.filter_4),
              isSelected: currentSelected == 4,
              selectedIcon: const Icon(Icons.filter_4, color: Colors.green),
              onPressed: () {
                setState(() {
                  currentSelected = 4;
                });
              },
            ),
            const SizedBox(width: defaultPadding / 2),
            // button save
            IconButton(
              icon: const Icon(Icons.save),
              onPressed: () {
              },
            ),
          ],
        ),
        // camera field
        Expanded(
          child: Column(
            children: List.generate(rowCol[0], (index1) {
              return Expanded(
                flex: 1,
                child: Row(
                  children: List.generate(rowCol[1], (index2) {
                    int indexCamera = index1 * rowCol[1] + index2;
                    int? cameraId = config.listCameraId.length > indexCamera ? config.listCameraId[indexCamera] : null;
                    return Expanded(
                      flex: 1,
                      child: CameraView(index: indexCamera, cameraId: cameraId, areas: widget.areas, cameras: widget.cameras, changeNumCamera: onChangeCamera),
                    );
                  }),
                ),
              );
            }),
          ),
        ),
      ],
    );
  }
}