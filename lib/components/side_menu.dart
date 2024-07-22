import 'package:cahn_app/configs/config.dart';
import 'package:cahn_app/configs/theme.dart';
import 'package:cahn_app/pages/side/dashboard.dart';
import 'package:cahn_app/pages/side/event.dart';
import 'package:cahn_app/pages/side/live_view.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SideMenu extends StatefulWidget {
  const SideMenu({super.key, this.onTap});
  final Function(Widget)? onTap;

  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  int _selectedIndex = 0;
  final Map<int, dynamic> _screens = {
    0 : [const DashBoardScreen(), 'Dashboard', Icons.dashboard],
    1 : [const EventScreen(), 'Events', Icons.event],
    2 : [const LiveViewScreen(), 'Live View', Icons.live_tv],
  };

  void _onTap(int index) {
    setState(() {
      _selectedIndex = index;
      widget.onTap!(_screens[index][0]);
    });
  }

  void _onLogout() {
    // logout user
    SharedPreferences.getInstance().then((prefs) {
      prefs.remove('auth');
      Navigator.pushReplacementNamed(context, '/login');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(defaultPadding * 2),
      color: containerColor,
      child: Column(
            children: [
              // drawer header with logo and on top
              DrawerHeader(child: Image.asset('assets/images/logo-cahn.png')),
              // side menu tiles
              for (int i = 0; i < _screens.length; i++)
                sideMenuTile(
                  icon: Icon(_screens[i][2]),
                  title: _screens[i][1],
                  onTap: () => _onTap(i),
                  isSelected: _selectedIndex == i,
                ),
              const Spacer(),
              // logout button
              sideMenuTile(
                icon: const Icon(Icons.logout),
                title: 'Logout',
                onTap: _onLogout,
              ),
            ],
          ),
    );
}

  ListTile sideMenuTile({Icon? icon, String title="?", Function()? onTap, bool isSelected = false}) {
    return ListTile(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10)),
      leading: icon,
      title: Text(title, style: const TextStyle(color: Colors.white, fontSize: defaultTextSize)),
      onTap: onTap,
      selected: isSelected,
      selectedTileColor: Theme.of(context).colorScheme.primary,
    );
  }
}

