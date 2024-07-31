import 'package:cahn_app/configs/theme.dart';
import 'package:flutter/material.dart';

class CustomDropDown extends StatefulWidget {
  const CustomDropDown({super.key, required this.title, required this.items, this.onChanged});
  final String title;
  final List<dynamic> items;
  final Function(int)? onChanged;

  @override
  State<CustomDropDown> createState() => _CustomDropDownState();
}

class _CustomDropDownState extends State<CustomDropDown> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Title
        Text(widget.title, style: const TextStyle(color: onContainerColor)),
        const SizedBox(width: 16),
        // Dropdown
        Container(
          decoration: BoxDecoration(
            color: containerColor,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: onContainerColor),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<dynamic>(
              borderRadius: BorderRadius.circular(8),
              value: widget.items[selectedIndex],
              items: widget.items.map((item) {
                return DropdownMenuItem<dynamic>(
                  value: item,
                  child: Text(item.toString(), style: const TextStyle(color: onContainerColor)),
                );
              }).toList(),
              onChanged: (dynamic value) {
                setState(() {
                  selectedIndex = widget.items.indexOf(value);
                  if (widget.onChanged != null) {
                    widget.onChanged!(value);
                  }
                });
              },
              icon: const Icon(Icons.arrow_drop_down, color: onContainerColor),
              dropdownColor: containerColor,
            ),
          ),
        ),
      ],
    );
  }
}
