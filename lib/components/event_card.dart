import 'package:cahn_app/models/event.dart';
import 'package:flutter/material.dart';

Container eventCard(int index, Event event) {
    return Container(
              margin: const EdgeInsets.symmetric(vertical: 8.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  // index
                  Text(
                    index.toString(),
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  //divider
                  const VerticalDivider(
                    color: Colors.black,
                    thickness: 1,
                  ),
                  // image
                  Container(
                    margin: const EdgeInsets.all(8),
                    child: Image.network(
                      event.image,
                      errorBuilder: (context, error, stackTrace) => const Icon(Icons.no_photography),
                    ),
                  ),
                  // info
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      // Name
                      Text(
                        "Họ tên: ${event.fullname ?? "Không xác định"}",
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      // unit
                      Text(
                        "Đơn vị: ${event.typeStr}",
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      // area
                      Text(
                        "Khu vực: ${event.areaStr}",
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      // date
                      Text(
                        "Thời gian: ${event.accessDateStr}",
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      // type
                      Text(
                        "Đối tượng: ${event.typeStr}",
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  )
                ],
              )
            );
  }