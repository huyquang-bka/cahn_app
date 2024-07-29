import 'package:cahn_app/configs/config.dart';
import 'package:cahn_app/configs/theme.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

class DropDownFilter extends StatefulWidget {
  const DropDownFilter({super.key, required this.title, required this.items, this.onChanged});
  final String title;
  final List<dynamic> items;
  final Function(dynamic)? onChanged;

  @override
  State<DropDownFilter> createState() => _DropDownFilterState();
}

class _DropDownFilterState extends State<DropDownFilter> {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        //title
        Text(widget.title, style: const TextStyle(color: onContainerColor)),
        const SizedBox(width: 16),
        //dropdown
        Container(
          decoration: BoxDecoration(
            color: containerColor,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: onContainerColor),
          ),
          width: MediaQuery.of(context).size.width * 0.3,
          child: Row(
            children: [
              // dropdown
              DropdownButton2(
                items: widget.items.map((item) => DropdownMenuItem(value: item, 
                child: Text(item.text, style: const TextStyle(color: onContainerColor)))).toList(),
                value: widget.items[selectedIndex],
                onChanged: (dynamic value) {
                  setState(() {
                    selectedIndex = widget.items.indexOf(value);
                    widget.onChanged!(value);
                  });
                },
              underline: Container(),
              iconStyleData: const IconStyleData(icon: Icon(null)),
              ),
              const Spacer(),
              //icon
              const Icon(Icons.arrow_drop_down, color: onContainerColor),
            ],
          ),
        )
      ],
    );
  }
}