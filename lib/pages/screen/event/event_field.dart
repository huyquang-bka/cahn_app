import 'package:cahn_app/components/event_card.dart';
import 'package:cahn_app/configs/config.dart';
import 'package:cahn_app/configs/theme.dart';
import 'package:cahn_app/models/config.dart';
import 'package:cahn_app/models/event.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EventField extends StatefulWidget {
  const EventField({super.key, required this.events});
  final List<Event> events;

  @override
  State<EventField> createState() => _EventFieldState();
}

class _EventFieldState extends State<EventField> {
  Config? config;

  @override
  void initState() {
    super.initState();
    loadConfig();
  }

  void loadConfig() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? configPref = prefs.getString('config');
    if (configPref != null) {
      setState(() {
        config = Config.fromString(configPref);
      });
    }
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
      child: widget.events.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                for (int i = 0; i < widget.events.length; i++)
                  eventCard(i, widget.events[i]),
              ],
            ),
    );
  }

  
}
