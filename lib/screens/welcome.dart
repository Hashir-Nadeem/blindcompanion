import 'package:blind_companion/Assets/Navigation.dart';
import 'package:blind_companion/components/textbutton.dart';
import 'package:blind_companion/screens/email.dart';
import 'package:blind_companion/screens/signIn.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyWelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final screenHeight = screenSize.height;
    final screenWidth = screenSize.width;
    // TODO: implement build
    return (Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: screenHeight * 0.23,
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: 'Welcome To'.tr,
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 32,
                                fontWeight: FontWeight.bold),
                          ),
                          TextSpan(
                            text: ' Help Request From Blind'.tr,
                            style: const TextStyle(
                                color: Colors.orange,
                                fontSize: 32,
                                fontWeight: FontWeight.bold),
                          ),
                          TextSpan(
                            text: ' Companion'.tr,
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 32,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: screenHeight * 0.02,
                  ),
                  Center(
                    child: Text(
                      'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.'
                          .tr,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: screenHeight * 0.03,
                  ),
                  MyTextButton(
                    ontap: () {
                      AppNavigation.push(context, MySigninScreen());
                    },
                    text: 'Sign In'.tr,
                    color: Colors.deepOrange,
                  ),
                  SizedBox(
                    height: screenHeight * 0.05,
                  ),
                  MyTextButton(
                    text: 'Sign Up'.tr,
                    color: Colors.orangeAccent,
                    ontap: () {
                      AppNavigation.push(context, MyEmailScreen());
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    ));
  }
}
