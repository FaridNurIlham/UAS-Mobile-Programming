import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'screens/splash_screen.dart';
import 'screens/login_screen.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  Future<Widget> checkLogin() async {
    final prefs = await SharedPreferences.getInstance();
    final username = prefs.getString('username');
    return username == null ? LoginScreen() : HomeScreen();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Perpustakaan UPGRIS',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: SplashScreen(nextScreen: checkLogin()),
    );
  }
}
