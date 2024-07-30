import 'package:cahn_app/configs/theme.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CustomDateTimePicker extends StatefulWidget {
  const CustomDateTimePicker({super.key, required this.title, required this.onChanged, required this.reset});
  final String title;
  final Function(String) onChanged;
  final bool reset;

  @override
  State<CustomDateTimePicker> createState() => _CustomDateTimePickerState();
}

class _CustomDateTimePickerState extends State<CustomDateTimePicker> {
  String? selectedDate;
  final DateFormat formatter = DateFormat('HH:mm:ss dd/MM/yyyy');

  void onDateChanged(DateTime dateTime) {
    setState(() {
      selectedDate = formatter.format(dateTime);
    });
    widget.onChanged(selectedDate!);
  }

  @override
  void didUpdateWidget(CustomDateTimePicker oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.reset) {
      setState(() {
        selectedDate = null;
      });
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        //title
        Text(widget.title, style: const TextStyle(color: onContainerColor)),
        const SizedBox(width: 16),
        //dropdown
        GestureDetector(
          onTap: () async {
            DateTime? date = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(2000),
              lastDate: DateTime(2100),
            );
            if (date != null) {
              TimeOfDay? time = await showTimePicker(
                context: context,
                initialTime: TimeOfDay.now(),
              );
              if (time != null) {
                DateTime dateTime = DateTime(date.year, date.month, date.day, time.hour, time.minute);
                onDateChanged(dateTime);
              }
            }
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: containerColor,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: onContainerColor),
            ),
            width: MediaQuery.of(context).size.width * 0.3,
            child: Row(
              children: [
                //text
                Text(selectedDate ?? "Chọn ngày", style: const TextStyle(color: onContainerColor)),
                // SizedBox(width: 8),
                const Spacer(),
                //icon
                const Icon(Icons.calendar_today, color: onContainerColor),
              ],
            ),
          ),
        )
      ],
    );
  }
}