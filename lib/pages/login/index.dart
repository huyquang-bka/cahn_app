import 'dart:convert';
import 'package:cahn_app/models/auth.dart';
import '../../configs/api_route.dart';
import '../../configs/config.dart';
import '../../helpers/helpers_builder.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _passwordVisible = false;
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _onVisibilityChanged() {
    setState(() {
      _passwordVisible = !_passwordVisible;
    });
  }

  void _onLogin() async {
    // Show loading dialog
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
    
    if (_usernameController.text.isEmpty || _passwordController.text.isEmpty) {
      //popup alert dialog
      Navigator.pop(context);
      showAlertMessage(context: context, message: 'Please fill in all fields');
      return;
    } 
    Map<String, String> payload = bodyAuth;
    payload["username"] = _usernameController.text;
    payload["password"] = _passwordController.text;
    // call login api
    try{
      print("urlAuth: $urlAuth");
      print("payload: ${jsonEncode(payload)}");
      final response = await http
            .post(
              Uri.parse(urlAuth),
              headers: {
                'Content-Type': 'application/json',
              },
              body: jsonEncode(payload),
            )
            .timeout(const Duration(seconds: 5));
      Navigator.pop(context);
      if (response.statusCode == 200) {
        final body = jsonDecode(response.body);
        Auth auth = Auth.fromJson(body);
        // save access token to shared preferences
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('auth', auth.encodeToString());
        // Navigate to home page
        // ignore: use_build_context_synchronously
        Navigator.pushReplacementNamed(context, '/home');
      } else {
        // show error message
        // ignore: use_build_context_synchronously
        showAlertMessage(context: context, message: 'Login failed');
      }
    }
    catch(e){
      Navigator.pop(context);
      print("Error: $e");
      // show error message
      // ignore: use_build_context_synchronously
      showAlertMessage(context: context, message: 'Connection error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Expanded(
            flex: 3,
            child: Container(
              color: Theme.of(context).primaryColor,
              child: Padding(
                padding: const EdgeInsets.all(defaultPadding),
                child: Center(
                  child: Image.asset('assets/images/logo.png'),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.all(defaultPadding),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Welcome! 👋',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Please sign-in to your account and start the adventure',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  const SizedBox(height: 32),
                  Text('UserName', style: Theme.of(context).textTheme.bodySmall),
                  const SizedBox(height: 8),
                  TextField(
                    controller: _usernameController,
                    style: Theme.of(context).textTheme.bodySmall,
                    decoration: InputDecoration(
                      focusColor: Theme.of(context).primaryColor,
                      hintText: 'UserName',
                      hintStyle: Theme.of(context).textTheme.bodySmall,
                      fillColor: Theme.of(context).inputDecorationTheme.fillColor,
                      filled: true,
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text('Password', style: Theme.of(context).textTheme.bodySmall),
                  const SizedBox(height: 8),
                  TextField(
                    controller: _passwordController,
                    style: Theme.of(context).textTheme.bodySmall,
                    obscureText: !_passwordVisible,
                    decoration: InputDecoration(
                      hintText: 'Password',
                      hintStyle: Theme.of(context).textTheme.bodySmall,
                      fillColor: Theme.of(context).inputDecorationTheme.fillColor,
                      filled: true,
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                      suffixIcon: IconButton(
                        icon: Icon(_passwordVisible ? Icons.visibility : Icons.visibility_off),
                        color: Colors.grey[500],
                        onPressed: _onVisibilityChanged,
                      ),
                    ),
                    textInputAction: TextInputAction.done,
                    onSubmitted: (_) => FocusScope.of(context).nextFocus(),
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(Theme.of(context).primaryColor.value),
                      minimumSize: const Size(double.infinity, 50),
                    ),
                    onPressed: _onLogin,
                    child: Text('Sign in', style: Theme.of(context).textTheme.bodySmall),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}