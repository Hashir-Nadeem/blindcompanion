import 'package:blind_companion/components/double_icontextButton.dart';
import 'package:blind_companion/screens/self_volunteerHelp.dart';
import 'package:blind_companion/screens/signup.dart';
import 'package:blind_companion/screens/volunteer_main_screen.dart';
import 'package:flutter/material.dart';
import 'package:blind_companion/backend.dart/getDocuments.dart';
import 'package:blind_companion/backend.dart/apple_sign_in_available.dart';

import '../Assets/Navigation.dart';
import 'blind_main_screen.dart';

class MyEmailScreen extends StatefulWidget {
  const MyEmailScreen({Key? key}) : super(key: key);

  @override
  State<MyEmailScreen> createState() => _MyEmailScreenState();
}

class _MyEmailScreenState extends State<MyEmailScreen> {
  var isLoading = false;

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final screenHeight = screenSize.height;

    return Scaffold(
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
                    text: const TextSpan(
                      children: [
                        TextSpan(
                          text:
                              'By continuing, I confirm I am at least 15 years old, and I agree to and accept the ',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(
                          text: 'Blind Companion',
                          style: TextStyle(
                            color: Colors.orange,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(
                          text: ' Terms & Privacy Policy',
                          style: TextStyle(
                            color: Colors.deepOrange,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline,
                          ),
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
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) {
                        return MySignupScreen();
                      }));
                    },
                  ),
                  SizedBox(
                    height: screenHeight * 0.05,
                  ),
                  isLoading
                      ? Center(
                          child: SizedBox(
                          height: 30,
                          width: 30,
                          child: CircularProgressIndicator(
                            color: Colors.deepOrange,
                            strokeWidth: 3,
                          ),
                        ))
                      : Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            appleSignInAvailable.isAvailable
                                ? MyDoubleIconTextButton(
                                    text: 'Continue with Apple',
                                    image: 'images/appleLogo.png',
                                    color: const Color.fromARGB(
                                        255, 179, 169, 169),
                                    ontap: () async {
                                      setState(() {
                                        isLoading = true;
                                      });
                                      if (await GetDocuments.signInWithApple(
                                          context)) {
                                        setState(() {
                                          isLoading = false;
                                        });
                                        navigate(context);
                                      } else {
                                        setState(() {
                                          isLoading = false;
                                        });
                                      }
                                    },
                                  )
                                : Container(),
                            appleSignInAvailable.isAvailable
                                ? const SizedBox(
                                    height: 10,
                                  )
                                : Container(),
                            MyDoubleIconTextButton(
                              text: 'Continue with Google',
                              image: 'images/g_icon.png',
                              color: const Color.fromARGB(255, 179, 169, 169),
                              ontap: () async {
                                setState(() {
                                  isLoading = true;
                                });
                                if (await GetDocuments.signInWithGoogle(
                                    context)) {
                                  setState(() {
                                    isLoading = false;
                                  });
                                  navigate(context);
                                } else {
                                  setState(() {
                                    isLoading = false;
                                  });
                                }
                              },
                            )
                          ],
                        ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void navigate(BuildContext context) {
    if (turn == 2) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
        return MyVolunteerScreen();
      }));
    }
    if (turn == 1) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
        return MyBlindScreen();
      }));
    }
  }
}
