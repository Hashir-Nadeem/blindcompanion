import 'package:blind_companion/screens/blind_main_screen.dart';
import 'package:blind_companion/screens/getStarted.dart';
import 'package:blind_companion/screens/volunteer_main_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Assets/texts.dart';
import 'backend.dart/apple_sign_in_available.dart';
import 'firebase_options.dart';

Future<void> main() async {
  runApp(const MyApp());
  appleSignInAvailable.check();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Retrieve the stored selected role
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? selectedRole = prefs.getString('selectedRole');

  // Navigate the user based on the stored selected role
  if (selectedRole == 'Blind') {
    runApp(
      GetMaterialApp(
          debugShowCheckedModeBanner: false,
          translations: AppTexts(),
          locale: const Locale('en', 'US'),
          title: 'Blind Companion',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange),
            useMaterial3: true,
          ),
          home: MyBlindScreen()),
    );
  } else if (selectedRole == 'Volunteer') {
    runApp(
      GetMaterialApp(
          debugShowCheckedModeBanner: false,
          translations: AppTexts(),
          locale: const Locale('en', 'US'),
          title: 'Blind Companion',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange),
            useMaterial3: true,
          ),
          home: const MyVolunteerScreen()),
    );
  } else {
   runApp(const MyApp());
 }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      translations: AppTexts(),
      //locale: Locale('en', 'US'),
      title: 'Blind Companion',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange),
        useMaterial3: true,
      ),
      home: const MyGetStarted(),
    );
  }
}
