import 'package:cahn_app/components/custom_drop_down.dart';
import 'package:cahn_app/configs/config.dart';
import 'package:flutter/material.dart';

class PaginationField extends StatefulWidget {
  const PaginationField({super.key, required this.totalEvent});
  final int totalEvent;

  @override
  State<PaginationField> createState() => _PaginationFieldState();
}

class _PaginationFieldState extends State<PaginationField> {
  // Pagination
  int currentPage = 1;
  int numberOfItemsPerPage = 10;
  final List<int> itemsPerPage = [10, 20, 50];

  void onItemsPerPageChanged(int value) {
    setState(() {
      numberOfItemsPerPage = value;
    });
  }

  void onCurrentPageChanged(int value) {
    setState(() {
      currentPage = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // choose number of items per page
              CustomDropDown(title: "Số bản ghi mỗi trang", items: itemsPerPage),
              // page number with next and previous button
              const SizedBox(width: defaultPadding),
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back_ios),
                    onPressed: () {
                      currentPage = currentPage > 1 ? currentPage - 1 : 1;
                      onCurrentPageChanged(currentPage);
                    },
                  ),
                  Text("Trang $currentPage"),
                  IconButton(
                    icon: const Icon(Icons.arrow_forward_ios),
                    onPressed: () {
                      currentPage = currentPage < widget.totalEvent / numberOfItemsPerPage ? currentPage + 1 : currentPage;
                      onCurrentPageChanged(currentPage);
                    },
                  ),
                ],
              ),
            ],
          );
  }
}