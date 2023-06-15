import 'dart:async';

import 'package:blind_companion/Assets/Navigation.dart';
import 'package:blind_companion/components/double_icontextButton.dart';
import 'package:blind_companion/components/languageDropdown.dart';
import 'package:blind_companion/screens/edit_profile.dart';
import 'package:blind_companion/screens/signIn.dart';
import 'package:blind_companion/screens/trace_me_OCR.dart';
import 'package:blind_companion/screens/track_me.dart';
import 'package:blind_companion/screens/volunteer_help.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'call.dart';
import 'ocr.dart';

class MyBlindScreen extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  MyBlindScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final screenHeight = screenSize.height;
    final screenWidth = screenSize.width;
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        toolbarHeight: screenHeight * 0.1,
        actions: [
          IconButton(
              onPressed: () {
                _scaffoldKey.currentState?.openEndDrawer();
              },
              icon: const Icon(Icons.menu))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListTile(
              title: Text(
                'Volunteer'.tr,
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
              ),
              titleTextStyle: const TextStyle(color: Colors.deepOrange),
              subtitle: Text(
                'emmanuelpriest@gmail.com'.tr,
                style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: Colors.black),
              ),
              tileColor: const Color.fromARGB(31, 154, 153, 153),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Wrap(children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Discover the Community. See the World Together'.tr,
                        textAlign: TextAlign.left,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ]),
                  const SizedBox(
                    height: 30,
                  ),
                  MyDoubleIconTextButton(
                    text: 'Track Me'.tr,
                    image: 'images/detective_icon.png',
                    color: Colors.deepOrange,
                    ontap: () {
                      AppNavigation.push(context, MyTrackMe());
                    },
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  MyDoubleIconTextButton(
                    text: 'OCR'.tr,
                    image: 'images/ocr.png',
                    color: Colors.deepOrange,
                    ontap: () {
                      AppNavigation.push(context, MyOcr());
                    },
                  ),
                  // MyDoubleIconTextButton(
                  //   text: 'Self Help'.tr,
                  //   image: 'images/self_help_icon.png',
                  //   color: Colors.deepOrange,
                  //   ontap: () {
                  //     AppNavigation.push(context, MyTraceMeOcr());
                  //   },
                  // ),
                  const SizedBox(
                    height: 30,
                  ),
                  // MyDoubleIconTextButton(
                  //   text: 'Self/Volunteer Help'.tr,
                  //   image: 'images/volunteer_icon.png',
                  //   color: Colors.deepOrange,
                  //   ontap: () {
                  //     AppNavigation.push(context, MyVolunteerHelp());
                  //   },
                  // )
                  MyDoubleIconTextButton(
                    text: 'Brief Help'.tr,
                    image: 'images/brief_icon.png',
                    color: const Color.fromRGBO(255, 87, 34, 1),
                    ontap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Icon(
                              Icons.call,
                              color: Colors.deepOrange,
                              size: 30,
                            ),
                            content: Wrap(children: [
                              Text(
                                  'Your request for brief help call is submitted succesfully, You will be notified shortly'
                                      .tr)
                            ]),
                          );
                        },
                      );

                      // Delay the navigation to the next screen
                      Timer(const Duration(seconds: 3), () {
                        AppNavigation.push(context, MyCall());
                      });
                    },
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  MyDoubleIconTextButton(
                    text: 'Extended Help'.tr,
                    image: 'images/extended_help.png',
                    color: Colors.deepOrange,
                    ontap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Icon(
                              Icons.call,
                              color: Colors.deepOrange,
                              size: 30,
                            ),
                            content: Wrap(children: [
                              Text(
                                  'Your request for extended help call is submitted succesfully, You will be notified shortly'
                                      .tr)
                            ]),
                          );
                        },
                      );

                      // Delay the navigation to the next screen
                      Timer(const Duration(seconds: 3), () {
                        AppNavigation.push(context, MyCall());
                      });
                    },
                  )
                ],
              ),
            ),
          ],
        ),
      ),
      endDrawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: Column(
                children: [
                  Text(
                    'Volunteer'.tr,
                    style: const TextStyle(
                      color: Colors.deepOrange,
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    'emmanuelpriest@gmail.com'.tr,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.edit),
              title: Text('Edit Profile'.tr),
              onTap: () {
                // Handle item 1 press
                AppNavigation.push(context, MyEditProfile());
              },
            ),
            const Divider(),
            LanguageDropdown(),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.logout),
              title: Text('Logout'.tr),
              onTap: () {
                // Handle item 2 press
                AppNavigation.push(context, MySigninScreen());
              },
            ),
            const Divider(),
          ],
        ),
      ),
    );
  }
}
