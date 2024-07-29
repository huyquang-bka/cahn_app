import 'package:cahn_app/components/side_menu.dart';
import 'package:cahn_app/configs/theme.dart';
import 'package:cahn_app/pages/screen/event/event.dart';
import 'package:cahn_app/pages/screen/live/live_view.dart';
import 'package:cahn_app/pages/screen/register/register.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  final List<Widget> _screens = [
        const LiveViewScreen(),
        const EventScreen(),
        const RegisterScreen(),
      ];
  Widget _currentScreen = const LiveViewScreen();

  @override
  void initState() {
    super.initState();
  }

  void _onSideMenuTap(int currentIndex) {
    setState(() {
      _currentScreen = _screens[currentIndex];
    });
  }

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
            child: _currentScreen,
          ),
        ],),
      ),
    );
  }
}