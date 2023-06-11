import 'package:blind_companion/components/otp.dart';
import 'package:blind_companion/components/textbutton.dart';
import 'package:blind_companion/components/textfield.dart';
import 'package:blind_companion/screens/signIn.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Assets/Navigation.dart';

class MySignupScreen extends StatefulWidget {
  @override
  State<MySignupScreen> createState() => _MySignupScreenState();
}

class _MySignupScreenState extends State<MySignupScreen> {
  bool _isChecked = false;

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final screenHeight = screenSize.height;
    final screenWidth = screenSize.width;
    // TODO: implement build
    return (Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Container(
          decoration:
              const BoxDecoration(color: Color.fromARGB(255, 248, 243, 239)),
          // decoration: BoxDecoration(
          //     image: DecorationImage(
          //         image: AssetImage('images/background.jpg'), fit: BoxFit.cover)),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const Text(
                    'Sign Up',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: screenHeight * 0.25,
                    child: Image.asset('images/logo.png'),
                  ),
                  MyTextField(hint: 'Name'.tr, label: 'Name'.tr),
                  const SizedBox(
                    height: 30,
                  ),
                  MyTextField(
                      hint: 'Email Address'.tr, label: 'Email Address'.tr),
                  const SizedBox(
                    height: 30,
                  ),
                  MyTextField(
                      hint: 'Old Password'.tr,
                      label: 'New Password'.tr,
                      obsecure: true),
                  const SizedBox(
                    height: 30,
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        Checkbox(
                          value: _isChecked,
                          onChanged: (value) {
                            setState(() {});
                            _isChecked = !_isChecked;
                          },
                        ),
                        Text(
                          'By creating account you\'re accepting terms and conditions'
                              .tr,
                          style: TextStyle(fontSize: screenWidth * 0.03),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: screenHeight * 0.05,
                  ),
                  MyTextButton(
                    text: 'Sign Up'.tr,
                    color: Colors.deepOrange,
                    ontap: () => showDialog<String>(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                        title: const Icon(
                          Icons.email,
                          size: 50,
                          color: Colors.deepOrange,
                        ),
                        content: Text(
                          'We have sent you a 4 digit OTP Code'.tr,
                          textAlign: TextAlign.center,
                        ),
                        actions: <Widget>[
                          MyTextButton(
                              color: Colors.deepOrange,
                              ontap: () {
                                showDialog<String>(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      AlertDialog(
                                    title: Text(
                                      'Enter OTP'.tr,
                                      textAlign: TextAlign.center,
                                    ),
                                    content: Container(
                                        height: screenHeight * 0.2,
                                        width: screenWidth * 1,
                                        child: Column(
                                          children: [
                                            MyOTP(),
                                          ],
                                        )),
                                    actions: <Widget>[
                                      MyTextButton(
                                          color: Colors.deepOrange,
                                          ontap: () {
                                            AppNavigation.push(
                                                context, MySigninScreen());
                                          },
                                          text: 'Confirm Password'.tr),
                                    ],
                                  ),
                                );
                                // AppNavigation.push(context, MySigninScreen());
                              },
                              text: 'Next'.tr),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      const Spacer(),
                      Text(
                        'Have an account?'.tr,
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                      TextButton(onPressed: () {}, child: Text('Sign In'.tr)),
                      const Spacer()
                    ],
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
