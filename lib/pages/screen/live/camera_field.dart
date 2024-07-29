import 'package:cahn_app/pages/screen/live/camera_view.dart';
import 'package:flutter/material.dart';

class CameraField extends StatelessWidget {
  const CameraField({super.key, required this.numCamera});
  final int numCamera;

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
  Widget build(BuildContext context) {
    List<int> rowCol = getRowCol(numCamera);
    // 1 or 4 cameras, use row and column
    return Column(
      children: List.generate(rowCol[0], (index) {
        return Expanded(
          flex: 1,
          child: Row(
            children: List.generate(rowCol[1], (index) {
              return const Expanded(
                flex: 1,
                child: CameraView()
              );
            }),
          ),
        );
      }),
    );
  }
}