import 'package:cahn_app/pages/screen/live/camera_field.dart';
import 'package:cahn_app/pages/screen/live/event_view.dart';
import 'package:flutter/material.dart';

class LiveViewScreen extends StatefulWidget {
  const LiveViewScreen({super.key});

  @override
  State<LiveViewScreen> createState() => _LiveViewScreenState();
}

class _LiveViewScreenState extends State<LiveViewScreen> {
  int numCamera = 1;

  void changeNumCamera(int numCameraSet) {
    setState(() {
      numCamera = numCameraSet;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // camera field
        const Expanded(
          flex: 5,
          child: CameraField(),
          ),
        //event live field
        Expanded(
          flex: 1,
          child: EventView(changeNumCamera: changeNumCamera),
          )
      ],
    );
  }
} 