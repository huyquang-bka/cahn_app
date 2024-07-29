import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.remove('auth');
  prefs.remove('config');
  prefs.remove('setting');
}
