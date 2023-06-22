import 'package:flutter/material.dart';

class AppNavigation {
  static push(BuildContext context, Widget screen) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => screen));
  }
}
