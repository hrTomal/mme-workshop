import 'package:flutter/material.dart';
import 'package:meetingme/screens/login/login_screen.dart';
import 'package:meetingme/screens/splash/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MeetingMe',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: const SplashScreen(),
      routes: {
        LoginScreen.routeName: (context) => LoginScreen(),
      },
    );
  }
}
