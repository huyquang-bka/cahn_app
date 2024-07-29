import 'package:cahn_app/components/camera_drop_down.dart';
import 'package:cahn_app/configs/config.dart';
import 'package:cahn_app/configs/theme.dart';
import 'package:flutter/material.dart';

class EventView extends StatefulWidget {
  const EventView({super.key, required this.changeNumCamera});
  final Function(int) changeNumCamera;

  @override
  State<EventView> createState() => _EventViewState();
}

class _EventViewState extends State<EventView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: containerColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          bottomLeft: Radius.circular(20),
        ),
      ),
      padding: const EdgeInsets.all(defaultPadding),
      child: Column(
        children: [
          //dropdown select number of camera
          CameraDropDown(changeNumCamera: widget.changeNumCamera),
          const SizedBox(height: defaultPadding),
          //divider by ----------------
          const Divider(
            color: Colors.black,
            thickness: 2,
          ),
        ],
      ),
    );
  }

  
}