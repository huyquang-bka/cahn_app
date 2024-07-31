import 'package:cahn_app/components/event_card.dart';
import 'package:cahn_app/configs/config.dart';
import 'package:cahn_app/configs/theme.dart';
import 'package:cahn_app/models/config.dart';
import 'package:cahn_app/models/event.dart';
import 'package:flutter/material.dart';

class EventField extends StatefulWidget {
  const EventField({super.key, required this.events, required this.fromIndex});
  final List<Event> events;
  final int fromIndex;

  @override
  State<EventField> createState() => _EventFieldState();
}

class _EventFieldState extends State<EventField> {
  Config? config;

  @override
  void initState() {
    super.initState();
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
      child: widget.events.isEmpty ?
      const Center(
        child: Text("Không có sự kiện nào"),
      ) :
      ListView.builder(
        itemCount: widget.events.length,
        itemBuilder: (context, index) {
          return eventCard(widget.fromIndex + index + 1, widget.events[index]);
        },
      ),
    );
  }

  
}
