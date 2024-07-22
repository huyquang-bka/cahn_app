import 'package:cahn_app/models/auth.dart';
import 'package:cahn_app/pages/home/index.dart';
import 'package:cahn_app/pages/login/index.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  Future<Auth?> _loadAccount() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? authPref = prefs.getString('auth');
    return Auth.fromString(authPref);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Auth?>(
      future: _loadAccount(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Show a loading indicator while the future is being resolved
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (snapshot.hasError) {
          // return Login page if an error occurred
          return const LoginPage();
        } else {
          // Check the authentication state
          final auth = snapshot.data;
          if (auth?.accessToken != null) {
            return const HomePage();
          } else {
            return const LoginPage();
          }
        }
      },
    );
  }
}
