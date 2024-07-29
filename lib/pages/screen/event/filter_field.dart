import 'package:cahn_app/components/datetime_picker.dart';
import 'package:cahn_app/components/drop_down_filter.dart';
import 'package:cahn_app/configs/config.dart';
import 'package:cahn_app/configs/theme.dart';
import 'package:flutter/material.dart';
import 'package:cahn_app/models/area.dart';
import 'package:cahn_app/models/camera.dart';

class FilterField extends StatefulWidget {
  const FilterField({super.key, required this.areas, required this.cameras, this.onSearch});
  final List<Area> areas;
  final List<Camera> cameras;
  final Function()? onSearch;

  @override
  State<FilterField> createState() => _FilterFieldState();
}

class _FilterFieldState extends State<FilterField> {
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
              CustomDateTimePicker(title: "Từ ngày", onChanged: (DateTime dateTime) {
                print("Start time: $dateTime");
              }),
              const SizedBox(height: 16),
              // area
              DropDownFilter(title: "Khu vực", items: widget.areas),
            ],
          ),
          const SizedBox(height: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // end time
              CustomDateTimePicker(title: "Đến ngày", onChanged: (DateTime dateTime) {
                print("End time: $dateTime");
              }),
              const SizedBox(height: 16),
              // camera
              DropDownFilter(title: "Camera", items: widget.cameras),
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
            onPressed: widget.onSearch,
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
            onPressed: () {
              print("Resetting...");
            },
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