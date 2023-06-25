import 'package:blind_companion/Assets/Navigation.dart';
import 'package:blind_companion/Assets/texts.dart';
import 'package:blind_companion/components/textbutton.dart';
import 'package:blind_companion/screens/email.dart';
import 'package:blind_companion/screens/signIn.dart';
import 'package:flutter/material.dart';

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
            child: Column(
              children: [
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: AppTexts.welcome_to,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 32,
                            fontWeight: FontWeight.bold),
                      ),
                      TextSpan(
                        text: AppTexts.blind,
                        style: TextStyle(
                            color: Colors.orange,
                            fontSize: 32,
                            fontWeight: FontWeight.bold),
                      ),
                      TextSpan(
                        text: AppTexts.companion,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 32,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: screenHeight * 0.02,
                ),
                Center(
                  child: Text(
                    'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
                SizedBox(
                  height: screenHeight * 0.2,
                  child: Image.asset('images/logo.png'),
                ),
                MyTextButton(
                  ontap: () {
                    AppNavigation.push(context, MySigninScreen());
                  },
                  text: 'Sign In',
                  color: Colors.deepOrange,
                ),
                SizedBox(
                  height: screenHeight * 0.05,
                ),
                MyTextButton(
                  text: 'Sign Up',
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
    ));
  }
}
