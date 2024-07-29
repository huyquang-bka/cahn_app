import 'package:cahn_app/configs/config.dart';
import 'package:cahn_app/configs/theme.dart';
import 'package:flutter/material.dart';

class CameraView extends StatelessWidget {
  const CameraView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(defaultPadding / 2),
      decoration: BoxDecoration(
        color: containerColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          //title
          Container(
            padding: const EdgeInsets.all(defaultPadding / 2),
            child: const Text(
              "Camera 1",
              style: TextStyle(
                color: Colors.black,
                fontSize: defaultTextSize,
              ),
            ),
          ),
          //camera view
        ],
      ),
    );
  }
}