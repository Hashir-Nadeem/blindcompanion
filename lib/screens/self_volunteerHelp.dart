import 'package:blind_companion/Assets/Navigation.dart';
import 'package:blind_companion/components/double_icontextButton.dart';
import 'package:blind_companion/screens/welcome.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:countup/countup.dart';

int turn = 0;

class MySelfVolunteerHelp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final screenHeight = screenSize.height;
    final screenWidth = screenSize.width;
    return (Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: screenHeight * 0.2,
                child: Image.asset('images/logo.png'),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Column(
                      children: [
                        Text(
                          'US',
                          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                        Countup(
                          begin: 0,
                          end: 7500,
                          duration: Duration(seconds: 3),
                          separator: ',',
                          style: TextStyle(
                            color: Colors.orange,
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    Spacer(),
                    Column(
                      children: [
                        Text(
                          'UK',
                          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                        Countup(
                          begin: 0,
                          end: 8000,
                          duration: Duration(seconds: 3),
                          separator: ',',
                          style: TextStyle(
                            color: Colors.orange,
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                    Spacer(),
                    Column(
                      children: [
                        Text(
                          'PK',
                          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                        Countup(
                          begin: 0,
                          end: 10000,
                          duration: Duration(seconds: 3),
                          separator: ',',
                          style: TextStyle(
                            color: Colors.orange,
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  elevation: 10,
                  child: Container(
                      height: 300,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Discover the Community. See the World Together'
                                  .tr,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w600),
                            ),
                            SizedBox(
                              height: screenHeight * 0.05,
                            ),
                            MyDoubleIconTextButton(
                              text: 'I am a Blind'.tr,
                              image: 'images/blind_icon.png',
                              color: Colors.deepOrange,
                              ontap: () {
                                turn = 1;
                                AppNavigation.push(context, MyWelcomeScreen());
                              },
                            ),
                            SizedBox(
                              height: screenHeight * 0.05,
                            ),
                            MyDoubleIconTextButton(
                              text: 'I am a Volunteer'.tr,
                              image: 'images/volunteer_icon.png',
                              color: Colors.deepOrange,
                              ontap: () {
                                turn = 2;
                                AppNavigation.push(context, MyWelcomeScreen());
                              },
                            )
                          ],
                        ),
                      )),
                ),
              )
            ],
          ),
        ),
      ),
    ));
  }
}
