import 'package:cahn_app/configs/theme.dart';
import 'package:flutter/material.dart';

class CustomDateTimePicker extends StatelessWidget {
  const CustomDateTimePicker({super.key, required this.title, required this.onChanged});
  final String title;
  final Function(DateTime)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        //title
        Text(title, style: const TextStyle(color: onContainerColor)),
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
                onChanged!(dateTime);
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
            child: const Row(
              children: [
                //text
                Text("Chọn thời gian", style: TextStyle(color: onContainerColor)),
                // SizedBox(width: 8),
                Spacer(),
                //icon
                Icon(Icons.calendar_today, color: onContainerColor),
              ],
            ),
          ),
        )
      ],
    );
  }
}