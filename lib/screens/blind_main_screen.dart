import 'package:blind_companion/Assets/Navigation.dart';
import 'package:blind_companion/Assets/texts.dart';
import 'package:blind_companion/components/double_icontextButton.dart';
import 'package:blind_companion/screens/edit_profile.dart';
import 'package:blind_companion/screens/signIn.dart';
import 'package:blind_companion/screens/trace_me_OCR.dart';
import 'package:blind_companion/screens/volunteer_help.dart';
import 'package:flutter/material.dart';

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
                AppTexts.volunteer,
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
              ),
              titleTextStyle: const TextStyle(color: Colors.deepOrange),
              subtitle: Text(
                AppTexts.volunteer_email,
                style: TextStyle(
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
                        AppTexts.discover,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ]),
                  SizedBox(
                    height: 30,
                  ),
                  MyDoubleIconTextButton(
                    text: AppTexts.self_help,
                    image: 'images/self_help_icon.png',
                    color: Colors.deepOrange,
                    ontap: () {
                      AppNavigation.push(context, MyTraceMeOcr());
                    },
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  MyDoubleIconTextButton(
                    text: AppTexts.volunteer_help,
                    image: 'images/volunteer_icon.png',
                    color: Colors.deepOrange,
                    ontap: () {
                      AppNavigation.push(context, MyVolunteerHelp());
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
                    AppTexts.volunteer,
                    style: const TextStyle(
                      color: Colors.deepOrange,
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    AppTexts.volunteer_email,
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
              title: Text(AppTexts.edit_profile),
              onTap: () {
                // Handle item 1 press
                AppNavigation.push(context, MyEditProfile());
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.logout),
              title: Text(AppTexts.logout),
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
