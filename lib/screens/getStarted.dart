import 'package:blind_companion/Assets/Navigation.dart';
import 'package:blind_companion/Assets/texts.dart';
import 'package:blind_companion/components/text_icon_button.dart';
import 'package:blind_companion/screens/self_volunteerHelp.dart';
import 'package:flutter/material.dart';

class MyGetStarted extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final screenHeight = screenSize.height;
    return (Scaffold(
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: screenHeight * 0.8,
              child: Image.asset('images/logo.png'),
            ),
            MyTextIconButton(
              text: AppTexts.get_started,
              ontap: () {
                AppNavigation.push(context, MySelfVolunteerHelp());
              },
            ),
          ],
        ),
      ),
    ));
  }
}
