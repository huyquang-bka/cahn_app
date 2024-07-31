import 'package:cahn_app/configs/config.dart';
import 'package:cahn_app/configs/theme.dart';
import 'package:cahn_app/models/event.dart';
import 'package:flutter/material.dart';

Container eventCard(int index, Event event) {
    return Container(
              margin: const EdgeInsets.symmetric(vertical: 8.0),
              decoration: BoxDecoration(
                color: containerColor,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: event.personCode != null ? Colors.green : Colors.red,
                  width: 1,
                ),
              ),
              padding: const EdgeInsets.all(defaultPadding),
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
                    color: Colors.white,
                    thickness: 2,
                  ),
                  // image
                  Container(
                    margin: const EdgeInsets.all(8),
                    child: Image.network(
                      event.image ?? "",
                      width: 100,
                      height: 100,
                      errorBuilder: (context, error, stackTrace) => const Icon(Icons.no_photography, size: 100),
                    ),
                  ),
                  const SizedBox(width: defaultPadding),
                  // info
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Name
                      Text(
                        "Họ tên: ${event.fullname ?? "Không xác định"}",
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      // personCode
                      Text(
                        "Mã nhân viên: ${event.personCode ?? "Không xác định"}",
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