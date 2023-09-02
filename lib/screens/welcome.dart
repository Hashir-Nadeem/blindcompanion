import 'package:blind_companion/Assets/Navigation.dart';
import 'package:blind_companion/components/textbutton.dart';
import 'package:blind_companion/screens/email.dart';
import 'package:blind_companion/screens/signIn.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../theme.dart';

class MyWelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final screenHeight = screenSize.height;
    final screenWidth = screenSize.width;
    // TODO: implement build
    return (Scaffold(
        backgroundColor: backgroundColor,
        appBar: AppBar(
          title: const Text("Get Started", style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 18
          ),),
          backgroundColor: backgroundColor,
          automaticallyImplyLeading: true,
        ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.06),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: screenHeight * 0.06,
                ),
                Text(
                  "Welcome To Help Request From Blind Companion" .tr,
                  textAlign: TextAlign.center,
                  style:
                  const TextStyle(fontSize: 32, fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: screenHeight * 0.04,
                ),
                Text(
                  'It is a long established fact that a reader will be '
                      'distracted by the readable content of a page when looking at its layout.'
                      .tr,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 18,
                  ),
                ),
                SizedBox(
                  height: screenHeight * 0.05,
                ),
                MyTextButton(
                  ontap: () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) {
                      return MySigninScreen();
                    }));
                    // AppNavigation.push(context, MySigninScreen());
                  },
                  text: 'Sign In'.tr,
                  color: buttonColor,
                ),
                SizedBox(
                  height: screenHeight * 0.03,
                ),
                MyTextButton(
                  text: 'Sign Up'.tr,
                  color: buttonColor,
                  ontap: () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) {
                      return MyEmailScreen();
                    }));
                    // AppNavigation.push(context, MyEmailScreen());
                  },
                )
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
