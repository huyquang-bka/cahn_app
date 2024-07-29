import 'package:cahn_app/configs/config.dart';
import 'package:cahn_app/configs/theme.dart';
import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

class CameraDropDown extends StatefulWidget {
  final void Function(int) changeNumCamera;

  const CameraDropDown({required this.changeNumCamera});

  @override
  _CameraDropDownState createState() => _CameraDropDownState();
}

class _CameraDropDownState extends State<CameraDropDown> {
  List<int> listNumCamera = [1, 2, 4];
  int selectedValue = 1;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: onContainerColor,
      ),
      child: DropdownButton2<int>(
        value: selectedValue,
        items: listNumCamera.map((int value) {
          return DropdownMenuItem<int>(
            value: value,
            child: Text("${value.toString()} Cameras"),
          );
        }).toList(),
        onChanged: (int? value) {
          if (value != null) {
            setState(() {
              selectedValue = value;
            });
            widget.changeNumCamera(value);
          }
        },
        iconStyleData: const IconStyleData(
          icon: Icon(Icons.arrow_drop_down),
          iconEnabledColor: Colors.black,
        ),
        style: const TextStyle(color: Colors.black, fontSize: defaultTextSize),
        isExpanded: true,
        underline: Container(),
        dropdownStyleData: const DropdownStyleData(
          elevation: 5,
          padding: EdgeInsets.all(defaultPadding / 2),
          decoration: BoxDecoration(
            color: onContainerColor,
          )
        ),
      ),
    );
  }
}
