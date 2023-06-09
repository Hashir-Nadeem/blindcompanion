import 'package:flutter/material.dart';

class AppNavigation {
  static void push(BuildContext context, Widget screen) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => screen));
  }
}
