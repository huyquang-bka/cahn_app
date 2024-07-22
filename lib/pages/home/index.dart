import 'package:cahn_app/components/side_menu.dart';
import 'package:cahn_app/configs/theme.dart';
import 'package:cahn_app/models/auth.dart';
import 'package:cahn_app/models/settings.dart';
import 'package:cahn_app/pages/side/dashboard.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  Auth auth = Auth();
  Setting setting = Setting();
  Widget _currentScreen = const DashBoardScreen();

  @override
  void initState() {
    super.initState();
  }

  void _onSideMenuTap(Widget screen) {
    setState(() {
      _currentScreen = screen;
    });
  }

  // load settings from shared preferences
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Row(children: [
          Expanded(
            flex: 1,
            child: SideMenu(onTap: _onSideMenuTap),
          ),
          Expanded(
            flex: 5,
            child: _currentScreen
          ),
        ],),
      ),
    );
  }
}