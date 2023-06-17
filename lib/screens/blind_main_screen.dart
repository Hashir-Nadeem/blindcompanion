import 'dart:async';
import 'package:blind_companion/Assets/Navigation.dart';
import 'package:blind_companion/components/double_icontextButton.dart';
import 'package:blind_companion/components/languageDropdown.dart';
import 'package:blind_companion/screens/edit_profile.dart';
import 'package:blind_companion/screens/signIn.dart';
import 'package:blind_companion/screens/trace_me_OCR.dart';
import 'package:blind_companion/screens/track_me.dart';
import 'package:blind_companion/screens/volunteer_help.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'call.dart';
import 'ocr.dart';

class MyBlindScreen extends StatefulWidget {
  @override
  _MyBlindScreenState createState() => _MyBlindScreenState();
}

class _MyBlindScreenState extends State<MyBlindScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? _user;

  @override
  void initState() {
    super.initState();
    _user = _auth.currentUser;
  }

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
            icon: const Icon(Icons.menu),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListTile(
              title: Text(
                _user!.displayName.toString().toUpperCase(),
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
              ),
              titleTextStyle: const TextStyle(color: Colors.deepOrange),
              subtitle: Text(
                _user!.email.toString(),
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  color: Colors.black,
                ),
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
                  SizedBox(
                    height: screenHeight * 0.02,
                  ),
                  Card(
                    elevation: 10,
                    child: Container(
                      height: screenHeight * 0.65,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
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
                            const SizedBox(
                              height: 40,
                            ),
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
                                          'Your request for brief help call is submitted successfully. You will be notified shortly'
                                              .tr,
                                        ),
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
                                          'Your request for extended help call is submitted successfully. You will be notified shortly'
                                              .tr,
                                        ),
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
                          ],
                        ),
                      ),
                    ),
                  ),
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
              decoration: BoxDecoration(
                color: Colors.deepOrange, // Customize the background color
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundImage: AssetImage(
                      'images/profile.jpg', // Replace with your image URL
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    _user!.displayName
                        .toString()
                        .toUpperCase(), // Replace with user's name
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: Icon(Icons.edit),
              title: Text(
                'Edit Profile'.tr,
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              onTap: () {
                // Handle item 1 press
                AppNavigation.push(context, MyEditProfile());
              },
            ),
            Divider(
              color: Colors.grey, // Customize the divider color
            ),
            LanguageDropdown(), // Assuming LanguageDropdown is a custom widget
            Divider(
              color: Colors.grey,
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text(
                'Logout'.tr,
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              onTap: () {
                // Handle Logout tap
                AppNavigation.push(context, MySigninScreen());
              },
            ),
            Divider(
              color: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }
}
