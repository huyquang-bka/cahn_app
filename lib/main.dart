import 'package:cahn_app/configs/theme.dart';
import 'package:cahn_app/pages/auth/index.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'pages/home/index.dart';
import 'pages/login/index.dart';
import 'package:flutter/material.dart';

void main() async 
{
  // app initialization
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Công An Hà Nội',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: bgColor,
        canvasColor: secondaryColor
      ),
      home: const AuthPage(),
      routes: {
        '/home': (context) => const HomePage(),
        '/login': (context) => const LoginPage(),
      }
    );
  }
}