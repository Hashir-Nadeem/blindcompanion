import 'package:blind_companion/components/textbutton.dart';
import 'package:blind_companion/components/textfield.dart';
import 'package:blind_companion/screens/blind_main_screen.dart';
import 'package:blind_companion/screens/email.dart';
import 'package:blind_companion/screens/self_volunteerHelp.dart';
import 'package:blind_companion/screens/volunteer_main_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Assets/Navigation.dart';

class MySigninScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final screenHeight = screenSize.height;
    final screenWidth = screenSize.width;
    return (Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Sign In'.tr,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color.fromARGB(255, 248, 243, 239),
      ),
      body: Container(
        height: screenHeight, width: screenWidth,
        color: const Color.fromARGB(255, 248, 243, 239),
        // decoration: BoxDecoration(
        //     image: DecorationImage(
        //         image: AssetImage('images/background.jpg'), fit: BoxFit.cover)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 200,
                  child: Image.asset('images/logo.png'),
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
                Row(
                  children: [
                    const Spacer(),
                    TextButton(
                        onPressed: () {},
                        child: Text(
                          'Forget Password?'.tr,
                          style: const TextStyle(
                              decoration: TextDecoration.underline),
                        )),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                MyTextButton(
                  text: 'Sign In'.tr,
                  color: Colors.deepOrange,
                  ontap: () {
                    if (turn == 2) {
                      AppNavigation.push(context, MyVolunteerScreen());
                    }
                    if (turn == 1) {
                      AppNavigation.push(context, MyBlindScreen());
                    }
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    const Spacer(),
                    Text(
                      'Don\'t have an account?'.tr,
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                    TextButton(
                        onPressed: () {
                          AppNavigation.push(context, const MyEmailScreen());
                        },
                        child: Text('Sign Up'.tr)),
                    const Spacer()
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
