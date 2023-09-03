import 'package:blind_companion/components/double_icontextButton.dart';
import 'package:blind_companion/screens/self_volunteerHelp.dart';
import 'package:blind_companion/screens/signup.dart';
import 'package:blind_companion/screens/volunteer_main_screen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:blind_companion/backend.dart/getDocuments.dart';
import 'package:blind_companion/backend.dart/apple_sign_in_available.dart';

import '../Assets/Navigation.dart';
import '../components/textbutton.dart';
import '../theme.dart';
import '../utils/privacy_policy_dialog.dart';
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
    final screenWidth = screenSize.width;
    return Scaffold(
      backgroundColor: primaryBackgroundColor,
      appBar: AppBar(
        toolbarHeight: 70,
        title: const Text(
          "Get Started",
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
        ),
        backgroundColor: primaryBackgroundColor,
        automaticallyImplyLeading: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.06),
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                children: [
                  SizedBox(
                    height: screenHeight * 0.23,
                    child: Image.asset('images/new_logo2.1.png'),
                  ),
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      children: [
                        const TextSpan(
                          text:
                              'By continuing, I confirm I am at least '
                                  '17 years old, and I agree to and accept the ',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const TextSpan(
                          text: 'Blind Companion ',
                          style: TextStyle(
                            color: primaryButtonColor,
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        TextSpan(
                          text: 'Terms & Privacy Policy',
                          style: const TextStyle(
                            color: primaryButtonColor,
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            decoration: TextDecoration.underline,
                          ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return PolicyDialog(
                                          mdFileName:
                                          'terms_and_conditions.md');
                                    });
                              },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: screenHeight * 0.05,
                  ),
                  MyDoubleIconTextButton(
                    isIconRequired: false,
                    isLeadingImageRequired: false,
                    text: 'Continue with Email',
                    color: primaryButtonColor,
                    ontap: () {
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) {
                        return MySignupScreen();
                      }));
                    },
                  ),
                  SizedBox(
                    height: screenHeight * 0.02,
                  ),
                  isLoading
                      ? const Center(
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
                            MyDoubleIconTextButton(
                              text: 'Continue with Google',
                              image: 'images/g_icon.png',
                              isIconRequired: false,
                              color: primaryButtonColor,
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
                            ),
                             SizedBox(
                              height: screenHeight * 0.02,
                            ),
                            appleSignInAvailable.isAvailable
                                ? MyDoubleIconTextButton(
                                    text: 'Continue with Apple',
                                    image: 'images/appleLogo.png',
                                    isIconRequired: false,
                                    color: primaryButtonColor,
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
                                   ) : Container(),
                            appleSignInAvailable.isAvailable
                                ? const SizedBox(
                                    height: 10,
                                  ) : Container(),
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
