import 'package:blind_companion/Assets/Navigation.dart';
import 'package:blind_companion/components/double_icontextButton.dart';
import 'package:blind_companion/screens/welcome.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

int turn = 0;

class MySelfVolunteerHelp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return (Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text(
              'Self/Volunteer Help'.tr,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 150,
              child: Image.asset('images/logo.png'),
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
                            'Discover the Community. See the World Together'.tr,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(
                            height: 40,
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
                          const SizedBox(
                            height: 30,
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
    ));
  }
}
