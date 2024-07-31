import 'package:cahn_app/components/custom_drop_down.dart';
import 'package:cahn_app/configs/config.dart';
import 'package:flutter/material.dart';

class PaginationField extends StatefulWidget {
  const PaginationField({super.key, required this.totalEvent, required this.currentPage, required this.itemsPerPage, required this.onCurrentPageChanged, required this.onItemsPerPageChanged});
  final int totalEvent;
  final int currentPage;
  final int itemsPerPage;
  final Function(int) onCurrentPageChanged;
  final Function(int) onItemsPerPageChanged;

  @override
  State<PaginationField> createState() => _PaginationFieldState();
}

class _PaginationFieldState extends State<PaginationField> {
  // Pagination
  final List<int> itemsPerPage = [10, 20, 50];

  void onItemsPerPageChanged(int value) {
    widget.onItemsPerPageChanged(value);
  }

  void onCurrentPageChanged(int value) {
    widget.onCurrentPageChanged(value);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // choose number of items per page
              CustomDropDown(title: "Số bản ghi mỗi trang", items: itemsPerPage, onChanged: widget.onItemsPerPageChanged),
              // page number with next and previous button
              const SizedBox(width: defaultPadding),
              Row(
                children: [
                  //first page
                  IconButton(
                    icon: const Icon(Icons.first_page),
                    onPressed: () {
                      widget.onCurrentPageChanged(1);
                    },
                  ),
                  // next page
                  IconButton(
                    icon: const Icon(Icons.arrow_back_ios),
                    onPressed: () {
                      int currentPage = widget.currentPage > 1 ? widget.currentPage - 1 : 1;
                      widget.onCurrentPageChanged(currentPage);
                    },
                  ),
                  Text("Trang ${widget.currentPage} / ${widget.totalEvent ~/ widget.itemsPerPage + 1}"),
                  // previous page
                  IconButton(
                    icon: const Icon(Icons.arrow_forward_ios),
                    onPressed: () {
                      int currentPage = widget.currentPage < widget.totalEvent ~/ widget.itemsPerPage + 1 ? widget.currentPage + 1 : widget.totalEvent ~/ widget.itemsPerPage + 1;
                      widget.onCurrentPageChanged(currentPage);
                    },
                  ),
                  // last page
                  IconButton(
                    icon: const Icon(Icons.last_page),
                    onPressed: () {
                      int currentPage = widget.totalEvent ~/ widget.itemsPerPage + 1;
                      widget.onCurrentPageChanged(currentPage);
                    },
                  ),
                ],
              ),
            ],
          );
  }
}