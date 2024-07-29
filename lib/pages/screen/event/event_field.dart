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
  int currentPage = 1;
  int numberOfItemsPerPage = 10;
  final List<String> columns = ["STT", "Thời gian", "CCCD", "Họ tên", "Giới tính", "Đối tượng", "Khu vực", "Camera", "Ảnh nhận diện"];
  Config? config;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadConfig();
  }

  void loadConfig() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? configPref = prefs.getString('config');
    if (configPref != null) {
      config = Config.fromString(configPref);
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
      width: double.infinity,
      child: Column(
        children: [
          // table
          DataTable(
            columns: List<DataColumn>.generate(
              columns.length,
              (index) => DataColumn(
                label: Text(columns[index]),
              ),
            ),
            rows: List<DataRow>.generate(
              widget.events.length,
              (index) => DataRow(
                cells: [
                  DataCell(Text((index + 1 + (currentPage - 1) * 10).toString())),
                  DataCell(Text(widget.events[index].accessDateStr)),
                  DataCell(Text(widget.events[index].personCode.toString())),
                  DataCell(Text(widget.events[index].faceTerminalName?? "Không xác định")),
                  DataCell(Text(widget.events[index].gender?? "Không xác định")),
                  DataCell(Text(widget.events[index].typeStr)),
                  DataCell(Text(widget.events[index].areaStr)),
                  DataCell(Text(widget.events[index].deviceId.toString())),
                  DataCell(
                    Image.network(
                      "${Config().baseUrl}${widget.events[index].image}",
                      width: 100,
                      height: 100,
                    ),
                  ),
                ],
              ),
            ),
          ),
          // pagination with choose number of items per page (10, 20, 50) and page number with next and previous button
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // choose number of items per page
              Row(
                children: [
                  const Text("Số bản ghi mỗi trang: "),
                  const SizedBox(width: defaultPadding),
                  DropdownButton<int>(
                    value: numberOfItemsPerPage,
                    items: [10, 20, 50].map((value) {
                      return DropdownMenuItem<int>(
                        value: value,
                        child: Text(value.toString()),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        numberOfItemsPerPage = value!;
                      });
                    },
                  ),
                ],
              ),
              // page number with next and previous button
              const SizedBox(width: defaultPadding),
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back_ios),
                    onPressed: () {
                      setState(() {
                        if (currentPage > 1) {
                          currentPage--;
                        }
                      });
                    },
                  ),
                  Text("Trang $currentPage"),
                  IconButton(
                    icon: const Icon(Icons.arrow_forward_ios),
                    onPressed: () {
                      setState(() {
                        if (widget.events.length > currentPage * numberOfItemsPerPage) {
                          currentPage++;
                        }
                      });
                    },
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}