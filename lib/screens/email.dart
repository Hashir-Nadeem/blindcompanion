import 'package:blind_companion/components/double_icontextButton.dart';
import 'package:blind_companion/screens/signup.dart';
import 'package:flutter/material.dart';

import '../Assets/Navigation.dart';

class MyEmailScreen extends StatelessWidget {
  const MyEmailScreen({super.key});

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
                    height: screenHeight * 0.34,
                    child: Image.asset('images/logo.png'),
                  ),
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text:
                              'By continuing, I confirm I am atleast 15 Years old,and I agree to and accept the  ',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                        TextSpan(
                          text: 'Blind Companion',
                          style: TextStyle(
                              color: Colors.orange,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                        TextSpan(
                          text: ' Terms & Privacy Policy',
                          style: TextStyle(
                              color: Colors.deepOrange,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.underline),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: screenHeight * 0.05,
                  ),
                  MyDoubleIconTextButton(
                    image: 'images/email_icon.png',
                    text: 'Continue with Email',
                    color: Colors.deepOrange,
                    ontap: () {
                      AppNavigation.push(context, MySignupScreen());
                    },
                  ),
                  SizedBox(
                    height: screenHeight * 0.05,
                  ),
                  MyDoubleIconTextButton(
                    text: 'Continue with Google',
                    image: 'images/g_icon.png',
                    color: const Color.fromARGB(255, 234, 233, 233),
                    textcolor: Colors.black,
                    ontap: () {},
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
