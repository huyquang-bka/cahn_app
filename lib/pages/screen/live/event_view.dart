import 'dart:convert';
import 'package:cahn_app/components/socket_event_card.dart';
import 'package:cahn_app/configs/config.dart';
import 'package:cahn_app/configs/theme.dart';
import 'package:cahn_app/models/camera.dart';
import 'package:cahn_app/models/config.dart';
import 'package:flutter/material.dart';
import 'package:web_socket_client/web_socket_client.dart';
import 'package:cahn_app/models/socket_event.dart';

class EventView extends StatefulWidget {
  const EventView({super.key, required this.cameras, required this.config});
  final List<Camera> cameras;
  final Config config;

  @override
  State<EventView> createState() => _EventViewState();
}

class _EventViewState extends State<EventView> {
  List<SocketEvent> events = [];
  final int maxEvents = 20;
  final backoff = LinearBackoff(
    initial: const Duration(seconds: 0),
    increment: const Duration(seconds: 1),
    maximum: const Duration(seconds: 2),
  );
  late WebSocket socket;


  @override
  void initState() {
    _loadSocket();
    super.initState();
  }

  Future<void> _loadSocket() async {
    try {
      final String host = widget.config.websocketUrl;
      socket = WebSocket(Uri.parse(host), backoff: backoff);
      socket.messages.listen((message) {
        _handleSocketMessage(message);
      });
      socket.connection.listen((event) {
        print('Socket connected to server: $host with event: $event');
      });
    } catch (e) {
      print("Error loading socket: $e");
    }
  }

  void _handleSocketMessage(String message) {
    final jsonMessage = jsonDecode(message);
    // print("Socket message: $jsonMessage");
    String? cameraName = widget.cameras
        .firstWhere((element) => element.id == jsonMessage['cameraId'])
        .deviceName;
    SocketEvent event = SocketEvent.fromJson(jsonMessage);
    event.cameraName = cameraName;
    // Move existing event to index 0 if it exists
    setState(() {
      events.removeWhere((e) => e.key == event.key);
      events.insert(0, event);
      
      // Ensure the list has a maximum of 20 elements
      if (events.length > maxEvents) {
        events.removeRange(maxEvents, events.length);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: containerColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          bottomLeft: Radius.circular(20),
        ),
      ),
      padding: const EdgeInsets.all(defaultPadding),
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: events.length,
        itemBuilder: (context, index) {
          return SocketEventCard(event: events[index]);
        },
      ),
    );
  }

  
}