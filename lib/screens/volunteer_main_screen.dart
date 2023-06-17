import 'package:blind_companion/Assets/Navigation.dart';
import 'package:blind_companion/components/blind_call_request_container.dart';
import 'package:blind_companion/components/languageDropdown.dart';
import 'package:blind_companion/screens/edit_profile.dart';
import 'package:blind_companion/screens/signIn.dart';
import 'package:blind_companion/screens/test_call_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyVolunteerScreen extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final screenHeight = screenSize.height;
    final screenWidth = screenSize.width;
    final User? _user = _auth.currentUser;

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        toolbarHeight: screenHeight * 0.1,
        leading: Image.asset(
          'images/logo.png',
          fit: BoxFit.cover,
        ),
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
                _user?.displayName?.toString().toUpperCase() ?? '',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
              ),
              titleTextStyle: const TextStyle(color: Colors.deepOrange),
              subtitle: Text(
                _user?.email?.toString() ?? '',
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
                  Container(
                    height: screenHeight * 0.06,
                    width: screenWidth * 0.8,
                    decoration: BoxDecoration(
                        color: Colors.orange.shade50,
                        shape: BoxShape.rectangle),
                    child: TextButton(
                        onPressed: () {
                          AppNavigation.push(context, TestCall());
                        },
                        child: Text('Learn to answer a call')),
                  ),
                  Row(
                    children: [
                      Text(
                        'Help Request From Blind'.tr,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: screenWidth * 0.07,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const MyBlindCallRequestContainer(),
                  const SizedBox(
                    height: 20,
                  ),
                  const MyBlindCallRequestContainer(),
                  const SizedBox(
                    height: 20,
                  ),
                  const MyBlindCallRequestContainer(),
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
