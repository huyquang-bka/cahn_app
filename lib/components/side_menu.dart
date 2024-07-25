import 'package:cahn_app/configs/config.dart';
import 'package:cahn_app/configs/theme.dart';
import 'package:cahn_app/pages/screen/register/register.dart';
import 'package:cahn_app/pages/screen/event/event.dart';
import 'package:cahn_app/pages/screen/live/live_view.dart';
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
    0 : [const LiveViewScreen(), 'Live View', Icons.live_tv],
    1 : [const EventScreen(), 'Events', Icons.event],
    2 : [const RegisterScreen(), 'Register', Icons.person_add],
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
              ListTile(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
                leading: const Icon(Icons.logout),
                title: Text('Logout', style: TextStyle(color: Theme.of(context).colorScheme.primary, fontSize: defaultTextSize)),
                onTap: _onLogout,
              ),
            ],
          ),
    );
}

  Container sideMenuTile({Icon? icon, String title="?", Function()? onTap, bool isSelected = false}) {
    return Container(
      decoration: BoxDecoration(
        color: isSelected ? Colors.white30 : Colors.transparent,
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        leading: icon,
        iconColor: Colors.white,
        title: Text(title, style: TextStyle(color: Colors.white, fontSize: defaultTextSize, fontWeight: isSelected ? FontWeight.bold : FontWeight.normal)),
        onTap: onTap,
        selected: isSelected,
      ),
    );
  }
}

