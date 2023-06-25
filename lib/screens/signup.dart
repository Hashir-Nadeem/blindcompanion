import 'package:blind_companion/Assets/texts.dart';
import 'package:blind_companion/components/otp.dart';
import 'package:blind_companion/components/textbutton.dart';
import 'package:blind_companion/components/textfield.dart';
import 'package:blind_companion/screens/signIn.dart';
import 'package:flutter/material.dart';

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
          decoration: BoxDecoration(color: Color.fromARGB(255, 248, 243, 239)),
          // decoration: BoxDecoration(
          //     image: DecorationImage(
          //         image: AssetImage('images/background.jpg'), fit: BoxFit.cover)),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Text(
                    'Sign Up',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: screenHeight * 0.25,
                    child: Image.asset('images/logo.png'),
                  ),
                  MyTextField(hint: AppTexts.name, label: AppTexts.name),
                  SizedBox(
                    height: 30,
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
                  SizedBox(
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
                          AppTexts.account_creation,
                          style: TextStyle(fontSize: screenWidth * 0.03),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: screenHeight * 0.05,
                  ),
                  MyTextButton(
                    text: AppTexts.signup,
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
                          AppTexts.otp,
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
                                      AppTexts.enter_otp,
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
                                          text: AppTexts.confirm),
                                    ],
                                  ),
                                );
                                // AppNavigation.push(context, MySigninScreen());
                              },
                              text: AppTexts.next),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Spacer(),
                      Text(
                        AppTexts.have_account,
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      TextButton(
                          onPressed: () {}, child: Text(AppTexts.signin)),
                      Spacer()
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
