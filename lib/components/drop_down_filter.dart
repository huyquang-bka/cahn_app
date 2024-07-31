import 'package:cahn_app/configs/theme.dart';
import 'package:flutter/material.dart';

class DropDownFilter extends StatefulWidget {
  const DropDownFilter({super.key, required this.title, required this.items, this.onChanged, required this.reset, this.isExpanded = true});
  final String title;
  final List<dynamic> items;
  final Function(dynamic)? onChanged;
  final bool reset;
  final bool isExpanded;

  @override
  State<DropDownFilter> createState() => _DropDownFilterState();
}

class _DropDownFilterState extends State<DropDownFilter> {
  int selectedIndex = 0;

  @override
  void didUpdateWidget(DropDownFilter oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.reset) {
      setState(() {
        selectedIndex = 0;
      });
    }
  }

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
          width: widget.isExpanded ? MediaQuery.of(context).size.width * 0.3 : null,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<dynamic>(
              borderRadius: BorderRadius.circular(8),
              isExpanded: widget.isExpanded,
              value: widget.items[selectedIndex],
              items: widget.items.map((item) {
                return DropdownMenuItem<dynamic>(
                  value: item,
                  child: Text(item.text, style: const TextStyle(color: onContainerColor)),
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
