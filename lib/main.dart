import 'package:blind_companion/screens/blind_main_screen.dart';
import 'package:blind_companion/screens/edit_profile.dart';
import 'package:blind_companion/screens/getStarted.dart';
import 'package:blind_companion/screens/self_volunteerHelp.dart';
import 'package:blind_companion/screens/signIn.dart';
import 'package:blind_companion/screens/email.dart';
import 'package:blind_companion/screens/signup.dart';
import 'package:blind_companion/screens/volunteer_main_screen.dart';
import 'package:blind_companion/screens/welcome.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Blind Companion',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange),
        useMaterial3: true,
      ),
      home: MyGetStarted(),
    );
  }
}
