import 'package:cahn_app/configs/config.dart';
import 'package:flutter/material.dart';

class DashBoardScreen extends StatelessWidget {
  const DashBoardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.all(defaultPadding),
        child: const Center(
          child: Text('Dashboard'),
        ),
      ),
    );
  }
}