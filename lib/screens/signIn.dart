import 'package:blind_companion/Assets/texts.dart';
import 'package:blind_companion/components/textbutton.dart';
import 'package:blind_companion/components/textfield.dart';
import 'package:blind_companion/screens/blind_main_screen.dart';
import 'package:blind_companion/screens/email.dart';
import 'package:blind_companion/screens/self_volunteerHelp.dart';
import 'package:blind_companion/screens/volunteer_main_screen.dart';
import 'package:flutter/material.dart';

import '../Assets/Navigation.dart';

class MySigninScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final screenHeight = screenSize.height;
    final screenWidth = screenSize.width;
    // TODO: implement build
    return (Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          AppTexts.signin,
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Color.fromARGB(255, 248, 243, 239),
      ),
      body: Container(
        height: screenHeight, width: screenWidth,
        color: Color.fromARGB(255, 248, 243, 239),
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
                    hint: AppTexts.email_address,
                    label: AppTexts.email_address),
                SizedBox(
                  height: 30,
                ),
                MyTextField(
                    hint: AppTexts.password,
                    label: AppTexts.password,
                    obsecure: true),
                Row(
                  children: [
                    Spacer(),
                    TextButton(
                        onPressed: () {},
                        child: Text(
                          AppTexts.forget_pwd,
                          style:
                              TextStyle(decoration: TextDecoration.underline),
                        )),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                MyTextButton(
                  text: AppTexts.signin,
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
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Spacer(),
                    Text(
                      AppTexts.dont_have_account,
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    TextButton(
                        onPressed: () {
                          AppNavigation.push(context, MyEmailScreen());
                        },
                        child: Text(AppTexts.signup)),
                    Spacer()
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
