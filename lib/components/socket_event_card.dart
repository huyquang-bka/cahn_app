import 'dart:convert';
import 'dart:typed_data';
import 'package:cahn_app/models/socket_event.dart';
import 'package:flutter/material.dart';

class SocketEventCard extends StatelessWidget {
  final SocketEvent event;

  const SocketEventCard({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    final Uint8List imageBytes = base64Decode(event.image);
    final bool isUnknown = event.name.toLowerCase() == "unknown";

    return LayoutBuilder(
      builder: (context, constraints) {
        // Use a proportion of the container's width as the font size
        double imageWidth = constraints.maxWidth * 0.3;
        double imageHeight = constraints.maxWidth * 0.4;
        double fontSize = constraints.maxWidth * 0.035;
        return Container(
          padding: const EdgeInsets.all(8.0),
          margin: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: isUnknown ? Colors.red[300] : Colors.green[300],
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: isUnknown ? Colors.red : Colors.green,
              width: 2,
            ),
          ),
          child: Row(
            children: [
              Expanded(
                flex: 2,
                child: Container(
                  width: imageWidth,
                  height: imageHeight,
                  // padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: Colors.black54,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: event.image.isNotEmpty
                      ? Image.memory(
                          imageBytes,
                          fit: BoxFit.fill,
                          filterQuality: FilterQuality.high,
                        )
                      : const Icon(
                          Icons.image_not_supported,
                          size: 48,
                          color: Colors.white,
                        ),
                ),
              ),
              const SizedBox(width: 8.0),
              Expanded(
                flex: 3,
                child: SizedBox(
                  height: imageHeight,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildInfoChip('Thời gian', event.time,
                          fontSize: fontSize),
                      _buildInfoChip('Họ tên', event.name, fontSize: fontSize),
                      _buildInfoChip("Camera", event.cameraName ?? "Unknown",
                          fontSize: fontSize),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildInfoChip(String label, String value, {double fontSize = 16}) {
    return Container(
      // padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
      child: Text(
        '$label: $value',
        style: TextStyle(
            color: Colors.black,
            fontSize: fontSize,
            fontWeight: FontWeight.bold),
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}