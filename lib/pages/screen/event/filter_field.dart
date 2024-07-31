import 'package:cahn_app/components/datetime_picker.dart';
import 'package:cahn_app/components/drop_down_filter.dart';
import 'package:cahn_app/configs/config.dart';
import 'package:cahn_app/configs/theme.dart';
import 'package:cahn_app/helpers/helper_function.dart';
import 'package:flutter/material.dart';
import 'package:cahn_app/models/area.dart';
import 'package:cahn_app/models/camera.dart';


class FilterField extends StatefulWidget {
  const FilterField({super.key, required this.areas, required this.cameras, this.onSearch});
  final List<Area> areas;
  final List<Camera> cameras;
  final Function(String)? onSearch;

  @override
  State<FilterField> createState() => _FilterFieldState();
}

class _FilterFieldState extends State<FilterField> {
  String? startTime;
  String? endTime;
  Area? selectedArea;
  Camera? selectedCamera;
  bool reset = false;

  void onStartTimeChanged(String dateTime) {
    startTime = dateTime;
  }

  void onEndTimeChanged(String dateTime) {
    endTime = dateTime;
  }

  void onAreaChanged(Area value) {
    selectedArea = value;
  }

  void onCameraChanged(Camera value) {
    selectedCamera = value;
  }

  void onSearchPressed() {
    String filterString = "";
    filterString += startTime != null ? "DateFrom=${convertDateToUrlEncoded(startTime!)}&" : "";
    filterString += endTime != null ? "DateTo=${convertDateToUrlEncoded(endTime!)}&" : "";
    filterString += (selectedArea != null && selectedArea!.id != null) ? "areaId=${selectedArea?.id}&" : "";
    filterString += (selectedCamera != null && selectedCamera!.id != null) ? "deviceId=${selectedCamera?.id}&" : "";
    print(filterString);
    widget.onSearch!(filterString);
  }

  void onResetPressed() {
    setState(() {
      startTime = null;
      endTime = null;
      selectedArea = null;
      selectedCamera = null;
      reset = true;
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        reset = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
  padding: const EdgeInsets.all(defaultPadding),
  margin: const EdgeInsets.all(defaultPadding),
  decoration: BoxDecoration(
    color: containerColor,
    borderRadius: BorderRadius.circular(8),
  ),
  child: Column(
    children: [
      // picker fields
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // date time
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // start time
              CustomDateTimePicker(title: "Từ ngày", onChanged: onStartTimeChanged, reset: reset),
              const SizedBox(height: 16),
              // area
              DropDownFilter(title: "Khu vực", items: widget.areas, onChanged: (dynamic value) {
                onAreaChanged(value);
              }, reset: reset),
            ],
          ),
          const SizedBox(height: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // end time
              CustomDateTimePicker(title: "Đến ngày", onChanged: onEndTimeChanged, reset: reset),
              const SizedBox(height: 16),
              // camera
              DropDownFilter(title: "Camera   ", items: widget.cameras, onChanged: (dynamic value) {
                onCameraChanged(value);
              }, reset: reset),
            ],
          )
        ],
      ),
      const SizedBox(height: 32),
      //button field
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // search button
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: primaryColor),
            onPressed: onSearchPressed,
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.search, color: Colors.white),
                SizedBox(width: 8),
                Text("Tìm kiếm", style: TextStyle(color: Colors.white)),
              ],
            ),
          ),
          // reset button
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            onPressed: onResetPressed,
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.refresh, color: Colors.white),
                SizedBox(width: 8),
                Text("Reset", style: TextStyle(color: Colors.white)),
              ],
            ),
          )
        ],
      )
    ],
  ),
);
  }
}